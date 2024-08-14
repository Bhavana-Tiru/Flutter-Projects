import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:log_in/widgets/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  @override
  State<SignUp> createState() {
    return _SignUp();
  }
}

// Enums help to structure the code better by separating the different types of validation into distinct cases.
//  This keeps the validation logic organized and easier to maintain.
enum SiginValidationTypes {
  emailid,
  password,
  firstName,
  lastName,
  pincode,
  confirmPassword,
}

class _SignUp extends State<SignUp> {
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController signupemail = TextEditingController();
  TextEditingController signuppswrd = TextEditingController();
  TextEditingController cofPswrd = TextEditingController();

  String _selectedDate = '';
  String? _validateDate = '';
  // String? _savedDate;

  String? _emailiderr;
  String? _passworderr;
  String? _firstNameerr;
  String? _lastNameerr;
  String? _pincodeerr;
  String? _confirmPswrderr;

  bool _displayConfirm = true;
  bool _displayPswrd = true;

  @override
  void dispose() {
    signupemail.dispose();
    signuppswrd.dispose();
    firstName.dispose();
    lastName.dispose();
    cofPswrd.dispose();
    super.dispose();
  }

  //shared preferences
  Future<void> signup() async {
    String fN = firstName.text;
    String lN = lastName.text;
    String pC = pincode.text;
    String cP = cofPswrd.text;
    String add = address.text;
    String dateOfBirth = dob.text;

    String registeremail = signupemail.text;
    String registerpswrd = signuppswrd.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeremail', registeremail);
    await prefs.setString('registerpswrd', registerpswrd);
    await prefs.setString('fN', fN);
    await prefs.setString('lN', lN);

    if (_formKey1.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered in successfully !')));

      print('FistName: $fN');
      print('LastName: $lN');
      print('Email: $registeremail');
      print('Address: $add');
      print('Pincode: $pC');
      print('Date of Birth: $dateOfBirth');
      print('Password: $registerpswrd');
      print('Confirm Password: $cP');

      signupemail.clear();
      signuppswrd.clear();
      firstName.clear();
      lastName.clear();
      pincode.clear();
      address.clear();
      dob.clear();
      cofPswrd.clear();
    }
  }

// validate
  String? signinValidate(String errorMsg, SiginValidationTypes type) {
    switch (type) {
      case SiginValidationTypes.emailid:
        if (!errorMsg.contains('@')) {
          return 'Email should contain @';
        } else if (errorMsg.trim().length < 4) {
          return 'Enter correct email address';
        } else {
          return null;
        }

      case SiginValidationTypes.password:
        if (errorMsg.trim().length < 6) {
          return 'Password should be atleast\n 6 characters\n';
        } else if (!errorMsg.contains(RegExp(r'[A-Z]'))) {
          return 'Password should contain a \n upppercase letter\n';
        } else if (!errorMsg.contains(RegExp(r'[a-z]'))) {
          return 'Password should contain a \n lowercase letter\n';
        } else if (!errorMsg.contains(RegExp(r'[0-9]'))) {
          return 'Password should conatin a number';
        } else if (!errorMsg.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          return 'Password should conatin a \n special character';
        } else {
          return null;
        }

      case SiginValidationTypes.firstName:
        if (errorMsg.trim().length < 4) {
          return 'First Name should be\n 4 characters\n';
        } else {
          return null;
        }

      case SiginValidationTypes.lastName:
        if (errorMsg.trim().length < 4) {
          return 'Last Name should be \n atleast 4 characters\n';
        } else {
          return null;
        }

      case SiginValidationTypes.pincode:
        if (!errorMsg.contains(RegExp(r'[0-9]{6}$'))) {
          return 'Pincode must be 6 digits\n';
        } else {
          return null;
        }

      case SiginValidationTypes.confirmPassword:
        if (errorMsg.trim().length < 6) {
          return 'Confirm Password should be at \n least 6 characters\n';
        } else if (!errorMsg.contains(RegExp(r'[A-Z]'))) {
          return 'Confirm Password should contain a \n upppercase letter\n';
        } else if (!errorMsg.contains(RegExp(r'[a-z]'))) {
          return 'Confirm Password should contain a  \n lowercase letter\n';
        } else if (!errorMsg.contains(RegExp(r'[0-9]'))) {
          return 'Confirm Password should conatin a number\n';
        } else if (!errorMsg.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          return 'Confirm Password should conatin a \n special character\n';
        } else {
          return null;
        }
      default:
        return '';
    }
  }

  // void _submitValues() {
  //   if (_formKey1.currentState?.validate() ?? false) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Registered in successfully !')));

  //     String fN = firstName.text;
  //     String lN = lastName.text;
  //     String userEmail = signupemail.text;
  //     String pC = pincode.text;
  //     String cP = cofPswrd.text;
  //     String add = address.text;
  //     String dateOfBirth = dob.text;
  //     String password = signuppswrd.text;
  //     print('FistName: $fN');
  //     print('LastName: $lN');
  //     print('Email: $userEmail');
  //     print('Address: $add');
  //     print('Pincode: $pC');
  //     print('Date of Birth: $dateOfBirth');
  //     print('Password: $password');
  //     print('Confirm Password: $cP');

  //     signupemail.clear();
  //     signuppswrd.clear();
  //     firstName.clear();
  //     lastName.clear();
  //     pincode.clear();
  //     address.clear();
  //     dob.clear();
  //     cofPswrd.clear();
  //   }
  // }

//redirect to Login page
  void _loginpage() {
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey1,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstName,
                      decoration: InputDecoration(
                        hintText: 'Enter your First Name ',
                        // hintStyle: TextStyle(color: Colors.white),
                        label: Text(
                          'First Name',
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorText: _firstNameerr,
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        setState(() {
                          _firstNameerr = signinValidate(
                              value, SiginValidationTypes.firstName);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'FirstName is required';
                        } else {
                          return null;
                        }
                      },
                      autocorrect: false,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: lastName,
                      decoration: InputDecoration(
                        hintText: 'Enter your Last Name ',
                        // hintStyle: TextStyle(color: Colors.white),
                        label: Text(
                          'Last Name',
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorText: _lastNameerr,
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      validator: (lvalue) {
                        if (lvalue == null || lvalue.isEmpty) {
                          return 'Last Name is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _lastNameerr = signinValidate(
                              value, SiginValidationTypes.lastName);
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                        hintText: 'Enter your Address ',
                        // hintStyle: TextStyle(color: Colors.white),
                        label: Text(
                          'Address',
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      keyboardType: TextInputType.streetAddress,
                      autocorrect: false,
                      validator: (avalue) {
                        if (avalue == null || avalue.isEmpty) {
                          return 'Address is required';
                        } else if (avalue.trim().length < 5) {
                          return "Address must be at least\n 5 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: pincode,
                      decoration: InputDecoration(
                        hintText: 'Enter your Pincode ',
                        // hintStyle: TextStyle(color: Colors.white),
                        label: Text(
                          'Pincode',
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorText: _pincodeerr,
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      validator: (pvalue) {
                        if (pvalue == null || pvalue.isEmpty) {
                          return 'Pincode is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _pincodeerr = signinValidate(
                              value, SiginValidationTypes.pincode);
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'yyyy/MM/dd',
                    icon: Icon(Icons.calendar_month_outlined),
                    controller: dob,
                    firstDate: DateTime(1976),
                    lastDate: DateTime.now(),
                    // icon: Icon(Icons.event),
                    dateLabelText: 'Date of Birth',
                    dateHintText: '1976/01/01',
                    initialDate: DateTime(1976),
                    onChanged: (val) => setState(() {
                      _selectedDate = val;
                    }),
                    validator: (val) {
                      setState(() => _validateDate = val ?? '');
                      if (val == null || val.isEmpty) {
                        return "Date of Birth is required";
                      }
                      return null;
                    },
                    // onSaved: (val) {
                    //   setState(() => _savedDate = val ?? '');
                    // },
                  ),
                  // TextFormField(
                  //   controller: dob,
                  //   decoration: InputDecoration(
                  //     label: Text(
                  //       'Date of Birth',
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  //   readOnly: true,
                  //   // onTap: () async{
                  //   //   DateTime ? pickedDat
                  //   // },
                  //   autocorrect: false,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: signupemail,
                    decoration: InputDecoration(
                      hintText: 'Enter your Email ',
                      // hintStyle: TextStyle(color: Colors.white),
                      label: Text(
                        'Email',
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorText: _emailiderr,
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (evalue) {
                      if (evalue == null || evalue.isEmpty) {
                        return 'Email is required';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _emailiderr =
                            signinValidate(value, SiginValidationTypes.emailid);
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: signuppswrd,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password ',
                      // hintStyle: TextStyle(color: Colors.white),
                      label: Text(
                        'Password',
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _displayPswrd = !_displayPswrd;
                            });
                          },
                          icon: Icon(_displayConfirm
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye_rounded)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorText: _passworderr,
                    ),
                    autocorrect: false,
                    obscureText: _displayPswrd,
                    validator: (passvalue) {
                      if (passvalue == null || passvalue.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _passworderr = signinValidate(
                            value, SiginValidationTypes.password);
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: cofPswrd,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      // hintStyle: TextStyle(color: Colors.white),
                      label: Text(
                        ' Confirm Password',
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_displayConfirm
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye_rounded),
                        onPressed: () {
                          setState(() {
                            _displayConfirm = !_displayConfirm;
                          });
                        },
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorText: _confirmPswrderr,
                    ),
                    autocorrect: false,
                    obscureText: _displayConfirm,
                    validator: (confvalue) {
                      if (confvalue == null || confvalue.isEmpty) {
                        return 'Confirm Password is required';
                      } else if (cofPswrd.text != signuppswrd.text) {
                        return "Passwords doesn't match";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _confirmPswrderr = signinValidate(
                            value, SiginValidationTypes.confirmPassword);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: signup,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.black),
                    ),
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Already have account?",
                        style:
                            GoogleFonts.lato(color: Colors.black, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: _loginpage,
                        child: Text(
                          "Log In",
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
