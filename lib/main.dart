import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '차덕',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xffa154ff),
            // side: BorderSide(color: const Color(0xffa154ff))
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool isWeb;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        Size size = MediaQuery.of(context).size;
        size.width > 700 ? isWeb = true : isWeb = false;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: ListView(
            children: <Widget>[
              _firstBox(size),
              isWeb
                  ? _widgetForWeb(
                      size: size,
                      img: 'assets/phone02.png',
                      title: '내 주변 주차 가능한 카페와 맛집을 한눈에',
                      content:
                          "이제 일일히 검색할 필요 없이 '차덕' 앱 하나로\n주변에 주차 가능한 카페와 맛집을 편하게 찾을 수 있어요")
                  : _widgetForMobile(
                      img: 'assets/phone02.png',
                      title: '내 주변 주차 가능한 카페와 맛집을 한눈에',
                      content1: "이제 일일히 검색할 필요 없이 '차덕' 앱 하나로",
                      content2: '주변에 주차 가능한 카페와 맛집을 편하게 찾을 수 있어요',
                    ),
              _buildDivider(),
              isWeb
                  ? _widgetForWeb(
                  size: size,
                  img: 'assets/phone03.png',
                  title: '진짜 주차 가능한 가게 정보 확인',
                  content:
                  "이미지, 주차정보, 주소 등 업체의 정보를 확인해보세요\n'차덕'은 제대로 주차장이 갖춰진 업체들만 소개합니다",
                  rightImg: false)
                  : _widgetForMobile(
                img: 'assets/phone03.png',
                title: '진짜 주차 가능한 가게 정보 확인',
                content1: '이미지, 주차정보, 주소 등 업체의 정보를 확인해보세요',
                content2:  "'차덕'은 제대로 주차장이 갖춰진 업체들만 소개합니다",
              ),
              _buildDivider(),
              isWeb
                  ? _widgetForWeb(
                  size: size,
                  img: 'assets/phone04.png',
                  title: '내가 쓰는 내비게이션으로 바로 연동',
                  content:
                  "'차덕'은 이용자의 편의를 위해 다양한 내비를 지원합니다\n티맵,카카오내비,네이버지도,애플지도로 목적지까지 편하게 이동하세요")
                  : _widgetForMobile(
                img: 'assets/phone04.png',
                title: '내가 쓰는 내비게이션으로 바로 연동',
                content1: "'차덕'은 이용자의 편의를 위해 다양한 내비를 지원합니다",
                content2: '티맵, 카카오내비, 네이버지도, 애플지도로',
                content3: ' 목적지까지 편하게 이동하세요'
              ),
              _buildDivider(),
              _companyInfo(),
            ],
          ),
        );
      },
    );
  }


  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset('assets/map_screen_logo6.png', width: 50),
      centerTitle: false,
    );
  }

  Container _firstBox(Size size) {
    return Container(
              color: const Color(0xffa154ff),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        '운전자라면 꼭 필요한',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.height / 30),
                      ),
                      Text(
                        '내 주변 주차 가능한 카페, 맛집 찾기',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.height / 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '지금 바로 다운로드 하세요',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height / 40),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            await goToDownLoadPage(
                                path:
                                    'https://play.google.com/store/apps/details?id=com.yozmpeople.chaple_app');
                          },
                          child: Image.asset('assets/playstore_button.png',
                              width: 150)),
                      const SizedBox(width: 20),
                      InkWell(
                          onTap: () async {
                            await goToDownLoadPage(
                                path:
                                    'https://itunes.apple.com/app/id6443525283');
                          },
                          child: Image.asset('assets/appstore_button.png',
                              width: 150)),
                    ],
                  ),
                  Image.asset(
                    'assets/phone01.png',
                    width: 300,
                  )
                ],
              ),
            );
  }

  Row _widgetForWeb({
    required Size size,
    required String img,
    required String title,
    required String content,
    bool rightImg = true,
  }) {
    if (rightImg) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height / 35),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height / 50,
                    color: Colors.black54),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.05),
          Image.asset(img, width: 300),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, width: 300),
          SizedBox(width: size.width * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height / 35),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height / 50,
                    color: Colors.black54),
              ),
            ],
          ),
        ],
      );
    }
  }

  Column _widgetForMobile(
      {required String img,
      required String title,
      required String content1,
      required String content2,
      String? content3}) {
    return Column(
      children: [
        Image.asset(img, width: 250),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          content1,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        Text(
          content2,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        if(content3 != null)
          Text(
            content3,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54),
          )
      ],
    );
  }

  Column _companyInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  await goToDownLoadPage(
                      path:
                      'https://dour-atlasaurus-06a.notion.site/d116f74d9a9b483aaae8854e262b6187');
                },
                child: const Text('개인정보처리방침',
                    style: TextStyle(color: Colors.black87))),
            TextButton(
                onPressed: () async {
                  await goToDownLoadPage(
                      path:
                      'https://dour-atlasaurus-06a.notion.site/ae80e09062d44f258aae7acf2a0bc91f');
                },
                child: const Text(
                  '이용약관',
                  style: TextStyle(color: Colors.black87),
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Copyrightt 2022, YOZMPEOPLE',
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              'All Rights Reserved',
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Divider _buildDivider() =>
      const Divider(height: 150, thickness: 1, indent: 40, endIndent: 40);

  Future<void> goToDownLoadPage({required String path}) async {
    final url = Uri.parse(path);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Fluttertoast.showToast(
          msg: '다시 시도해주세요',
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          webPosition: 'center',
          webBgColor: "linear-gradient(to right, #a154ff, #a154ff)",
          backgroundColor: const Color(0xffa154ff).withOpacity(0.95),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
