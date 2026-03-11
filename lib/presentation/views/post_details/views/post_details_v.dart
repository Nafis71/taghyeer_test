import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';
import 'package:taghyeer_test/presentation/views/post_details/widgets/post_information_w.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  late final Map<String, dynamic>? _arguments;
  late final PostEntity? _post;

  @override
  void initState() {
    _arguments = Get.arguments;
    _post = _arguments?['post'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_post == null) throw "_post is null";
    return Scaffold(
      appBar: AppBar(title: const Text("Post Details")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostInformation(post: _post),
            ],
          ),
        ),
      ),
    );
  }
}
