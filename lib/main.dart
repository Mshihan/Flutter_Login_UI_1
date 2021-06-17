import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _backgroundColor = Color(0xFFFBF7F8);
  var _textColor = Color(0xFF40284A);
  int _pageState = 0;
  double width;
  double height;
  double _loginYOffset = 0;
  double _registerYOffset = 0;
  double _loginXOffset = 0;
  double _loginWidth = 0;
  double _loginOpacity = 1;
  double _headingTopOffset = 100;
  bool _keyboardState;

  @override
  void initState() {
    super.initState();
    _keyboardState = KeyboardVisibility.isVisible;
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        _keyboardState = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    switch (_pageState) {
      case 0:
        _backgroundColor = Color(0xFFFBF7F8);
        _textColor = Color(0xFF40284A);
        _loginYOffset = height;
        _registerYOffset = height;
        _loginXOffset = 0;
        _loginWidth = width;
        _loginOpacity = 1;
        _headingTopOffset = 100;
        break;
      case 1:
        _backgroundColor = Color(0xFFB5213C);
        _textColor = Colors.white;
        _loginYOffset = _keyboardState == true ? 40 : 370;
        _registerYOffset = height;
        _loginXOffset = 0;
        _loginWidth = width;
        _loginOpacity = 1;
        _headingTopOffset = 80;
        break;
      case 2:
        _backgroundColor = Color(0xFFB5213C);
        _textColor = Colors.white;
        _loginYOffset = 340;
        _registerYOffset = _keyboardState == true ? 40 : 370;
        _loginXOffset = 20;
        _loginWidth = width - 40;
        _loginOpacity = 0.9;
        _headingTopOffset = 70;
        break;
    }

    Future<bool> _onWillPop() async {
      if (_pageState != 0) {
        setState(() {
          _pageState--;
        });
      }
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _pageState = 0;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              color: _backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            margin: EdgeInsets.only(top: _headingTopOffset),
                            child: Text(
                              "Learn Free",
                              style: GoogleFonts.sriracha(
                                fontSize: 50,
                                color: _textColor,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "We make learning easy. MoonWalk Software is to learn flutter Free on youtube.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.greatVibes(
                                color: _textColor,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Image.asset(
                        'assets/images/preview.png',
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            if (_pageState != 0) {
                              _pageState = 0;
                            } else {
                              _pageState = 1;
                            }
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF40284A),
                        ),
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: Text(
                          "Get Started",
                          style: GoogleFonts.sriracha(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            width: _loginWidth,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(_loginOpacity),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            transform:
                Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Center(
                      child: Text(
                        'Login to Continue',
                        style: GoogleFonts.sriracha(fontSize: 25),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InputTextField(
                        inputFieldText: 'Enter Email',
                        icon: Icons.email,
                        obscureText: false,
                      ),
                      InputTextField(
                        inputFieldText: 'Enter Password',
                        icon: Icons.lock_outline,
                        obscureText: false,
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      PrimaryButton(
                        function: () {
                          setState(() {
                            _pageState = 1;
                          });
                        },
                        btnText: 'Login',
                      ),
                      OutlineButton(
                        function: () {
                          setState(() {
                            _pageState = 2;
                          });
                        },
                        btnText: 'Create Account',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Center(
                          child: Text(
                            'Create a New Account',
                            style: GoogleFonts.sriracha(fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        inputFieldText: 'Email',
                        icon: Icons.email,
                        obscureText: false,
                      ),
                      InputTextField(
                        inputFieldText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  PrimaryButton(
                    function: () {
                      setState(() {
                        _pageState = 2;
                      });
                    },
                    btnText: 'Create Account',
                  ),
                  OutlineButton(
                    function: () {
                      setState(() {
                        _pageState = 1;
                      });
                    },
                    btnText: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  PrimaryButton({this.btnText, this.function});

  final Function function;
  final String btnText;

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFF40284A),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            widget.btnText,
            style: GoogleFonts.sriracha(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineButton extends StatefulWidget {
  OutlineButton({this.btnText, this.function});

  final Function function;
  final String btnText;

  @override
  _OutlineButtonState createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color(0xFF40284A), width: 2),
        ),
        child: Center(
          child: Text(
            widget.btnText,
            style: GoogleFonts.sriracha(
              fontSize: 16,
              color: Color(0xFF40284A),
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextField extends StatefulWidget {
  InputTextField({this.icon, this.inputFieldText, this.obscureText});

  final String inputFieldText;
  final IconData icon;
  final bool obscureText;

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        enableInteractiveSelection: true,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          prefixIcon: Icon(
            widget.icon,
            color: Colors.grey,
          ),
          hintText: widget.inputFieldText,
        ),
      ),
    );
  }
}
