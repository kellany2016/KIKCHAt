// to be used in ChatRoom
class Message {
  final String senderId; // FriendInfo.name or FriendInfo.pfp
  final String msgText;
  final int msgOrder;
  Message(this.msgOrder, this.msgText, this.senderId);
}

//to be used in RoomData
class FriendInfo {
  String name;
  String pfp; // aka profile picture
  String username; //TODO N make it final and initialize it
  String phone;
  DateTime birthday;
  String gender;
}

//to be used in ChatRoom
class RoomData {
  List<FriendInfo> friends; // one or more user to chat with
  String chatPFP; // if in a group chat
  String chatName; //=friends[0].name if not groups
}

//to be used in FriendsList
class ChatRoom {
  List<Message> messages;
  RoomData data;
}

//that's what we use to show in the friendListScreen : a list of all chat rooms with single or multiple friends
class FriendsList {
  List<ChatRoom> chatRooms;
}

// the parent collection of the map that we send to the database after signing up for this user
class User {
  FriendsList friendsList;
  FriendInfo iamThatFriendNow;
}

//what we use to intialize our dataBase
//TODO N this deosn't belong here .. but I put it *here* just for clarification purposes
class MyDataBase {
  List<User> users;
//TODO N https://stackoverflow.com/questions/51170298/adding-an-object-to-cloud-firestore-using-flutter/51228984#51228984
}

//took an hour to create this file so please don't remove it ^.^
