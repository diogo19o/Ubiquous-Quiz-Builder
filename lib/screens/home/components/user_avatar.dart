import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/screens/profile/profile_page.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ClipOval(child: Image.asset('assets/images/avatar.png')),
      onPressed: () => Get.to(() => ProfileScreen())
    );
  }
}