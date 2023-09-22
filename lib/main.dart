import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:halliq/main/utils/AppConstant.dart';
import 'package:halliq/main/utils/AppWidget.dart';
import 'package:halliq/main/store/AppStore.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'locale/Languages.dart';

/// This variable is used to get dynamic colors when theme mode is changed
AppStore appStore = AppStore();

BaseLanguage? language;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;

  bool _isVisible = false;
  bool _isNonVisible = true;

  double _width = 300;
  double _height = 300;
  String _text1 = 'هيّا\n نأكل ألوان الطيف!';
  String _text3 = 'حرّك العجلة لنرى ماذا سنجرّب في وجبتنا القادمة';

  Color _purple = Color(0xff4A5D9B);
  Color _white = Color(0xffffffff);
  Color _blue = Color(0xff5FBCBD);

  List<String> _images = [
    "assets/images/tire.png",
    "assets/images/tire_1.png",
    "assets/images/tire_2.png",
    "assets/images/tire_3.png",
    "assets/images/tire_4.png",
    "assets/images/tire_5.png",
    "assets/images/tire_6.png",
    "assets/images/tire_7.png",
    "assets/images/tire_8.png",
    "assets/images/tire_9.png",
    "assets/images/tire_10.png",
    "assets/images/tire_11.png",
    "assets/images/tire_12.png",
  ];

  List<String> _bgImg = [
    "assets/images/purplebg.png",
    "assets/images/greybg.png",
  ];

  List<String> _halliqLogo = [
    "assets/images/halliqlogo2.png",
    "assets/images/halliqlogo1.png",
  ];

  Future<void> animateTire() async {
    _controller.forward();

    await Future.delayed(const Duration(seconds: 2));

    _stopTireShowImage();
  }

  void _stopTireShowImage() {
    _controller.stop();
    _controller.reset();

    setState(() {
      _isVisible = !_isVisible;
      _isNonVisible = !_isNonVisible;
      _width = 0.toDouble();
      _height = 0.toDouble();
      _text1 = 'رائع!';
      _text3 = 'شارك معنا فيديو لتجربتك، وصِف لنا المذاق الجديد!';
      _purple = Color(0xffffffff);
      _white = Color(0xff4A5D9B);

      _images.removeAt(0);
      _images.shuffle();
      _halliqLogo.removeAt(0);
      _bgImg.removeAt(0);
    });
  }

  void _shareYourExperience() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image(image: AssetImage('assets/images/share1.png')),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String tireImage = _images[0];
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_bgImg[0]),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _text1,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: _white,
                  fontFamily: 'BalooBhaijaan2',
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                _text3,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'BalooBhaijaan2',
                  color: _white,
                ),
              ).paddingBottom(8),
              3.height,
              Stack(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    child: AnimatedContainer(
                      width: _width,
                      height: _height,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOutQuint,
                      child: Image(
                        image: AssetImage(tireImage),
                      ),
                      onEnd: () {
                        setState(() {
                          // Set the width and height back to sizes you want.
                          _width = 300;
                          _height = 300;
                        });
                      },
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Transform.rotate(
                        angle: _controller.value * 2.0 * math.pi,
                        child: child,
                      );
                    },
                  ),
                  Visibility(
                    visible: _isNonVisible,
                    child: Positioned(
                      left: 120,
                      top: 120,
                      child: FloatingActionButton(
                        onPressed: animateTire,
                        tooltip: 'ابدأ',
                        backgroundColor: _blue,
                        child: Text(
                          'ابدأ',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontFamily: 'BalooBhaijaan2',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              10.height,
              Visibility(
                visible: _isVisible,
                child: Column(
                  children: [
                    Text(
                      'شارك واحصل على فرصة الفوز بأحد منتجاتنا مجانًا!',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'BalooBhaijaan2',
                        color: _white,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _blue,
                        minimumSize: Size(250, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _shareYourExperience,
                      child: Text(
                        'مشاركة',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 22,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'BalooBhaijaan2',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              15.height,
              Image(
                image: AssetImage(_halliqLogo[0]),
                width: 55,
                height: 55,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: InkWell(
        child: Icon(
          FontAwesomeIcons.instagram,
          color: _white,
        ), //child widget inside this button
        onTap: () {
          launch('https://www.instagram.com/halliq.sa');
        },
      ),
    );
  }
}
