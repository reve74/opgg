import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  // final InputDecoration decoration;
  ValueChanged? onSubmitted;
  bool? enable = true;

  SearchTextField({
    // required this.decoration,
    this.onSubmitted,
    this.enable,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        enabled: enable,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            // borderSide: BorderSide(color: Colors.black)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[500],
          ),
          hintText: '소환사 검색',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
