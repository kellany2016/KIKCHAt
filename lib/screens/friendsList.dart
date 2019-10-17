import 'package:flutter/material.dart';
import 'package:kik_chat/auth.dart';
import 'root_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:algolia/algolia.dart'; //third party lib for search..

class FriendsList extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback signedOut;
  FriendsList({this.auth,this.signedOut});
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
              onPressed: () => searchExistingUsers(), // search user names ..
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

 String searchExistingUsers(){
   String  username;
   StreamBuilder<QuerySnapshot>(
       stream: Firestore.instance
           .collection('users')
           .snapshots(),
       builder: (context, snapshot) {
         if (!snapshot.hasData) {
            Center(
             child: Text('nothing to show...'),
           );
            return null;
         }
         var friends =  snapshot.data.documents;
         List<String> friendsList = [];//show the first chars of the searched users till the user can get his friend..
         for(var f in friends){
            username = f.data['username'];
         }
         return null;
       },
   );
       return username.toString();
 }
  //handle sign out and go back to root page, root page should go to login screen..
  void _signOut()async{
    try{
      await widget.auth.signOut();
      widget.signedOut();
      Navigator.push(
          context , MaterialPageRoute(builder: (context) => RootPage(auth: widget.auth)));
    }
    catch(e){print(e);}
  }
}

