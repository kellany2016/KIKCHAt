import 'package:flutter/material.dart';

enum ImageSet { image, noImage }

class Profile extends StatelessWidget {
  final ImageSet image = ImageSet.noImage;

  showDialog(BuildContext context) {
    return showDialog(
      context,
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/me.jpg'), fit: BoxFit.cover)),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/me.jpg'), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(color: Colors.white, width: 10.0)),
      ),
    );
  }

  Widget _buildName() {
    TextStyle textStyle = TextStyle(
        fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.w700);
    return Text(
      'Ahmed Alaa',
      style: textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildCoverImage(screenSize),
            Column(
              children: <Widget>[
                SizedBox(height: screenSize.height / 6.4),
                _buildProfileImage(),
                _buildName()
              ],
            )
          ],
        ),
      ),
    );
  }
}
