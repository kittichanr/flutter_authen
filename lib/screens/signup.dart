import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/fire_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  void _onSignUp(context) async {
    try {
      setState(() {
        _isProcessing = true;
      });
      User? user = await FireAuth.registerUsingEmailPassword(
          name: _nameController.text,
          email: _emailController.text,
          password: _passWordController.text);
      setState(() {
        _isProcessing = false;
      });
      if (user != null) {
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "SignUp",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _isProcessing
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: TextField(
                          focusNode: _focusName,
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Name'),
                        ),
                      ),
                      Container(
                        child: TextField(
                          focusNode: _focusEmail,
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Email'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: TextField(
                          obscureText: true,
                          focusNode: _focusPassword,
                          controller: _passWordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 44,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ElevatedButton(
                          child: Text('signup'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                          onPressed: () {
                            _onSignUp(context);
                          },
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
