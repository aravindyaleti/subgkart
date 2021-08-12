import 'dart:async';

import 'package:flutter/material.dart';
import 'package:subgkart/home.dart';
import 'package:subgkart/select_region.dart';
import 'package:subgkart/services/auth_provider.dart';

import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SubGKart',
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final constrainedTextScaleFactor =
        mediaQueryData.textScaleFactor.clamp(1.0, 1.5);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaleFactor: constrainedTextScaleFactor,
          ),
          child: child,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future _getData() async{
    await UserProvider.getUser();
    await UserProvider.getRegion();

    Timer(Duration(seconds: 5), (){
      if(UserProvider.user!=null){
        if(UserProvider.pincode!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SelectRegion()));
        }

      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Login()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}
