import 'package:flutter/material.dart';

class InfoListCard extends StatelessWidget {
  const InfoListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('최근 20경기'),
            Text('요약정보'),
            SizedBox(height: 10.0),
            Container(
              color: Colors.grey[600],
              child: Text(
                '2.07:1',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text('승률 40%'),
            Text('KDA 8.0 / 8.8 / 10.1'),
          ],
        ),
      ),
    );
  }
}
