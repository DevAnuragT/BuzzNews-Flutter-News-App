import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/searched_news/ResultDisplayPage.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search news...',
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, // Customize the color of the border when focused
            width: 2.0,
          ),
        ),
      ),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onSubmitted: (query) {
        if (query.isEmpty) {
          return;
        }
        else if (query.trim().isEmpty) {
          // Show an error message or a Snackbar
          Get.snackbar(
            duration: Duration(seconds: 1),
            'Invalid Input',
            'Please enter a valid search query.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          _controller.clear();
        } else {
          print('Searching for: $query');
          Get.to(()=>ResultPage(query: query), transition: Transition.leftToRight);
          _controller.clear();
        }
      },
    );
  }
}
