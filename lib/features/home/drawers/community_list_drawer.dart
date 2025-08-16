import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/error_text.dart';
import 'package:reddit_clone/core/loader.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/models/community_model.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push("/r/${community.name}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20.0,),

            ListTile(
              title: const Text("Create a community"),
              leading: Icon(Icons.add),
              onTap: () => navigateToCreateCommunity(context),
            ),

            ref.watch(userCommunityProvider).when(
              data: (communities) => Expanded(
                child: ListView.builder(
                  itemCount: communities.length,
                  itemBuilder: (BuildContext context, int index) {
                    final community = communities[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(community.avatar),
                      ),
                      title: Text("r/${community.name}"),
                      onTap: () => navigateToCommunity(context, community),
                    );
                  }
                ),
              ), 
              error: (error, stackTrace) => ErrorText(error: error.toString()), 
              loading: () => const Loader(),
            ),
          ],
        ),
      ),
    );
  }
}