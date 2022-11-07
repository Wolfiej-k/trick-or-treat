import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(const TrickOrTreat());

class TrickOrTreat extends StatelessWidget {
  const TrickOrTreat({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Trick or Treat!',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.orange.shade500,
          secondary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(title: 'Trick or Treat!'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = ['assets/images/cat.jpg', 'assets/images/corn.webp', 'assets/images/pumpkin.jpg', 'assets/images/scary.jpg'];
  int counter = 0;
  int time = 20;
  late Timer timer;
  
  void incrementCounter() {
    if (time == 20) {
      startTimer();
    }

    if (time > 0) {
      setState(() => counter++);
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (time == 0 || counter >= 10) {
          setState(() => timer.cancel());
        } else {
          setState(() => time--);
        }
      }
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cobwebs.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              displayScore(),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: <Widget>[
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                    displayButton(),
                  ],
                ),
              ),
              displayTimer(),
            ],
          )
        ),
      )
    );
  }

  Widget displayScore() {
    return Text(
      (counter < 10) ? 'Score: $counter' : 'Happy Halloween!',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 54.0,
        fontFamily: 'Creepster',
        height: 1.5,
        color: Color.fromARGB(255, 255, 152, 0),
      ),
    );
  }

  Widget displayButton() {
    final random = Random();
    String image = images[random.nextInt(4)];

    if (counter == 0 || counter >= 10 || random.nextInt(2) > 0) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(40.0))
          ),
          child: InkWell(
            onTap: incrementCounter,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget displayTimer() {
    return Text(
      (counter < 10) ? '$time seconds' : '',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 48.0,
        fontFamily: 'Creepster',
        height: 1.5,
        color: Color.fromARGB(255, 255, 152, 0),
      ),
    );
  }
}