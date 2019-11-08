import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static String _myEmail;
  static final _myAuth = FirebaseAuth.instance;
  static AuthResult result;
//TODO result is always NOT NULL which makes it useless [somehow] user result.user instead

  static signMeUp(
      {String email, String password, String pfpurl, String userName}) async {
    try {
      result = await _myAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserUpdateInfo updateInfo;
      updateInfo.photoUrl = pfpurl;
      updateInfo.displayName = userName;
      result.user.updateProfile(updateInfo);
    } catch (e, s) {
      print('auth says : $s');
      return false;
    }
  }

  static Future<bool> signMeIn(String email, String password) async {
    try {
      result = await _myAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result != null;
    } catch (e, s) {
      print(s);
      return false;
    }
  }

  static getCurrentUser() async {
    try {
      final user = await _myAuth.currentUser();
      if (user != null) {
        _myEmail = user.email;

        return _myEmail;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  getUserId(FirebaseUser user) async {
    return user.uid;
  }

  static Future<void> signOut() async {
    return _myAuth.signOut();
  }
}

class FireStoring {
  //region fields
  static int lastId = -1;
  static Firestore _myFireStore = Firestore.instance;
  String _pathToMsgs = '/oneToOneChats/vjm1dLfdDrBLsWT0dVix/messages';
  static String _myDocumentId = '';

//endregion

//region  Methods
//shouldn't call send uless getCurrentUser is called in auth otherwise it will crash
  send(String mymsg) {
    ++lastId;
    _myFireStore
        .collection(_pathToMsgs)
        .add({'number': lastId, 'sender': Auth._myEmail, 'text': mymsg});
  }

  subscribe() async {
    await for (var snapshot
        in _myFireStore.collection(_pathToMsgs).snapshots()) {
      for (var message in snapshot.documents) {}
    }
  }

  createPrivateChat(String hisDocumentId) async {
    //remove from here
    await myDocumentId();
    String doc = '$_myDocumentId + $hisDocumentId';
    _myFireStore
        .collection('OneToOneChats')
        .document(doc)
        .setData({'user1': _myDocumentId, 'user2': ' test One'});

    //to be moved to send
    _myFireStore
        .collection('OneToOneChats/$doc/messages')
        .add({'sender': Auth._myEmail, 'text': ' test One'});
    print('Created');
  }

  addUser(String name, String userId) {}

  static Future<String> myDocumentId() async {
    final users = await _myFireStore.collection('AllUsers').getDocuments();
    for (var doc in users.documents) {
      if (doc.data['name'] == 'ahmed Alla') {
        _myDocumentId = doc.documentID;
        return _myDocumentId;
      }
    }
    return null;
  }

  Stream chatRoomStream() {
    return _myFireStore.collection(_pathToMsgs).orderBy('number').snapshots();
  }

  //endregion
}
