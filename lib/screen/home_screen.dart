import 'package:flutter/material.dart';
import 'package:opgg/components/search_text_field.dart';
import 'package:opgg/screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget topBar(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SearchScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SearchTextField(
                  enable: false,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.black87,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '패치노트',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      10,
                          (index) => Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 200,
                        height: 100,
                        color: Colors.red,
                      ),
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topBar(context),
          ],
        ),
      ),
    );
  }
}

// 앱바
AppBar appbar(BuildContext context) {
  return AppBar(
    bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'OP.GG',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontFamily: 'RedHat',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.0),
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          Text(
                            'KR',
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.west_rounded,
                            size: 20.0,
                            color: Colors.grey[600],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.wrap_text_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
    backgroundColor: Colors.white,
    elevation: 0.0,
    // title: ,
  );
}
