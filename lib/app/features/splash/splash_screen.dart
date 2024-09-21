import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../meme_home/meme_home_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    goToNextPage();
    super.initState();
  }

  goToNextPage() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const MemeHomeScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorConst.splashScreenSecondColor,
              ColorConst.splashScreenFirstColor,
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/meme.png'),
              ),
              const Text(
                'Memes',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
