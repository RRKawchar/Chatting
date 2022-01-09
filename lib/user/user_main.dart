

import 'package:chatting/others_auth/loginPage.dart';
import 'package:chatting/user/chang_password.dart';
import 'package:chatting/user/dashboard.dart';
import 'package:chatting/user/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userMain extends StatefulWidget {
  const userMain({Key? key}) : super(key: key);

  @override
  _userMainState createState() => _userMainState();
}

class _userMainState extends State<userMain> {
  int _selectedIndex=0;
  static List<Widget> _widgetOption=<Widget>[
    Dashboard(),
    Profile(),
    ChangePassword(),
  ];
  void _onItemTap(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Welcome user'),
            ElevatedButton(
                onPressed: ()async=>{
                  await FirebaseAuth.instance.signOut(),
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context)=>LoginPage()),
                          (route) => false),
                },
                child: Text('Log out'),
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                )

          ],
        ),
      ),
      body: _widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'Dashborad'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: 'My profile'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
            label: 'Change password',

          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTap,
      ),
    );
  }
}
