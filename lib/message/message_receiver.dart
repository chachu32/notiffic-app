import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'message_model.dart';

class MessageReceiver extends StatefulWidget {
  @override
  _MessageReceiverState createState() => _MessageReceiverState();
}

class _MessageReceiverState extends State<MessageReceiver> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    messaging.getToken().then((value) {
      print("Firebase Messaging Token: $value");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      Provider.of<MessageModel>(context, listen: false).updateMessage(message.data['message']);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");

    // Display a notification or update UI
    Provider.of<MessageModel>(context, listen: false).updateMessage(message.data['message']);
    // Ensure to call notifyListeners() after updating the message
    Provider.of<MessageModel>(context, listen: false).notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Received Message:',
          ),
          Consumer<MessageModel>(
            builder: (context, model, child) {
              return Text(
                '${model.message}',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
        ],
      ),
    );
  }
}
