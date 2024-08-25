import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/chat/data/models/messages_model.dart';

class OtherUserMessage extends StatelessWidget {
  const OtherUserMessage({
    required this.message,
    super.key});
  final MessagesModel message;

  @override
  Widget build(BuildContext context) {
    return    Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.orange,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 30, right: 70, left: 8),
              child: Text(
                '${message.message}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              'ssds',
              // '${DateTime.parse(message.date).timeZoneName}',
              style: TextStyle(
                color: Colors.white,
              ),
            )
            //Text('${message.time}'),
          ],
        ),
      ),
    );


  }
}
