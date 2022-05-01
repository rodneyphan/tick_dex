import 'package:flutter/material.dart';
import 'data_file.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _indexPrefsKey = 'index_key';
const String _stagePrefsKey = 'stage_key';

bool? burrowedIn = false;

class RiskAssessment extends StatefulWidget {
  const RiskAssessment({Key? key}) : super(key: key);

  @override
  RiskAssessState createState() => RiskAssessState();
}

class RiskAssessState extends State<RiskAssessment> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  int tickIndex = 0;
  String tickSexStage = 'tick';
  bool highRiskArea = false;
  String areaRiskStr = 'low-risk';
  String burrowed = 'not ';
  String overRisk = 'extremely small';
  double latitude = 0;
  double longitude = 0;
  bool showRisk = false;
  double distOne = 0;
  double distTwo = 0;
  double radOne = 9.2;
  double radTwo = 5.02;

  @override
  void initState() {
    super.initState();
    _getValues();
    _getLastKnownPosition();
  }


  bool areaRisk() {
    bool areaRiskTemp = false;
    _getLastKnownPosition();
    distOne = sqrt( pow( latitude - 42, 2 ) + pow( longitude - -77.3, 2 ) );
    distTwo = sqrt( pow( latitude - 45, 2 ) + pow( longitude - -92, 2 ) );
    if ((distOne < radOne) || (distTwo < radTwo)) { areaRiskTemp = true; }
    else { areaRiskTemp = false; }
    return areaRiskTemp;
  }

  String riskFromArea() {
    highRiskArea = areaRisk();
    if (highRiskArea) {
      areaRiskStr = 'moderate-risk';
    } else {
      areaRiskStr = "very low-risk";
    }
    return areaRiskStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "TICK RISK ASSESSOR - Based on your input...",
          style: TextStyle(color: Colors.brown),
          textScaleFactor: 1.2,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan( style: const TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                    text: "  So you have encountered a " +
                      tickList[tickIndex].commonName +
                      "   ")
                  ],
                ),
              ),
            ),
            SizedBox( width: 100, height: 100,
              child: Image.asset( "assets/images/" + tickList[tickIndex].picName + ".png")
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                children: <TextSpan>[
                  TextSpan( text: "\nAnd you believe it was a " + tickSexStage + " tick.\n"),
                  TextSpan( text: "\nAlso this app geolocated your tick to a " + riskFromArea() + " area of the country for "
                    "Lyme's Disease, which is the disease that is the most prevalent with many times more cases and deaths than other "
                    "tick-borne diseases.\n"
                    "\nBelow is a map of the US with areas of high prevalence of Lyme's Disease shown in red and orange. Since Lyme's Disease is the most common "
                    "tick-borne disease resulting in the majority of tick-borne disease deaths, the authors of this app based our rough assessment of disease "
                    "risk on whether or not you or your loved one is within one of the circles shown. (Exceptions: southeastern Michigan and northwestern Ohio.)\n"
                    "\nCLICK ON IMAGE TO ENLARGE."  ),
                  ],
                ),
              ),
            GestureDetector(behavior: HitTestBehavior.translucent,
              onTap: () {  },
              child: Container(width: 200, height: 140,
                padding: const EdgeInsets.all(3.0),
                alignment: Alignment.centerLeft,
                child: SizedBox( width: 200, height: 200,
                  child: GestureDetector( onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => const HeroMap() ), ); },
                    child: Hero( tag: "enlarged_map",
                      child: Expanded( child: Image.asset( "assets/images/lymedis_map.png" ), )
                      ),
                  ),
                ),
              ),
            ),
            const BurrowedCheckBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
                child: SizedBox( width: 300,
                  child: ElevatedButton( style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>( Colors.lightGreen)),
                    child: const Text( 'Continue to your assessment...', style: TextStyle(color: Colors.brown), ),
                    onPressed: () { setState(() { showRisk = true; }); }
                    ),
                ),
              ),
            Container( child: showRisk ? displayOverallRisk() : const Text(''), ),
            ],
          ),
        ),
      );
  }

  Widget displayOverallRisk() {
    final String overRisk = assessTheOverallRisk(context, burrowedIn!);
    return Column( children: <Widget> [
      Padding( padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan( style: const TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            children: <TextSpan>[
              const TextSpan(text: "So you, or a loved one, has"),
              burrowedIn!
                ? const TextSpan(text: " ")
                : const TextSpan(text: " not "),
              const TextSpan( text: "had a tick burrow it's head into the skin.\n"),
              TextSpan( text: "\nThe assessment of this app is that your overall risk of obtaining a tick-borne disease is " + overRisk +
                    " based on inputed variables.   Your overall risk of dying from a tick-borne illness is extremely small. "),
            ],
          ),
        ),
      ),
    Padding( padding: const EdgeInsets.all(8.0),
      child: SizedBox( width: 190,
        child: ElevatedButton( style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>( Colors.amber ) ),
          child: const Text('BACK TO BEGINNING', style: TextStyle( color: Colors.brown ), ),
          onPressed: ( ) { _navToScreen1(context); },
          ),
        ),
      ),
    ]
  );
}

  String assessTheOverallRisk(context, bool burrowedIn) {
    final String overallRisk;
    if (burrowedIn) {
      if ((tickIndex == 0) || (tickIndex == 9)) {
        if (highRiskArea == true) {
          overallRisk = 'moderate';
        } else {
          overallRisk = 'low';
        }
      } else {
        overallRisk = 'very low';
      }
    } else {
      overallRisk = 'practically zero';
    }
    return overallRisk;
  }

  Future<void> _getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tickIndex = prefs.getInt(_indexPrefsKey) ?? 0;
    tickSexStage = prefs.getString(_stagePrefsKey) ?? "tick";
  }

  void _getLastKnownPosition() async {
    final position = await _geolocatorPlatform.getLastKnownPosition();
    latitude = position?.latitude ?? 0;
    longitude = position?.longitude ?? 0;
    setState(() {

    });
  }
}

class BurrowedCheckBox extends StatefulWidget {
  const BurrowedCheckBox({Key? key}) : super(key: key);

  @override
  BurrowedCheckBoxState createState() => BurrowedCheckBoxState();
} // End of BurrowedCheckBox

class BurrowedCheckBoxState extends State<BurrowedCheckBox> {
  BurrowedCheckBoxState({Key? key});

  @override
  Widget build(BuildContext context) {
    return
      Column(children: <Widget>[
        RichText(
          text: const TextSpan(
            style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            children: <TextSpan>[
              TextSpan( text: "One important factor is whether the tick got a chance to burrow into the skin, which means "
                       "that the mouth or head is at least partially inside the person and not just on the person."),
            ],
          ),
        ),
        Row( children: <Widget> [
          const Text( "\nDid the tick burrow into the skin?   Check if YES "),
          Checkbox(
            value: burrowedIn,
            onChanged: chkBxValueChanged,
          )
        ],
        ),
      ]
      );
  } // end of BurrowedCheckBoxState

  void chkBxValueChanged(bool? newValue) {
    setState(() {
      burrowedIn = newValue;
    });
  } // end of chkBxValueChanged

}

class HeroMap extends StatelessWidget {
  const HeroMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(onTap: () { Navigator.pop(context); },
            child: Hero(tag: "enlarged-map",
              child: Container(width: double.infinity, height: 432.0,
                alignment: Alignment.center,
                child: Column( mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    heroImage("assets/images/lymedis_map.png"),
                    const Text("\nClick image to return to the risk assessment" )
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget heroImage(String heroMap) {
    return
      Container(width: double.infinity, height: 400.0,
          alignment: Alignment.bottomCenter,
          child: Image.asset(heroMap)
      );
  }
}

void _navToScreen1 ( BuildContext context) async {
  await Navigator.pushNamed(context, 'first'); }

