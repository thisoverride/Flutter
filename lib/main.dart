import 'package:flutter/material.dart';
import 'wp-api.dart';
import 'package:html/parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wesportfr',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wesportfr')),
      body: Container(
        child: FutureBuilder(
            future: fetchWpPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map wppost = snapshot.data[index];
                    var imageurl = wppost["_embedded"]["wp:featuredmedia"][0]
                        ["source_url"];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 10, bottom: 10),
                              child: Image.network(imageurl),
                            ),
                            //FadeInImage.assetNetwork(placeholder: null,
                            //image: imageurl),
                            Text(parse(wppost['title']['rendered'].toString()).documentElement.text,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                )),

                            Text(parse(wppost['excerpt']['rendered'].toString()).documentElement.text),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              
              return CircularProgressIndicator();
            }),
            
      ),
      
    );
  }
}
