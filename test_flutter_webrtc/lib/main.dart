import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_webrtc/my_home_page.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Flutter WebRTC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Flutter WebRTC'),
        ),
        body: const Center(
          child: FirstPage(),
        ),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String _id = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            child: TextField(
              textAlign: TextAlign.center,
              maxLines: 1,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                hintText: 'USER ID',
              ),
              onChanged: (text) {
                _id = text;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_id.isNotEmpty) {
                createFirebaseUser(_id);
                goHomePage(context, _id);
              }
            },
            child: const Text('確定'),
          ),
        ],
      ),
    );
  }
}

void goHomePage(
  BuildContext context,
  String id,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (_) => MyHomePage(
              id: id,
            )),
  );
}

createFirebaseUser(String id) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref(id);
  await ref.set({
    "remoteUser" : "",
    "remoteOffer" : "",
    "remoteAnswer" : "",
    "remoteCandidate" : "",
  });
}
