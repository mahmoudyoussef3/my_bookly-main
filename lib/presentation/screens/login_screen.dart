import 'package:bookly/presentation/screens/admin_screens/admin_home_screen.dart';
import 'package:bookly/presentation/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../core/utils/strings.dart';
import '../../core/utils/styles.dart';
import 'admin_screens/add_new_book.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;

  final _formKey = GlobalKey<FormState>();
  bool isAuthentication = false;

  TextEditingController eMail = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kPrimaryColor,
          body: SingleChildScrollView(
            child: Form(
                key: _formKey,
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
                          height: 230,
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
                                    controller: eMail,
                                    validator: (value) {
                                      if (eMail.text.isEmpty) {
                                        return "Enter a valid email!";
                                      }
                                      // else {
                                      //   return null;
                                      // }
                                    },
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
                                            borderSide: BorderSide(
                                                color: kPrimaryColor)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPrimaryColor),
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width / 2,
                                  child: TextFormField(
                                    cursorColor: kPrimaryColor,
                                    controller: password,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                    obscureText: obscure ? true : false,
                                    validator: (value) {
                                      if (password.text.isEmpty) {
                                        return "Enter a value!";
                                      }
                                      // else {
                                      //   return null;
                                      // }
                                    },
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
                                        focusColor: kPrimaryColor,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPrimaryColor)),
                                        labelStyle:
                                            TextStyle(color: kPrimaryColor),
                                        labelText: 'Password',
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPrimaryColor),
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
                                await login(context);
                              },
                              child: isAuthentication
                                  ? const CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    )
                                  : const Text(
                                      "Login",
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
                          child: const Text("Create an account"),
                          onTap: () =>
                              Navigator.pushNamed(context, signupScreen),
                        )
                      ],
                    )
                  ],
                )),
          )),
    );
  }

  bool _validateUser(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      //Navigator.pushReplacementNamed(context, homeScreen);
    }
    return _formKey.currentState!.validate();
  }

  login(BuildContext context) async {
    if (_validateUser(context)) {
      setState(() {
        isAuthentication = true;
      });

      try {
        final userCredential = await fireBase.signInWithEmailAndPassword(
            email: eMail.text, password: password.text);
        if (eMail.text == "admin@email.com") {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return AdminHomeScreen();
            },
          ), (route) => false);
          // Navigator.pushReplacementNamed(context, adminHomeScreen);
        } else {
          QuerySnapshot querySnapshot = await _firebaseFirestore
              .collection('users')
              .where('eMail', isEqualTo: eMail.text)
              .limit(1)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            // Use the first document in the query result
            DocumentSnapshot userSnapshot = querySnapshot.docs.first;
            bool isActivated = userSnapshot['isActivated'] ?? false;
            // bool isActivated = querySnapshot['isActivated'] ?? false;

            if (isActivated) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                usersHomeScreen,
                (route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                notActivated,
                (route) => false,
              );
            }
          } else {
            // Handle the case when the user does not exist
            // Show an error message or perform necessary actions
            print('User not found');
            setState(() {
              isAuthentication = false;
            });
          }
        }
//          Navigator.pushReplacementNamed(context, usersHomeScreen);

        // Navigator.pushReplacementNamed(context, homeScreen);
        // .then(
        //     (value) => Navigator.pushReplacementNamed(context, homeScreen));
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
