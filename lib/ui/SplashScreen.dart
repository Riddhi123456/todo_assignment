import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_assignment/ui/PersonalListing.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }

}
class SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonalListing()));
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontStyle: FontStyle.normal),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'To Do App',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
