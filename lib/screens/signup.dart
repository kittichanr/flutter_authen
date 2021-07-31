import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/fire_auth.dart';
import 'package:email_validator/email_validator.dart';

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

  final _formKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  String? _nameErrorText;
  bool _nameError = false;
  String? _emailErrorText;
  bool _emailError = false;
  String? _passwordErrorText;
  bool _passwordError = false;

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
    _formKey.currentState!.validate();
    if (_nameError && _emailError && _passwordError) {
      return;
    } else {
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
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            validator: (value) {
                              setState(() {
                                if (value == null || value.isEmpty) {
                                  _nameError = true;
                                  _nameErrorText = 'Please fill text';
                                }
                                return null;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _nameError = false;
                                _nameErrorText = null;
                              });
                            },
                            focusNode: _focusName,
                            controller: _nameController,
                            decoration: InputDecoration(
                                errorText: _nameErrorText,
                                border: OutlineInputBorder(),
                                labelText: 'Name'),
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            validator: (value) {
                              setState(() {
                                if (value == null || value.isEmpty) {
                                  _emailError = true;
                                  _emailErrorText = 'Please fill text';
                                }
                                if (!EmailValidator.validate(
                                    value.toString())) {
                                  _emailError = true;
                                  _emailErrorText =
                                      'Please fill email correctly';
                                }
                                return null;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _emailError = false;
                                _emailErrorText = null;
                              });
                            },
                            focusNode: _focusEmail,
                            controller: _emailController,
                            decoration: InputDecoration(
                                errorText: _emailErrorText,
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            validator: (value) {
                              setState(() {
                                if (value == null || value.isEmpty) {
                                  _passwordError = true;
                                  _passwordErrorText = 'Please fill text';
                                }
                                return null;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _passwordError = false;
                                _passwordErrorText = null;
                              });
                            },
                            obscureText: true,
                            focusNode: _focusPassword,
                            controller: _passWordController,
                            decoration: InputDecoration(
                                errorText: _passwordErrorText,
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
      ),
    );
  }
}
