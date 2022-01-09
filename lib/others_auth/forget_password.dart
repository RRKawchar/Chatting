

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  var _email="";

  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Password Reset Email has been sent !',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'No user found for that email.',
              style: TextStyle(fontSize: 18.0),
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
                  child: Text('Reset Password',
                    style: TextStyle(fontSize: 30,
                        color: Colors.lightBlue,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80.0,),
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
              SizedBox(height: 50.0,),
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

                            });
                            resetPassword();
                          }
                        },
                        child: Text('Send Email',
                          style: TextStyle(color: Colors.white,fontSize: 20.0),
                        )
                    ),
                    SizedBox(width: 20.0,),
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Login',style: TextStyle(fontSize: 20.0,
                        color: Colors.white
                        ),)
                    )

                  ],
                ),


              ),
              SizedBox(height: 50,),
              Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: Text("Sign_Up")
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
