import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a community"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: const Text("Community name"),
            ),

            const SizedBox(height: 10,),

            Align(
              alignment: kIsWeb ? Alignment.topLeft:Alignment.topCenter,
              child: SizedBox(
                width: kIsWeb ? 400: double.infinity,
                child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                    hintText: "r/community-name",
                    filled: true,
                    border: InputBorder.none,
                  ),
                  maxLength: 21,
                ),
              ),
            ),

            const SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () {}, 
              style: ElevatedButton.styleFrom(
                minimumSize: Size(kIsWeb ? 400:double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                "Create community",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}