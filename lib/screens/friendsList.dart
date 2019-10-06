import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('KIK'),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => null, // search user names ..
              icon: Icon(Icons.search),
              iconSize: 24.0,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: null, // add user by name or phone..
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  friendBubble(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget friendBubble() {
    return Card(
      child: InkWell(
        onTap: () => null,
        child: Container(
          height: 150.0,
          width: 100.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/ic_launcher.png',
                      height: 40.0,
                      width: 40.0,
                    ), //friend image url ..
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 0.0),
                      child: Text(
                        'friend name',
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  String searchUserName(String username) {
    //search user names in the list..
    return null;
  }
}
//         Image.asset('assets/images/ic_launcher.png',height: 30.0,width: 30.0,), //friend image url ..
//         Text('friend name'),
//          Text('last message'),
//          Text('the time of last msg sent'),
