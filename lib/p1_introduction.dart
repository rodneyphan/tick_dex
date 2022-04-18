//  p1_introduction.dart

import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {

  const Introduction({Key? key}) : super(key: key);

  @override
  IntroductionState createState() => IntroductionState();
}

class IntroductionState extends State<Introduction> {
  IntroductionState ({Key? key});

  @override
  Widget build (BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(' TICK-DEX, the App - Helping you know more about ticks and their risks...'),
      ),
      body: displayIntro( ),
    );
  } // build (…)

  Widget displayIntro ( ) {

    return Center(
      child: Column(
        children: <Widget>[
          Padding( padding: const EdgeInsets.all(8.0),
            child: SizedBox ( width: 500.0, height: 400.0,
            child: Image.asset( 'assets/images/finger_with4ticks.png' ),
            ),
          ),
          const Text( "\nEach year, 30,000 to 40,000 people in the US will contract Lyme's disease, and", textScaleFactor: 1.5),
          const Text( 'thousands more will contract several other tick-borne diseases, causing 20-30', textScaleFactor: 1.5),
          const Text( 'deaths to Americans each year. (Click TICK-BORNE DISEASES button for a list.)', textScaleFactor: 1.5),
          const Text( 'The best way to reduce the risks of you or a loved one contracting one of these', textScaleFactor: 1.5),
          const Text( 'diseases is to reduce your exposure to ticks or if this is not possible, to wear', textScaleFactor: 1.5),
          const Text( 'protective clothing while outdoors and to promptly remove ticks from your body.\n', textScaleFactor: 1.5),
          const Text( 'If you have found a tick on you or a loved one, this app will help you know and', textScaleFactor: 1.5),
          const Text( 'understand "tick risks" based on the type of tick and where you are located relative', textScaleFactor: 1.5),
          const Text( 'to others that often find ticks or where and when tick-borne disease is the most', textScaleFactor: 1.5),
          const Text( 'prevalent. Click on the IDENTIFY MY TICK button to access your risks.\n', textScaleFactor: 1.5),

          Padding( padding: const EdgeInsets.all(8.0),
            child: SizedBox( width: 280,
              child: ElevatedButton(
                child: const Text('IDENTIFY MY TICK'),
                onPressed: ( ) { _navToScreen2(context); },
              ),
            ),
          ),
          Padding( padding: const EdgeInsets.all(8.0),
            child: SizedBox( width: 280,
              child: ElevatedButton(
                child: const Text('TICK-BORNE DISEASES'),
                onPressed: ( ) { _navToScreen4(context); },
              ),
            ),
          ),
        ],
      ),
    );
  } // end of _displayImageBody

  void _navToScreen2 ( BuildContext context) async {
    await Navigator.pushNamed(context, 'second'); }

  void _navToScreen4 ( BuildContext context) async {
    await Navigator.pushNamed(context, 'fourth'); }

} // end of DisplayImage class
// --- end of display_file.dart
