import 'package:chatting/others_auth/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey=GlobalKey<FormState>();
  var _newPass="";
  final newPasswordController=TextEditingController();
  void dispose(){
    newPasswordController.dispose();
    super.dispose();
  }
  final currenUser=FirebaseAuth.instance.currentUser;
  changePassword()async{
    try{
      await currenUser!.updatePassword(_newPass);
      FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orangeAccent,
          content:
      Text('Your password has been changed.Login agin !',
      style: TextStyle(fontSize: 18.0),
      )
      )
      );
    }catch(e){}

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child:TextFormField(
             autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                    label: Text("New Passowrd"),
                    hintText: 'Enter new Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent,fontSize: 15)
                ),
                controller: newPasswordController,
                validator: (value){
               if(value==null || value.isEmpty){
                 return 'Please Enter password';
               }
               return null;
                },
              ),
            ),

            ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      _newPass=newPasswordController.text;
                    });
                    changePassword();

                  }
                },
                child: Text('Change password')
            )
          ],
        ),
      ),

    );
  }
}
