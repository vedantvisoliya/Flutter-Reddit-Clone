import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/loader.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final TextEditingController communityNameController = TextEditingController();

  @override
  void dispose() {
    communityNameController.dispose();
    super.dispose();
  }

  void createCommunity() {
    ref.read(communityControllerProvider.notifier).createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a community"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Routemaster.of(context).pop();
          }, 
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading ? const Loader() : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: kIsWeb ? 400:null,
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
                      controller: communityNameController,
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
                  onPressed: () => createCommunity(), 
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
        ),
      ),
    );
  }
}