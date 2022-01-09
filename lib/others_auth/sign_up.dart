import 'package:chatting/others_auth/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpTest extends StatefulWidget {
  const SignUpTest({Key? key}) : super(key: key);

  @override
  _SignUpTestState createState() => _SignUpTestState();
}

class _SignUpTestState extends State<SignUpTest> {
  final _formKey=GlobalKey<FormState>();

  var _email="";
  var _password="";
  var _confirmPass="";

  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPassController=TextEditingController();

  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
  registration() async {
    if (_password == _confirmPass) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully. Please Login..",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    } else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      );
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
                  child: Text('Sign-In',
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
              SizedBox(height: 40.0,),
              TextFormField(


                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white70),
                  label: Text('Confirm Password',
                    style: TextStyle(color: Colors.white70),),

                  border: OutlineInputBorder(),


                ),
                controller: confirmPassController,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please Enter ConfirmPassword';
                  }
                  return null;
                },

                autofocus: false,
                obscureText: true,

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
                              _password=passwordController.text;
                              _confirmPass=confirmPassController.text;
                            });
                            registration();
                          }
                        },
                        child: Text('Sign-Up',
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
                    Text("Already have an account?",
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text("Log-in",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
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
