// import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;


main()async {
  await fill_gallery();
}


fill_gallery() async{
  
  var url = Uri.http('localhost:8080', '/kennels/1');
  var response = await http.get(url);
  print(jsonDecode(response.body));
  // var request = HttpRequest();
  // request.open('GET','localhost:8080/kennels/1');
  
}
