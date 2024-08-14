import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log_in/widgets/home.dart';
import 'package:log_in/widgets/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreen();
  }
}

enum ValidationType {
  emailid,
  password,
}

class _LoginScreen extends State<LoginScreen> {
  //[ add with SingleTickerProviderStateMixin  ]with: Classes can only mix in mixins and classes. for multiple animations use TickerProviderStateMixin

//for TestFormField
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController pswd = TextEditingController();

  // for crircular animation
  // late AnimationController homeloader;

  // for displaying errormsg using onChange
  String? _emailerror;
  String? _pswrderror;

// for displaying pswrd
  bool _displayingConfirm = true;
  bool _displayingPswrd = true;

  @override
  void dispose() {
    email.dispose();
    pswd.dispose();
    // homeloader.dispose();
    super.dispose();
  }

  //shared_preferences
  @override
  void initState() {
    super.initState();
    // homeloader = AnimationController(
    //   vsync:
    //       this, //here this is SingleTickerProviderStateMixin , used to execute the animation for every frame(60 times per second)
    //   duration: const Duration(milliseconds: 300),
    //   lowerBound:
    //       0, //The value at which this animation is deemed to be dismissed.
    //   upperBound:
    //       1, //The value at which this animation is deemed to be completed.
    // );
    _submit();
  }

// for displaying msg while entering vlaues
  String? validateValue(String errorMsg, ValidationType type) {
    switch (type) {
      case ValidationType.emailid:
        if (!errorMsg.contains('@')) {
          return 'Email should contain @';
        } else if (errorMsg.trim().length < 4) {
          return 'Enter correct email address';
        } else {
          return null;
        }

      case ValidationType.password:
        if (errorMsg.trim().length < 6) {
          return 'Password should be at least 6 characters\n';
        } else if (!errorMsg.contains(RegExp(r'[A-Z]'))) {
          return 'Password should contain a upppercase letter\n';
        } else if (!errorMsg.contains(RegExp(r'[a-z]'))) {
          return 'Password should contain a lowercase letter\n';
        } else if (!errorMsg.contains(RegExp(r'[0-9]'))) {
          return 'Password should conatin a number';
        } else if (!errorMsg.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          return 'Password should conatin a special character';
        } else {
          return null;
        }
      default:
        return '';
    }
  }

  //   //if (email.text == "ashasharma" &pswd.text == 'Ashasharma24@')

//onPress of login button
  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (email.text.isEmpty && pswd.text.isEmpty ||
          _emailerror != null ||
          _pswrderror != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter valid the values')));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? registeremail = prefs.getString('registeremail');
        String? registerpswrd = prefs.getString('registerpswrd');
        String? fN = prefs.getString('fN');
        String? lN = prefs.getString('lN');

        if ((pswd.text.isNotEmpty && email.text.isNotEmpty) &&
            (email.text == registeremail && pswd.text == registerpswrd)) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Loged in successfully')));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(
                homefN: fN,
                homelN: lN,
              ),
            ),
          );
        } else if (email.text == registeremail && pswd.text != registerpswrd) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Incorrect Password!")));
        } else if (email.text != registeremail && pswd.text == registerpswrd) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Incorrect Email id!")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Account donen't exist!")));
        }

        print('Email id:$registeremail');
        print('Password: $registerpswrd');
      }
      // } else {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text('Login Failed!')));
      // }
      if (_emailerror == null && _pswrderror == null) {
        email.clear();
        pswd.clear();
      } else {
        return null;
      }
    }
  }

// navigate to signup page
  void _nextpage() {
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignUp(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // const phone = 'assets/images/phone-male.png';

    return Scaffold(
      backgroundColor: Color.fromARGB(194, 202, 193, 236),
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(14.0),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                width: 500,
                // child: Image.asset(
                //   phone,
                //   height: 300,
                // ),
                child: Text(
                  'Welcome back!',
                  style: GoogleFonts.lato(
                      color: Color.fromARGB(255, 30, 27, 25),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                // shape: ,
                // margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          icon: Icon(
                            size: 30.0,
                            Icons.account_circle,
                            // color: Color.fromARGB(255, 17, 16, 16),
                          ),
                          hintText: 'Enter your Email ',
                          // hintStyle:
                          //     TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
                          label: Text(
                            'Email',
                            style: GoogleFonts.aBeeZee(
                                // color:
                                //     const Color.fromARGB(255, 16, 15, 15),
                                ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          errorText: _emailerror,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        // style:
                        //     TextStyle(color: Color.fromARGB(255, 15, 14, 14)),
                        validator: (emailvalue) {
                          if (emailvalue == null || emailvalue.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _emailerror =
                                validateValue(value, ValidationType.emailid);
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: pswd,
                        decoration: InputDecoration(
                          icon: Icon(
                            size: 30.0,
                            Icons.lock,
                            // color: Color.fromARGB(255, 15, 14, 14),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _displayingPswrd = !_displayingPswrd;
                              });
                            },
                            icon: Icon(_displayingConfirm
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_circle_sharp),
                          ),
                          hintText: 'Enter your password ',
                          // hintStyle:
                          //     TextStyle(color: Color.fromARGB(255, 15, 14, 14)),
                          label: Text(
                            'Password',
                            // style: GoogleFonts.aBeeZee(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // password error text
                          errorText: _pswrderror,
                        ),

                        obscureText: _displayingPswrd, //hides characters
                        // style:
                        //     TextStyle(color: Color.fromARGB(255, 15, 14, 14)),
                        validator: (passvalue) {
                          if (passvalue == null || passvalue.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _pswrderror =
                                validateValue(value, ValidationType.password);
                          });
                        },

                        // validator: (value) {
                        //   return validateValue(
                        //       value ?? "", ValidationType.password);
                        // },
                      ),
                      SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: _submit,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              Color.fromARGB(136, 192, 180, 238)),
                        ),
                        child: Text(
                          "Log in",
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "or Sign in with",
                        // style:
                        //     GoogleFonts.lato(color: Colors.black, fontSize: 20),
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.mail,
                            size: 35,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.facebook,
                              size: 35,
                            )),
                      ]),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Don't have an account ?",
                            // style: GoogleFonts.lato(
                            //     color: Colors.black, fontSize: 15),
                          ),
                          TextButton(
                            onPressed: _nextpage,
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.lato(
                                  // color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
