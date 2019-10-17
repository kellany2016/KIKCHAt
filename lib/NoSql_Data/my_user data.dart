// to be used in ChatRoom

class Message {
  final String senderId; // FriendInfo.name or FriendInfo.pfp
  final String msgText;
  final int msgOrder;
  Message(this.msgOrder, this.msgText, this.senderId);
}

//to be used in RoomData
class FriendInfo {
  String _name;
  String _pfp; // aka profile picture
  String _username; //TODO N make it final and initialize it
  String _phone;
  //DateTime _birthday;
  String _gender;

  void setName(String name){_name = name;}
  String getName(){return _name;}

  void setPfp(String pfp){_pfp = pfp;}
  String getPfp(){return _pfp;}

  void setUsername(String username){_username = username;}
  String getUsername(){return _username;}

  void setPhone(String phone){_phone = phone;}
  String getPhone(){return _phone;}

  void setGender(String gender){_gender = gender;}
  String getGender(){return _gender;}
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
class FriendList {
  List<ChatRoom> chatRooms;
}

// the parent collection of the map that we send to the database after signing up for this user
class User {
  FriendList friendsList;
  FriendInfo iamThatFriendNow;
}

//what we use to intialize our dataBase
//TODO N this doesn't belong here .. but I put it *here* just for clarification purposes
class MyDataBase {
  List<User> users;
//TODO N https://stackoverflow.com/questions/51170298/adding-an-object-to-cloud-firestore-using-flutter/51228984#51228984
}

//took an hour to create this file so please don't remove it ^.^
