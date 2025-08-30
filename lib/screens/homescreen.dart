import 'package:auth/screens/countriesPage.dart';
import 'package:auth/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -5.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Login()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 107, 155, 246),

      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesPage()));
          if (_controller.status != AnimationStatus.completed) {
            _controller.forward();
          }
        },
        child: Center(
          child: SlideTransition(
            position: _animation,
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Kajkarma Innovations',
                  textStyle: GoogleFonts.kaushanScript(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Colors.white,
                    Colors.blue,
                    Colors.purple,
                    Colors.orange,
                  ],
                  textAlign: TextAlign.center,
                ),
              ],
              isRepeatingAnimation: true,
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const LoginPage()),
      //     );
      //   },

      //   shape: CircleBorder(),
      //   splashColor: const Color.fromARGB(255, 119, 136, 166),
      //   elevation: 10,
      //   highlightElevation: 16,
      //   child: Icon(
      //     Icons.arrow_forward_ios,
      //     color: const Color.fromARGB(255, 68, 137, 255),
      //     size: 30,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
