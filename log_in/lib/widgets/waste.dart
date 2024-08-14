// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() {
//     return _LoginScreen();
//   }
// }

// class _LoginScreen extends State<LoginScreen> {
//   TextEditingController email = TextEditingController();
//   TextEditingController pswd = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(
//                       top: 20, bottom: 10, left: 10, right: 10),
//                   width: 100,
//                   child: Text(
//                     'Welcome back!',
//                     style: GoogleFonts.lato(
//                         color: Color.fromARGB(255, 247, 245, 244),
//                         fontSize: 50,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Form(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           TextFormField(
//                             controller: email,
//                             decoration: InputDecoration(
//                               icon: Icon(
//                                 size: 30.0,
//                                 Icons.account_circle,
//                                 color: Color.fromARGB(255, 223, 217, 217),
//                               ),
//                               hintText: 'Enter your Email ',
//                               hintStyle: TextStyle(
//                                   color: Color.fromARGB(255, 223, 217, 217)),
//                               label: Text('Email',
//                                   style:
//                                       GoogleFonts.aBeeZee(color: Colors.white)),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                     color: Color.fromARGB(187, 255, 255, 255)),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                   color: Color.fromARGB(255, 241, 235, 235),
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                             ),
//                             keyboardType: TextInputType.emailAddress,
//                             autocorrect: false,
//                             textCapitalization: TextCapitalization.none,
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 223, 217, 217)),
//                           ),
//                           TextFormField(
//                             controller: pswd,
//                             decoration: InputDecoration(
//                               icon: Icon(
//                                 size: 30.0,
//                                 Icons.lock,
//                                 color: Color.fromARGB(255, 223, 217, 217),
//                               ),
//                               hintText: 'Enter your password ',
//                               hintStyle: TextStyle(
//                                   color: Color.fromARGB(255, 223, 217, 217)),
//                               label: Text('Password',
//                                   style:
//                                       GoogleFonts.aBeeZee(color: Colors.white)),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                     color: Color.fromARGB(187, 255, 255, 255)),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                   color: Color.fromARGB(255, 241, 235, 235),
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                             ),
//                             obscureText: true, //hides characters
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 223, 217, 217)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 60,
//                 ),
//                 OutlinedButton(
//                   onPressed: null,
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll<Color>(
//                         Color.fromARGB(255, 223, 217, 217)),
//                   ),
//                   child: Text(
//                     "Log in",
//                     style: GoogleFonts.lato(
//                         color: Color.fromARGB(173, 2, 11, 75),
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 // SizedBox(height: 80),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [
//                           Text(
//                             "Or Sign in with",
//                             style: GoogleFonts.lato(
//                                 color: Color.fromARGB(255, 223, 217, 217),
//                                 fontSize: 20),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 size: 50.0,
//                                 Icons.facebook,
//                                 color: Color.fromARGB(255, 223, 217, 217),
//                               ),
//                               Icon(
//                                 size: 50.0,
//                                 Icons.mail,
//                                 color: Color.fromARGB(255, 223, 217, 217),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "Don't have an account ?",
//                             style: GoogleFonts.lato(
//                                 color: Color.fromARGB(255, 223, 217, 217),
//                                 fontSize: 15),
//                           ),
//                           TextButton(
//                             onPressed: null,
//                             child: Text(
//                               "Sign Up",
//                               style: GoogleFonts.lato(
//                                   color: Color.fromARGB(255, 223, 217, 217),
//                                   fontSize: 20),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
