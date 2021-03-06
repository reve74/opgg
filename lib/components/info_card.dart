import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:opgg/const/colors.dart';
import 'package:opgg/const/data.dart';
import 'package:opgg/controller/summoner_controller.dart';

class InfoCard extends StatelessWidget {
  SummonerController s = Get.put(SummonerController());

  final String name;
  final String summonerLevel;
  final String profileIconId;
  final String puuid;
  final VoidCallback onPressed;

  InfoCard({
    required this.name,
    required this.summonerLevel,
    required this.profileIconId,
    required this.puuid,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              child: Image.asset(
                'asset/img/lux.jpeg',
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: 40,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.star_border_outlined,
                            color: Colors.grey[600],
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network(
                                PROFILE_ICON_API + '$profileIconId.png',
                                width: 70,
                                height: 70,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.black45,
                                  ),
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    summonerLevel,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              '?????? ?????? 1,465,841???',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent[400],
                              ),
                              onPressed: onPressed,
                              child: const Text('?????? ??????'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[400],
                              ),
                              onPressed: () {},
                              child: const Text('?????????'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
