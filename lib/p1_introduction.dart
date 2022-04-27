//  p1_introduction.dart

import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  IntroductionState createState() => IntroductionState();
}

class IntroductionState extends State<Introduction> {
  IntroductionState({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: const Text(
            ' TICK-DEX - Helping us learn about TICKS and RISKS...',
            style: TextStyle(color: Colors.brown)),
      ),
      body: displayIntro(),
    );
  } // build (…)

  Widget displayIntro() {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400.0,
              height: 350.0,
              child: Image.asset('images/finger_with4ticks.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "\nEach year, 30,000 to 40,000 people in the US will contract Lyme's disease, and thousands more will contract "
                          "several other tick-borne diseases, causing 20-30 deaths to Americans each year. (Click the TICK-BORNE DISEASES button to see a list.) "
                          "The best way to reduce the risks of you or a loved one contracting one of these diseases is to reduce your exposure to ticks or if "
                          "this is not possible, to wear protective clothing while outdoors and to promptly remove ticks from your body.\n\nIf you have found a "
                          "tick on you or a loved one, this app will help you know and understand 'tick risks' based on the type of tick, diseases carried by "
                          "that tick, and where and when tick-borne disease is the most prevalent.\n\nClick on the IDENTIFY MY TICK button to start to access "
                          "your risks.\n"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 190,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellowAccent)),
                child: const Text('IDENTIFY MY TICK',
                    style: TextStyle(color: Colors.brown)),
                onPressed: () {
                  _navToScreen2(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 190,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen)),
                child: const Text(
                  'TICK-BORNE DISEASES',
                  style: TextStyle(color: Colors.brown),
                ),
                onPressed: () {
                  _navToScreen4(context);
                },
              ),
            ),
          ),
        ],
      ),
    ));
  } // end of _displayImageBody

  void _navToScreen2(BuildContext context) async {
    await Navigator.pushNamed(context, 'second');
  }

  void _navToScreen4(BuildContext context) async {
    await Navigator.pushNamed(context, 'fourth');
  }
} // end of IntroductionState class
// --- end of p1_introduction.dart
