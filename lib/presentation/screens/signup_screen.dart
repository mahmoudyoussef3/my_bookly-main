import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../core/utils/strings.dart';
import '../../core/utils/styles.dart';

final fireBase = FirebaseAuth.instance;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscure = true;

  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool isAuthentication = false;

  TextEditingController eMail = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kPrimaryColor,
          body: Form(
              key: _globalKey,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Color(0xfffbf4ea),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(82),
                                bottomRight: Radius.circular(82))),
                        child: Center(
                          child: Image.asset('assets/images/book-tree.jpg'),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          "MAKTABTY",
                          style: Styles.textStyle14.copyWith(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 4,
                              fontSize: 22,
                              color: const Color(0xfffbf4ea)),
                        ),
                        // Image.asset(
                        //   'assets/images/Logo.png',
                        //   width: 120,
                        // ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        height: 300,
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: const BoxDecoration(
                            color: Color(
                              (0xfffbf4ea),
                            ),
                            //color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(64),
                                bottomLeft: Radius.circular(64))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                // width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  controller: userName,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        value.trim().length < 4) {
                                      return 'Please Enter Valid User Name';
                                    }
                                    return null;
                                  },
                                  cursorColor: kPrimaryColor,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: kPrimaryColor,
                                      ),
                                      labelText: 'User name',
                                      labelStyle:
                                          TextStyle(color: kPrimaryColor),
                                      focusColor: kPrimaryColor,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                // width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  controller: eMail,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please Enter Valid Email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: kPrimaryColor,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.email,
                                        color: kPrimaryColor,
                                      ),
                                      labelText: 'Email',
                                      labelStyle:
                                          TextStyle(color: kPrimaryColor),
                                      focusColor: kPrimaryColor,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                // width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  controller: password,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Password must be at least 6 character';
                                    }
                                    return null;
                                  },
                                  obscureText: obscure ? true : false,
                                  cursorColor: kPrimaryColor,
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscure
                                              ? CupertinoIcons.eye_slash_fill
                                              : Icons.remove_red_eye,
                                          color: kPrimaryColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            obscure = !obscure;
                                          });
                                        },
                                      ),
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: kPrimaryColor),
                                      focusColor: kPrimaryColor,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 150,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                              Color(
                                (0xfffbf4ea),
                              ),
                            )),
                            onPressed: () async {
                              // _validateUser(context);
                              createAccount();
                            },
                            child: isAuthentication
                                ? const CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  )
                                : const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  )),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        child: const Text("Login"),
                        onTap: () => Navigator.pushNamed(context, loginScreen),
                      )
                    ],
                  )
                ],
              ))),
    );

    // Scaffold(
    //   backgroundColor: kPrimaryColor,
    //   body: Form(
    //     key: _globalKey,
    //     child:
    //     Column(
    //       children: [
    //         const Text('Create Your Account'),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         const Text('Explore books to read'),
    //         const SizedBox(
    //           height: 24,
    //         ),
    //         SizedBox(
    //           width: MediaQuery.of(context).size.width / 2,
    //           child: TextFormField(
    //             controller: userName,
    //             validator: (value) {
    //               if (value == null ||
    //                   value.trim().isEmpty ||
    //                   value.trim().length < 4) {
    //                 return 'Please Enter Valid User Name';
    //               }
    //               return null;
    //             },
    //             decoration: const InputDecoration(
    //                 border: OutlineInputBorder(), labelText: 'User Name'),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         SizedBox(
    //           width: MediaQuery.of(context).size.width / 2,
    //           child: TextFormField(
    //             controller: eMail,
    //             validator: (value) {
    //               if (value == null ||
    //                   value.trim().isEmpty ||
    //                   !value.contains('@')) {
    //                 return 'Please Enter Valid Email';
    //               }
    //               return null;
    //             },
    //             keyboardType: TextInputType.emailAddress,
    //             autocorrect: false,
    //             textCapitalization: TextCapitalization.none,
    //             decoration: const InputDecoration(
    //               border: OutlineInputBorder(),
    //               labelText: 'Email Address',
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 12,
    //         ),
    //         SizedBox(
    //           width: MediaQuery.of(context).size.width / 2,
    //           child: TextFormField(
    //             controller: password,
    //             validator: (value) {
    //               if (value == null || value.trim().length < 6) {
    //                 return 'Password must be at least 6 character';
    //               }
    //               return null;
    //             },
    //             obscureText: true,
    //             decoration: const InputDecoration(
    //               border: OutlineInputBorder(),
    //               labelText: 'Password',
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 32,
    //         ),
    //         SizedBox(
    //           height: 30,
    //           width: 100,
    //            child: ElevatedButton(
    //               onPressed: () {
    //                 createAccount();
    //               },
    //               child: isAuthentication
    //                   ? const Center(
    //                       child: CircularProgressIndicator(),
    //                     )
    //                   : const Text(
    //                       "Sign Up",
    //                       style: TextStyle(color: Colors.black),
    //                     )),
    //         )
    //       ],
    //     ),
    //   ));
  }

  bool validateCreateAccount(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      //  Navigator.pushReplacementNamed(context, homeScreen);
    }
    return _globalKey.currentState!.validate();
  }

  void createAccount() async {
    if (validateCreateAccount(context)) {
      _globalKey.currentState!.save();
      setState(() {
        isAuthentication = true;
      });
      try {
        final userCredential = await fireBase.createUserWithEmailAndPassword(
            email: eMail.text, password: password.text);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'userName': userName.text,
          'eMail': eMail.text,
          'isActivated': false
        });
        Navigator.pushReplacementNamed(context, loginScreen);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xfffbf4ea),
            content: Text(error.message ?? 'Authentication Failed')));
        setState(() {
          isAuthentication = false;
        });
      }
    }
  }
}
