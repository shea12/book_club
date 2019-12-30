import 'package:http/http.dart' show Client;
import 'package:book_club/models/item_model.dart';
import 'dart:convert';

class ApiProvider {
  Client client = Client();
  fetchPosts() async {
    final response = await client.get("https://jsonplaceholder.typicode.com/posts/1");
    ItemModel itemModel = ItemModel.fromJson(json.decode(response.body));
    return itemModel;
  }
}