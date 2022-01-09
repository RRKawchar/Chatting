import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid=FirebaseAuth.instance.currentUser!.uid;
  final email=FirebaseAuth.instance.currentUser!.email;
  final creationTime=FirebaseAuth.instance.currentUser!.metadata.creationTime;
  User? user=FirebaseAuth.instance.currentUser;

  verifyEmail() async {
   if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
     }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(

     children: [
       Text("User Id : $uid",
       style: TextStyle(fontSize: 18.0),
         ),
        SizedBox(height: 20,),
           Text("Email:$email",
           style: TextStyle(fontSize: 18.0),
           ),
           user!.emailVerified?Text('Varified',
           style: TextStyle(fontSize: 18.0),
           ):
           Padding(
             padding: const EdgeInsets.only(left: 150.0),

             child: TextButton(

                 onPressed: (){
                   verifyEmail();
                 },
                 child: Text("Varify Email")
             ),
           ),

       Text("Created:$creationTime",
       style: TextStyle(fontSize: 18.0),
       )
     ],
      ),
    );
  }
}
