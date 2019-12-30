import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:book_club/api_provider.dart';

void main() {
  test("Testing the network call", () async {
    //setup the test
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient((request) async {
      final mapJson = {'id': 123};
      return Response(json.encode(mapJson), 200);
    });
    final item = await apiProvider.fetchPosts();
    expect(item.id, 123);
  });
}
