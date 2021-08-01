import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/fire_auth.dart';
import 'package:flutter_authen/screens/home.dart';
import 'package:flutter_authen/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                        image: AssetImage('images/logo.png'),
                      ),
                    ),
                    LoginForm(),
                    Container(
                      width: double.infinity,
                      height: 44,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        child: Text('Sign up'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// typedef void BooleanCallback(bool val);

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String? _emailErrorText;
  bool _emailError = false;
  String? _passwordErrorText;
  bool _passwordError = false;

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLogin(context) async {
    _focusEmail.unfocus();
    _focusPassword.unfocus();
    _formKey.currentState!.validate();

    if (_emailError || _passwordError) {
      return;
    } else {
      try {
        setState(() {
          _isProcessing = true;
        });
        User? user = await FireAuth.signInUsingEmailPassword(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
        setState(() {
          _isProcessing = false;
        });

        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isProcessing = false;
        });
        setState(() {
          if (e.code == 'user-not-found') {
            _emailError = true;
            _emailErrorText = 'No user found for that email';
          } else if (e.code == 'wrong-password') {
            _passwordError = true;
            _passwordErrorText = 'Wrong password provided.';
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                focusNode: _focusEmail,
                validator: (value) {
                  setState(() {
                    if (value == null || value.isEmpty) {
                      _emailError = true;
                      _emailErrorText = 'Please fill text';
                    }
                    if (!EmailValidator.validate(value.toString())) {
                      _emailError = true;
                      _emailErrorText = 'Please fill email correctly';
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
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                    errorText: _emailErrorText),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                focusNode: _focusPassword,
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
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    errorText: _passwordErrorText),
              ),
            ),
            Container(
              width: double.infinity,
              height: 44,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                child: Text('Login'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: () => _onLogin(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
