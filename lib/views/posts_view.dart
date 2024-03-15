import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/posts_controller.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PostsController());
    return Scaffold(
      appBar: AppBar(title: const Text('Posts'), centerTitle: true),
      body: GetBuilder<PostsController>(
        builder: (postsController) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              controller: postsController.controller,
              itemCount: postsController.postList.length + 1,
              itemBuilder: (context, index) {
                if (index < postsController.postList.length) {
                  return Card(
                    child: ListTile(
                      title: Text(postsController.postList[index].title),
                      subtitle: Text(postsController.postList[index].body),
                    ),
                  );
                } else {
                  if (postsController.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
