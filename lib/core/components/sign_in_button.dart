import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/themes/pallete.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        onPressed: () {}, 
        label: Text(
          "Continue with Google",
          style: TextStyle(
            color: Pallete.whiteColor,
            fontSize: 18,
          ),
        ),
        icon: Image.asset(
          Constants.googlePath,
          height: 35,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
          minimumSize: Size(kIsWeb ? 350:double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
        ),
      ),
    );
  }
}