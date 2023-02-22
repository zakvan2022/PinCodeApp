
import 'package:flutter/material.dart';
import 'package:secourty_pincode/lock_pincode.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  int length = 6;

  onChange(String number){
    if(number.length == length){
      // TODO
    }
    print(number);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Pin code Setup'),
      //ExampleHomePage(title:'Pin code Setup',)
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key ?key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int length = 4;

  onChange(String number){
    if(number.length == length){
      // TODO
    }
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: false?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            MyLockPinCode(length: length, onChange: onChange,)
          ],
        ),
      ):MyLockPinCode(length: length, onChange: onChange,),
    );
  }
}



