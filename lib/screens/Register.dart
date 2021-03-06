import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vcare/DocDetail.dart';
import 'package:vcare/HomeScreen.dart';
import 'package:vcare/Shared_pref.dart';
import 'package:vcare/screens/Login.dart';

class Register extends StatefulWidget {
    @override
    _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

    TextEditingController emailCon = new TextEditingController();
    TextEditingController passCon = new TextEditingController();

    FocusNode node = new FocusNode();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.teal,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(10),
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(10)
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage('images/VCare.jpg'),
                                ),
                                Text(
                                    'VCare',
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: 40.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                Text(
                                    'Virtual Health CheckUp',
                                    style: TextStyle(
                                        fontFamily: 'Source Sans Pro',
                                        color: Colors.teal.shade100,
                                        fontSize: 20.0,
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                SizedBox(
                                    height: 20.0,
                                    width: 150.0,
                                    child: Divider(
                                        color: Colors.teal.shade100,
                                    ),
                                ),

                                TextFormField(
                                    controller: emailCon,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    onEditingComplete: () {
                                        node.requestFocus();
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Enter your email id',
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),
                                TextFormField(
                                    controller: passCon,
                                    focusNode: node,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(15),
                                    ),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        labelText: 'Enter the Password',
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(15),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                                            email: emailCon.text.toString(),
                                            password: passCon.text.toString(),
                                        ).then((UserCredential user) {
                                            SharedPref.setUser(user.user.email, true, false);
                                            FirebaseFirestore.instance
                                                    .collection("Patients")
                                                    .doc(emailCon.text)
                                                    .set({
                                                "Created on:": DateTime.now(),
                                            });
                                            Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                                        }).catchError((e){
                                            Fluttertoast.showToast(msg: e.message);
                                        });
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Text(
                                            'Register as Patient',
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(20),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                                            email: emailCon.text.toString(),
                                            password: passCon.text.toString(),
                                        ).then((UserCredential user) {
                                            SharedPref.setUser(user.user.email, true, true);
                                            Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => DocDetail(),), (route) => false);
                                        }).catchError((e){
                                            Fluttertoast.showToast(msg: e.message);
                                        });
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Text(
                                            'Register as Doctor',
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(20),
                                            ),
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                ),

                                FlatButton(
                                    onPressed: () {
                                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => Login(),), (route) => false);
                                    },
                                    child: Text(
                                        "Existing user? Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                ),

                                SizedBox(
                                    height: ScreenUtil().setHeight(240),
                                ),

                                Text(
                                    "Your Health, Our Priority",
                                    style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Source Sans Pro',
                                            fontSize: ScreenUtil().setSp(20)
                                    ),
                                ),

                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
