import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:test_flutter_webrtc/webrtc_helper.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final webrtcHelper = WebRTCHelper();

  setFirebaseSnapShotListener() {
    DatabaseReference ref = FirebaseDatabase.instance.ref(widget.id);
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      var snapshotMap = event.snapshot.value as Map<String, dynamic>;
      var remoteUser = snapshotMap['remoteUser'].toString();
      var offer = snapshotMap['remoteOffer'].toString();
      var answer = snapshotMap['remoteAnswer'].toString();
      var candidate = snapshotMap['remoteCandidate'].toString();

      if (webrtcHelper.remoteId.isEmpty && remoteUser.isNotEmpty) {
        webrtcHelper.remoteId = remoteUser;
      }
      if (webrtcHelper.offer.isEmpty && offer.isNotEmpty) {
        print('get offer');
        webrtcHelper.offer = offer;
        webrtcHelper.setRemoteDescription(offer).then((value) {
          webrtcHelper.createAnswer();
        });
        return;
      }
      if (webrtcHelper.answer.isEmpty &&
          answer.isNotEmpty &&
          candidate.isNotEmpty) {
        print('get answer');
        webrtcHelper.answer = answer;
        webrtcHelper.setRemoteDescription(answer).then((value) {
          webrtcHelper.addCandidate(candidate);
        });
        return;
      }
    });
  }

  @override
  void initState() {
    webrtcHelper.myId = widget.id;
    webrtcHelper.initRenderer();
    webrtcHelper.createPeerConnecion();
    setFirebaseSnapShotListener();
    super.initState();
  }

  @override
  void dispose() async {
    await webrtcHelper.dispose();
    super.dispose();
  }

  Widget videoRenderers() => SizedBox(
        height: 210,
        child: Row(children: [
          Flexible(
            child: Container(
              key: const Key('local'),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              decoration: const BoxDecoration(color: Colors.black),
              child: RTCVideoView(webrtcHelper.localVideoRenderer),
            ),
          ),
          Flexible(
            child: Container(
              key: const Key('remote'),
              margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              decoration: const BoxDecoration(color: Colors.black),
              child: RTCVideoView(webrtcHelper.remoteVideoRenderer),
            ),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Flutter WebRTC'),
      ),
      body: Column(
        children: [
          videoRenderers(),
          SizedBox(
            height: 80,
            child: TextField(
              textAlign: TextAlign.center,
              maxLines: 1,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                hintText: '打給誰',
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  webrtcHelper.remoteId = text;
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (webrtcHelper.remoteId.isNotEmpty) {
                webrtcHelper.createOffer().then((value) {
                  createFirebaseOffer(
                    webrtcHelper.myId,
                    webrtcHelper.remoteId,
                    webrtcHelper.offer,
                  );
                });
              }
            },
            child: const Text("call"),
          ),
        ],
      ),
    );
  }
}

createFirebaseOffer(String myId, String remoteId, String offer) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref(myId);
  DatabaseReference remoteRef = FirebaseDatabase.instance.ref(remoteId);
  await ref.update({
    "remoteUser": remoteId,
    "remoteOffer": "",
  });

  await remoteRef.update({
    "remoteUser": myId,
    "remoteOffer": offer,
  });
}

clearFirebase(String myId, String remoteId) {
  DatabaseReference ref = FirebaseDatabase.instance.ref(myId);
  DatabaseReference remoteRef = FirebaseDatabase.instance.ref(remoteId);
  ref.remove();
  remoteRef.remove();
}
