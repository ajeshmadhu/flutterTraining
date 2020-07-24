
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSample extends StatefulWidget {
  @override
  _JsonParsingSampleState createState() => _JsonParsingSampleState();
}

class _JsonParsingSampleState extends State<JsonParsingSample> {

  Future data;

  @override
  void initState() {
    super.initState();

    //data = Network("https://jsonplaceholder.typicode.com/posts").fetchData();
    data = getData();
  }

  @override

 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Parsing Json")
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context,AsyncSnapshot<dynamic> snapshot){
              if(snapshot.hasData){
                return createListView(snapshot.data, context);
                                  //return Text(snapshot.data[0]['userId']);
                              }
                              else{
                                return CircularProgressIndicator();
                              }
                           
                            }),
                        )
                      ),
                    );
                  }
                
                  Widget createListView(List data, BuildContext context) {
return Container(
  child: ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, int index){
return Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Divider(height: 5.0,),
ListTile(
  title: Text("${data[index]["title"]}"),
  subtitle:  Text("${data[index]["id"]}"),
  leading: Column(
    children: <Widget>[
      CircleAvatar(backgroundColor: Colors.black26,
      radius: 23,
      child: Text("${data[index]["userId"]}"),
   ),
     ]
)
  
)

]

  );

    })

);
}
}

Future getData() async {
  var data;
  String url = "https://jsonplaceholder.typicode.com/posts";
  Network network = Network(url);

  data = network.fetchData();
  // data.then((value){
  // print(value[0]['title']);
  // });
  
  return data;
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData () async {
    print("$url");
    Response response= await get(Uri.encodeFull(url));

    if(response.statusCode== 200){
       print(response.body) ;
       return json.decode(response.body);
    }else{
      print(response.statusCode);
    }
}}