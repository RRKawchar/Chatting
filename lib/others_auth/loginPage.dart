
import 'package:chatting/others_auth/sign_up.dart';
import 'package:chatting/user/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _formKey=GlobalKey<FormState>();

var _email='';
var _password='';
final emailController=TextEditingController();
final passwordController=TextEditingController();
void dispose(){
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
userlogin() async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => userMain(),

      ),

    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print("No User Found for that Email");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    } else if (e.code == 'wrong-password') {
      print("Wrong Password Provided by User");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Wrong Password Provided by User",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Form(
        key: _formKey,
          child: ListView(


            children: [
         SizedBox(height: 30,),
              Center(
                child: Container(

                  padding: EdgeInsets.only(top: 30,),
                  child: Text('Log-in',
                  style: TextStyle(fontSize: 30,
                  color: Colors.lightBlue,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),
              SizedBox(height: 150,),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                autofocus: false,
                  controller: emailController,
                      validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please Enter Email';
                  }else if(!value.contains('@')){
                    return 'Please Enter valid email';
                  }
                  return null;
                      },
                style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.white70),
                    label: Text('Email',
                      style: TextStyle(color: Colors.white70),),

                    border: OutlineInputBorder(),


                  ),


                ),
              ),
              SizedBox(height: 40.0,),
              TextFormField(


                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white70),
                  label: Text('Password',
                    style: TextStyle(color: Colors.white70),),

                  border: OutlineInputBorder(),


                ),
                controller: passwordController,
                validator: (value){
                   if(value==null || value.isEmpty){
                     return 'Please Enter Password';
                   }
                   return null;
                },

                autofocus: false,
                 obscureText: true,

              ),

              Padding(
                padding: const EdgeInsets.only(left: 200.0),
                child: TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/forgetPass');
                    },
                    child: Text('Forget Password',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    )
                ),
              ),

              Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30.0),

                   ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton(

                       onPressed: (){
                         if(_formKey.currentState!.validate()){
                           setState(() {
                             _email=emailController.text;
                             _password=passwordController.text;
                           });
                           userlogin();

                         }

                       },
                       child: Text('Log-In',
                       style: TextStyle(color: Colors.white,fontSize: 20.0),
                       )
                   ),

                 ],
                ),
              ),
                  SizedBox(height: 50,),
                  Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text("Sign_Up",
                          style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                          )
                      )
                    ],
                  ),

              ),
            ],
          ),
        ),
      ),


    );
  }
}
