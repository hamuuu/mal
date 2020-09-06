import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
          // BackgroundImage(),

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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://www.edlanews.com/wp-content/uploads/2019/01/white-background-geo-shapes.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: DiagonalPathClipperTwo(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.lightBlue[800],
                      Colors.lightBlue[100],
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Logo(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Sign In',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FormTextField(
                            label: 'Username',
                            obscure: false,
                          ),
                          SizedBox(height: 30),
                          FormTextField(
                            label: 'Password',
                            obscure: true,
                          ),
                          SizedBox(height: 15),
                          ActionButton(),
                        ],
                      ),
                    ),

                    // LoginMethod()
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipperOne(reverse: true),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.lightBlue[800],
                      Colors.lightBlue[100],
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: LoginMethod(),
                  ),
                ),
              ),
            ),
          ],
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
      cursorColor: Colors.black,
      obscureText: obscure,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 3,
        ),
        labelStyle: TextStyle(
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue[200]),
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
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/bee-logo.png')),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonTheme(
          buttonColor: Colors.white,
          minWidth: 30,
          child: FlatButton(
            onPressed: () {
              _googleLogin(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Sign in with Google    '),
                    Image(
                      image: AssetImage(
                        'assets/login_page/google.png',
                      ),
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
      buttonMinWidth: 200,
      buttonHeight: MediaQuery.of(context).size.height * 0.07,
      alignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.lightBlue[400],
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Continue',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
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
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: AssetImage('assets/bg-login.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.dstATop),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
