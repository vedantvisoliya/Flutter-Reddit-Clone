import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/components/sign_in_button.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/loader.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      // appbar starting here
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {}, 
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      // appbar ending here

      // body starts here
      body: isLoading ? Loader() : Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const SizedBox(height: 30.0,),

            const Text(
              "Dive into anything",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 30,),

            Image.asset(
              Constants.loginEmotePath,
              width: 300,
            ),

            const SizedBox(height: 20.0,),

            SignInButton(),
          ],
        ),
      ),
    );
  }
}