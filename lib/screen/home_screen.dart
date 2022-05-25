import 'package:flutter/material.dart';
import 'package:opgg/screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SearchScreen()));
                },
                child: Container(
                  height: 40,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        '소환사 검색',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                height: 150,
              ),


            ],
          ),
        ),
      ),
    );
  }
}

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
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          Text(
                            'KR',
                            style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
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
                    icon: Icon(
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
