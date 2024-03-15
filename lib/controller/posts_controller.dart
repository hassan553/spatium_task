import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spatium_task/model/post_model.dart';

class PostsController extends GetxController {
  List<PostModel> postList = [];
  int page = 20;
  bool isLoading = false;
  ScrollController controller = ScrollController();

  Future<void> fetchData() async {
    if (isLoading) return;
    isLoading = true;
    update();
    final String apiUrl =
        'https://jsonplaceholder.typicode.com/posts?_page=2&_limit=$page';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List newData = List.from(json.decode(response.body));
        for (var element in newData) {
          postList.add(PostModel.fromJson(element));
        }
        page *= 2;
        isLoading = false;
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
    update();
  }

  Future<void> _scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      await fetchData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    controller.addListener(_scrollListener);
    fetchData();
  }
}
