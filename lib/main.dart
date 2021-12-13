import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var data ;
  Future getData()async {
    var response= await http.get(Uri.parse("http://itechnotion.in/wp-news/wp-json/wp/v2/posts?fbclid=IwAR1gnOZ-OdPzJZgASuSwVadPwvzLg5X8k8wLxSM2rbx5KBnzZ31LSLdEo60"));
    setState(() {
      var decode = json.decode(response.body);
      data=decode;
      print(data);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News API'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: data==null?0:data.length,

          itemBuilder: (context, index){
            return Column(
              children: [
                ListTile(
                  title: Text(data[0]["title"]["rendered"]),
                ),
                Container(
             child : Image.network(data[0]["featured_image_link"]),

                ),
                Center(
                  child: Text(data[0]["content"]["rendered"]),
                ),
                Center(
               child:   Text(data[0]["date"]),
                ),

              ],
            );
          } ),
    );
  }
}