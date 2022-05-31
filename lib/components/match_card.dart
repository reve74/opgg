import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 50,
              color: Colors.indigoAccent[400],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '승',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 6.0),
                    child: Divider(
                      height: 0.5,
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '27:26',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.lightBlue,
              width: 250,
              height: MediaQuery.of(context).size.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10,),
                  Container(
                    color: Colors.black,
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(width: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconCard(),
                      const SizedBox(height: 5,),
                      iconCard(),
                    ],
                  ),
                  const SizedBox(width: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconCard(),
                      const SizedBox(height: 5,),
                      iconCard(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconCard() {
    return  Container(
      color: Colors.black,
      width: 20,
      height: 20,
    );
  }
}
