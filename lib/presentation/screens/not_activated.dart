import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/utils/strings.dart';

class NotActivated extends StatelessWidget {
  const NotActivated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, loginScreen);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: const Center(
        child: Text(
          "Wait activation... !",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 3),
        ),
      ),
    );
  }
}
