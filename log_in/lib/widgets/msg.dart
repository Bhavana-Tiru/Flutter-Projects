import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() {
    return Msg();
  }
}

class Msg extends State<Message> {
  //message controller
  final TextEditingController _msgcontroller = TextEditingController();
  String usermsg = '';
  @override
  void dispose() {
    // TODO: implement dispose
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
    return Padding(
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
                  decoration: InputDecoration(labelText: 'Type Something.....'),
                ),
              ),
              IconButton(
                onPressed: displaymsg,

                // showDialog(
                //   context: context,
                //   builder: (context) => AlertDialog(
                //       content: Text(_msgcontroller.text),
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: Text('OK'),
                //         ),
                //       ]),
                // );

                icon: Icon(
                  Icons.send,
                  color: Color.fromARGB(194, 133, 107, 229),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _msgcontroller.text.isEmpty ? usermsg : '',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
