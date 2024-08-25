import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';

class UserMessageWidget extends StatelessWidget {
  const UserMessageWidget({
    required this.message,
    super.key});
  final MessagesModel message;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Colors.deepOrange,
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 70, left: 8),
                child: Text(
                  message.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 80,
            child: Text(
              'ccccc',
              //'${message.date}',
              // DateFormat.jm().format(DateTime.now()),
              //'${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("14:15:00"))}',
              //'${DateTime.now().hour-4} : ${DateTime.now().minute+35}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        )
      ],
    );


  }
}