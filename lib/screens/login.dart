import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    print('username:${userNameController.text}');
    print('password:${passWordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: TextField(
              controller: userNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Username'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: TextField(
              controller: passWordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
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
              onPressed: _onLogin,
            ),
          ),
        ],
      ),
    );
  }
}
