import 'package:flutter/material.dart';
import 'package:kik_chat/auth.dart';
import 'package:kik_chat/constants.dart';

import 'root_page.dart';

class FriendsList extends StatefulWidget {
  final Auth auth;
  final VoidCallback signedOut;
  FriendsList({this.auth, this.signedOut});
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: KmyColors[3],
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('KIK++'),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => Dialog(
                child: Text('this is my dialg'),
              ), // search user names ..
              icon: Icon(Icons.search),
              iconSize: 24.0,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          tooltip: 'Add Friend',

          backgroundColor: KmyColors[2],
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () =>
              dialogeTrigger(context), // add user by name or phone..
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  friendBubble(
                    name: 'Hello World!',
                    lastMsg: 'ممكن نتعرف ؟',
                    lastTime: 12.12,
                    pfp: AssetImage(
                      'assets/images/me.jpg',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget friendBubble(
      {String name, String lastMsg, double lastTime, ImageProvider pfp}) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/chat'),
      child: Card(
        elevation: 0,
        color: KmyColors[5],
        margin: EdgeInsets.only(top: 8.0, right: 8, left: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(radius: 30, backgroundImage: pfp
                  //Todo u can use NetworkImage ()
                  ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: KmyColors[0]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      lastMsg,
                      style: TextStyle(fontSize: 16, color: KmyColors[1]),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$lastTime',
                style: TextStyle(color: KmyColors[1]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String searchUserName(String username) {
    //search user names in the list..
    return null;
  }

  //handle sign out and go back to root page, root page should go to login screen..
  void _signOut() async {
    try {
      await Auth.signOut();
      widget.signedOut();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RootPage(auth: widget.auth)));
    } catch (e) {
      print(e);
    }
  }
}

dialogeTrigger(BuildContext context) {
  var myDialog = SimpleDialog(
    title: Text('Search for a friend'),
    children: <Widget>[
      CustomeTextField(
        labelText: 'add friend',
        hintText: 'Enter friend\'s username',
        onSaved: (value) {},
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return myDialog;
      });
}
