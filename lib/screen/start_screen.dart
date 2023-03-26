import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  final imageItem = [
    "assets/images/img1.gif",
    "assets/images/img2.gif",
    "assets/images/img3.gif",
  ];

  final storage = const FlutterSecureStorage();

  void getLoginedInfo() async {
    var loginedInfo = await storage.readAll();
    // print(loginedInfo);
  }

  @override
  void initState() {
    getLoginedInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Swiper(
                      itemCount: 3,
                      itemBuilder: ((BuildContext context, int index) {
                        // return Image.asset("assets/images/img.jpg");
                        return Image.asset(imageItem[index].toString());
                      }),
                      autoplay: true,
                      pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                        color: Colors.grey,
                        activeColor: Colors.blue,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: const Text("로그인 하러 가기"),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text("회원가입 하러 가기"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
