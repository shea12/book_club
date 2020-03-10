import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Firestore db = Firestore.instance;

class HomeNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemYellow,
        middle: Title(
          color: CupertinoColors.black,
          child: Text('BookClub'),
        ),
        trailing: GestureDetector(
          onTap: () async {},
          child: Icon(
            CupertinoIcons.settings,
            color: CupertinoColors.black,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(20.0),
            height: 100,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(
                new Radius.circular(20.0),
              ),
              border:
                  Border.all(color: CupertinoColors.activeOrange, width: 4.0),
            ),
            child: CupertinoButton(
              child: new Text("Create New Item"),
              onPressed: () {
                db.runTransaction(
                  (Transaction transaction) async {
                    CollectionReference reference =
                        db.collection('flutter_data');
                    await reference
                        .add({"title": "", "editing": false, "score": 0});
                  },
                );
              },
            ),
          ),
          Container(
            height: 400,
            child: StreamBuilder(
              stream: db.collection('flutter_data').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CupertinoActivityIndicator();
                return FirestoreListView(docs: snapshot.data.documents);
              },
            ),
          )
        ],
      ),
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> docs;

  FirestoreListView({this.docs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: docs.length,
        itemExtent: 110.0,
        itemBuilder: (BuildContext context, int index) {
          String title = docs[index].data['title'].toString();
          int score = docs[index].data['score'];
          bool editing = docs[index].data['editing'] ?? false;

          return ListTile(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.white),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: !editing
                        ? Text(title)
                        : TextFormField(
                            initialValue: title,
                            onFieldSubmitted: (String item) {
                              db.runTransaction(
                                (transaction) async {
                                  DocumentSnapshot ds = await transaction
                                      .get(docs[index].reference);
                                  await transaction.update(
                                    ds.reference,
                                    {'title': item},
                                  );
                                  await transaction.update(
                                    ds.reference,
                                    {"editing": !ds['editing']},
                                  );
                                },
                              );
                            },
                          ),
                  ),
                  Text("$score"),
                  Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          db.runTransaction(
                            (Transaction transaction) async {
                              DocumentSnapshot ds =
                                  await transaction.get(docs[index].reference);
                              await transaction.update(
                                ds.reference,
                                {'score': ds['score'] + 1},
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.arrow_upward),
                      ),
                      IconButton(
                        onPressed: () {
                          db.runTransaction(
                            (Transaction transaction) async {
                              DocumentSnapshot ds =
                                  await transaction.get(docs[index].reference);
                              await transaction.update(
                                ds.reference,
                                {'score': ds['score'] - 1},
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      db.runTransaction(
                        (transaction) async {
                          DocumentSnapshot ds =
                              await transaction.get(docs[index].reference);
                          await transaction.delete(ds.reference);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            onTap: () => db.runTransaction(
              (Transaction transaction) async {
                DocumentSnapshot ds =
                    await transaction.get(docs[index].reference);
                await transaction.update(
                  ds.reference,
                  {"editing": !ds["editing"]},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
