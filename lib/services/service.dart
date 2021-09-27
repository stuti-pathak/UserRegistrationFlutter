import 'package:http/http.dart' as http;

registerUser(data) async {
  var response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      body: data);
  print(response.body);
}
