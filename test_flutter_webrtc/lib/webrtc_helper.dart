import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';

class WebRTCHelper {
  final localVideoRenderer = RTCVideoRenderer();
  final remoteVideoRenderer = RTCVideoRenderer();
  bool _isCaller = false;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  String offer = '';
  String answer = '';
  String myId = '';
  String remoteId = '';
  String candidate = '';

  initRenderer() async {
    await localVideoRenderer.initialize();
    await remoteVideoRenderer.initialize();
  }

  dispose() async {
    await localVideoRenderer.dispose();
  }

  getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);

    localVideoRenderer.srcObject = stream;
    return stream;
  }

  createPeerConnecion() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };

    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };

    _localStream = await getUserMedia();

    RTCPeerConnection pc =
        await createPeerConnection(configuration, offerSdpConstraints);

    pc.addStream(_localStream!);

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        var c = json.encode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString(),
          'sdpMlineIndex': e.sdpMLineIndex,
        });
        if (!_isCaller && candidate.isEmpty) {
          candidate = c;
          createFirebaseAnswerAndCandidate(remoteId, answer, candidate);
        }
        print('candidate : $candidate _caller=$_isCaller');
      }
    };

    pc.onIceConnectionState = (e) {
      print(e);
    };

    pc.onAddStream = (stream) {
      print('addStream: ' + stream.id);
      remoteVideoRenderer.srcObject = stream;
    };

    _peerConnection = pc;
  }

  Future<void> createOffer() async {
    RTCSessionDescription description =
        await _peerConnection!.createOffer({'offerToReceiveVideo': 1});
    var session = parse(description.sdp.toString());
    _isCaller = true;
    offer = json.encode(session);
    print('offer=$offer');

    _peerConnection!.setLocalDescription(description);
  }

  Future<void> createAnswer() async {
    RTCSessionDescription description =
        await _peerConnection!.createAnswer({'offerToReceiveVideo': 1});

    var session = parse(description.sdp.toString());
    print(json.encode(session));
    answer = json.encode(session);

    _peerConnection!.setLocalDescription(description);
  }

  Future<void> setRemoteDescription(String remoteDescriptionJson) async {
    // String jsonString = sdpController.text;
    dynamic session = await jsonDecode(remoteDescriptionJson);

    String sdp = write(session, null);

    RTCSessionDescription description =
        RTCSessionDescription(sdp, _isCaller ? 'answer' : 'offer');
    print(description.toMap());

    await _peerConnection!.setRemoteDescription(description);
  }

  void addCandidate(String candidateJson) async {
    // String jsonString = sdpController.text;
    dynamic session = await jsonDecode(candidateJson);
    print(session['candidate']);
    dynamic candidate = RTCIceCandidate(
        session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
    await _peerConnection!.addCandidate(candidate);
  }
}

createFirebaseAnswerAndCandidate(
  String remoteId,
  String answer,
  String candidate,
) async {
  DatabaseReference remoteRef = FirebaseDatabase.instance.ref(remoteId);
  await remoteRef.update({
    "remoteAnswer": answer,
    "remoteCandidate": candidate,
  });
}
