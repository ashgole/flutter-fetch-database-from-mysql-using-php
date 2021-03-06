import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

  @override
  void initState() {
    super.initState();
    _ShowJsonList();
  }

class _DemoPageState extends State<Home> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //--*
  Future<List<ShowJson>> _ShowJsonList() async { 
    // #change
    //open xampp server
    // start php and mysql server
    // create folder #home in htdocs folder of xampp server
    // paste #home.php file
    var data = await http.get("http://<your comuter ip address>/home/home.php");
    
    var jsonData = json.decode(data.body);
    List<ShowJson> cJF1 = [];
    for (var i in jsonData) {
      ShowJson cJF2 = ShowJson(i["userid"], i["phone"]);
      cJF1.add(cJF2);
    }
    return cJF1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _ShowJsonList,
          child: Container(
              child: FutureBuilder(
                  future: _ShowJsonList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Text(snapshot.data[index].userid),
                                Text(snapshot.data[index].phone),
                                Divider(),
                              ],
                            );
                          });
                    }
                  }))),
    );
  }
}

//-------------*
class ShowJson{
  final String userid;
  final String phone;
  ShowJson(this.userid,this.phone);
}
