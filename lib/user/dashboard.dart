import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child:Text("Dashborad",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),) ,
      ),
    );
  }
}
