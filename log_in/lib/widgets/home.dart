import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:log_in/widgets/UpdatePage.dart';
//DateTime
import 'package:intl/intl.dart';
//path
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
// import 'package:log_in/widgets/message.dart';

class HomePage extends StatefulWidget {
  final dynamic homefN;
  final dynamic homelN;
  HomePage({super.key, required this.homefN, required this.homelN});

  @override
  State<HomePage> createState() {
    return _Homepage();
  }
}

class _Homepage extends State<HomePage> {
  File? cameraFile;
  final ImagePicker pic = ImagePicker();
  final TextEditingController _msgcontroller = TextEditingController();
  // Message
  String usermsg = '';
  //Date and time:
  DateTime currentTime = DateTime.now();

  @override
  void dispose() {
    _msgcontroller;
    super.dispose();
  }

  void displaymsg() {
    setState(() {
      usermsg = _msgcontroller.text;
    });
    _msgcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String userFN = widget.homefN;
    String userLN = widget.homelN;

    // to select img or camera
    void selectImg() async {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Select one option!'),
          actions: [
            IconButton(
              onPressed: () async {
                final pickedImg =
                    await pic.pickImage(source: ImageSource.camera);
                if (pickedImg != null) {
                  setState(() {
                    cameraFile = File(pickedImg.path);
                  });
                }
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.camera_alt_outlined),
            ),
            IconButton(
              onPressed: () async {
                final albumImg =
                    await pic.pickImage(source: ImageSource.gallery);
                if (albumImg != null) {
                  setState(() {
                    cameraFile = File(albumImg.path);
                  });
                  print(cameraFile);
                }
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.photo),
            ),
          ],
        ),
      );
    }

    String formatDate = DateFormat('dd-MM-yyyy').format(currentTime);
    String formateTime = DateFormat('hh:mm:ss aaa').format(currentTime);

    // print(currentTime);8p
    print(formatDate);
    print(formateTime);

    Future<void> renameAndRedirect() async {
      if (cameraFile != null) {
        //rename Img file
        try {
          final directory = await getApplicationDocumentsDirectory();
          final newPath = path.join(directory.path, '$userFN$formatDate');

          bool fileexists = File(newPath).existsSync();
          if (fileexists) {
            // file exists alert message
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Already uploaded the image'),
                  content: const Text(
                    'You have already uploaded an image today!!',
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            await cameraFile!.rename(newPath);
            setState(() {
              cameraFile = File(newPath);
              print(cameraFile);
            });

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Uploaded the image'),
                  content: const Text(
                    'You have successfully uploaded an image!!',
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        } catch (e) {
          print('Error renaming the Image!');
        }

        // For Date and Time

        // if (cameraFile != null) {
        //   // Future.delayed(Duration(seconds: 2), () async {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => UpdatePage(),
        //     ),
        //   );
        // setState(() {
        //   usermsg = '';
        //   cameraFile = null;
        // });
        //   // });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please upload the Image!',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Welcome $userFN $userLN !",
                style: GoogleFonts.lato(fontSize: 20),
              ),
              SizedBox(
                width: 50,
                height: 10,
              ),
              Text(
                "Add a image",
                style: GoogleFonts.lato(fontSize: 20),
              ),
              //Display image card
              Card(
                margin: const EdgeInsets.all(20),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                      color: const Color.fromARGB(99, 0, 0, 0), width: 2.0),
                ),
                elevation: 8.0,
                child: SizedBox(
                  height: 350.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: cameraFile == null
                          ? IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: selectImg,
                              iconSize: 60,
                            )
                          : Center(
                              child: Image.file(cameraFile!),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 05,
              ),
              IconButton(
                onPressed: cameraFile != null ? selectImg : null,
                icon: Icon(
                  Icons.refresh_rounded,
                  color: Colors.green,
                ),
                iconSize: 50,
              ),
              //Message
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _msgcontroller,
                            textCapitalization: TextCapitalization.sentences,
                            autocorrect: true,
                            decoration: InputDecoration(
                                labelText: 'Type Something.....'),
                          ),
                        ),
                        IconButton(
                          onPressed: displaymsg,
                          icon: Icon(
                            Icons.send,
                            color: Color.fromARGB(194, 133, 107, 229),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      _msgcontroller.text.isEmpty ? usermsg : '',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
              // Message(),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      Color.fromARGB(118, 133, 107, 229)),
                ),
                onPressed: () => renameAndRedirect(),
                child: Text(
                  'Submit',
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
