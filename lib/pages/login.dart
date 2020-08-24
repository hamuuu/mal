import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:mal/model/mal_account.dart';
import 'package:mal/providers/auth.dart';
import 'package:mal/providers/mal_account_provider.dart';
import 'package:provider/provider.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

Future<void> _googleLogin(BuildContext context) async {
  try {
    await _googleSignIn.signIn().then((value) {
      Provider.of<Auth>(context, listen: false)
          .addAccount(value, _googleSignIn);
      Provider.of<MalAccountProvider>(context, listen: false).removeAccount();
      if (value != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  } catch (e) {
    print(e);
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackgroundImage(),
          FormLogin(),
        ],
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Logo(),
              SizedBox(height: 30),
              FormTextField(
                label: 'Username',
                obscure: false,
              ),
              SizedBox(height: 30),
              FormTextField(
                label: 'Password',
                obscure: true,
              ),
              SizedBox(height: 20),
              ActionButton(),
              SizedBox(height: 40),
              LoginMethod()
            ],
          ),
        ),
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  final String label;
  final bool obscure;

  const FormTextField({
    Key key,
    this.label,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      obscureText: obscure,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
        image: DecorationImage(image: AssetImage('assets/logo.png')),
      ),
    );
  }
}

class LoginMethod extends StatelessWidget {
  const LoginMethod({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          right: 8.0,
          left: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Login with',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ButtonTheme(
              minWidth: 30,
              height: 50,
              child: FlatButton(
                onPressed: () {
                  _googleLogin(context);
                },
                child: Image(
                  image: NetworkImage(
                    'https://pngimg.com/uploads/google/google_PNG19630.png',
                  ),
                  height: 30,
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 30,
              height: 50,
              child: FlatButton(
                onPressed: () {},
                child: Image(
                  image: NetworkImage(
                    'https://image.flaticon.com/icons/png/512/124/124010.png',
                  ),
                  height: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: [
        RaisedButton(
          color: Colors.blue,
          onPressed: () {},
          child: Text('Login'),
        ),
        FlatButton(
          color: Colors.red,
          onPressed: () {},
          child: Text(
            'Clear',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg-login.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      // child: BackdropFilter(
      //   filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
      //   child: new Container(
      //     decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
      //   ),
      // ),
    );
  }
}
