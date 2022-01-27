// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

var news = []; //database

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  getNews() async {
    var apikey = "b4570fce63a644ca8093261547f32d15";
    var baseurl = "https://newsapi.org/v2/everything?q=laptop&";
    var url = Uri.parse("$baseurl?q&apikey=$apikey");
    var response = await http.get(url);
    // ignore: avoid_print
    print(response.body);
    // ignore: avoid_print
    print(response.body.runtimeType);
    var jsonResponse = convert.jsonDecode(response.body);
    // ignore: avoid_print
    print(jsonResponse.length);

    setState(() {
      news = jsonResponse["articles"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Center(
            child: Text(
              "News",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
        ),
        // ignore: prefer_is_empty
        body: news.length > 0
            ? ListView.builder(
                // padding: const EdgeInsets.all(5),
                itemCount: news.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            //   width: 250,
                            child: Text(news[index]["source"]['name'],
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            //   width: 250,
                            child: Text(news[index]["title"],
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrangeAccent)),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            //   width: 250,
                            child: Text(news[index]["description"],
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            //   width: 250,
                            child:
                                Image.network("${news[index]["urlToImage"]}"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(Icons.thumb_up, color: Colors.black),
                                    Icon(Icons.message, color: Colors.black),
                                    Icon(Icons.share, color: Colors.black),
                                  ],
                                ),
                                Icon(
                                  Icons.bookmark,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                })
            : Center(child: Text("No data found")));
  }
}
