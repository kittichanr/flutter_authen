import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authen/providers/UserProvider.dart';
import 'package:flutter_authen/screens/login.dart';
import 'package:provider/provider.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              width: double.infinity,
              child: Text(
                'Welcome back! ${userProvider.userName}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(width: 0.5, color: Colors.grey))),
            child: ListTile(
              title: const Text(
                'Logout',
                textAlign: TextAlign.center,
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
