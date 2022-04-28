import 'package:flutter/material.dart';
import 'data_file.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _indexPrefsKey = 'index_key';
const String _stagePrefsKey = 'stage_key';

class RiskAssessment extends StatefulWidget {
  const RiskAssessment({Key? key}) : super(key: key);

  @override
  RiskAssessState createState() => RiskAssessState();
}

class RiskAssessState extends State<RiskAssessment> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  int tickIndex = 0; //  just for initialization
  String tickSexStage = 'male'; //  just for initialization
  bool highRiskArea = false; //  just for initialization
  String areaRiskStr = 'low-risk'; //  just for initialization
  bool burrowedIn = false; //  just for initialization
  String burrowed = 'not '; //  just for initialization
  String overRisk = 'extremely small'; //  just for initialization
  double latitude = 0; //  just for initialization
  double longitude = 0; //  just for initialization
  bool showRisk = false;
  double distOne = 0;
  double distTwo = 0;
  double radOne = 10.519;
  double radTwo = 6.519;

  @override
  void initState() {
    super.initState();
    _getValues();
    _getLastKnownPosition();
  }

  bool areaRisk() {
    bool areaRiskTemp = false;
    _getLastKnownPosition();
    distOne = sqrt( pow( latitude - 41.94, 2 ) + pow( longitude - -77.26, 2 ) );
    distTwo = sqrt( pow( latitude - 45.39, 2 ) + pow( longitude - -90.91, 2 ) );
    if ((distOne < 10.5) || (distTwo < 6.5)) { areaRiskTemp = true; }
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
        backgroundColor: Colors.yellowAccent,
        title: const Text(
          "TICK RISK ASSESSOR - Based on your input...",
          style: TextStyle(color: Colors.brown),
          textScaleFactor: 1.4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                            text: "  So you have encountered a " +
                                tickList[tickIndex].commonName +
                                "   ")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                        "images/" + tickList[tickIndex].picName + ".png")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                        text: "\nand you believe it was a " +
                            tickSexStage +
                            " tick.\n\n"),
                    TextSpan(
                        text: "Also this app geolocated your tick to a " +
                            areaRiskStr +
                            " area of the country for Lyme's Disease.\n"),
                  ],
                ),
              ),
            ),
            const BurrowedCheckBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightGreen)),
                    child: const Text(
                      'Click to Continue to your assessment...',
                      style: TextStyle(color: Colors.brown),
                    ),
                    onPressed: () {
                      setState(() {
                        showRisk = true;
                      });
                    }),
              ),
            ),
            Container(
              child: showRisk ? displayOverallRisk() : const Text(''),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayOverallRisk() {
    final String overRisk = assessTheOverallRisk(context, burrowedIn);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          children: <TextSpan>[
            const TextSpan(text: "So you, or a loved one, has"),
            burrowedIn
                ? const TextSpan(text: " ")
                : const TextSpan(text: " not "),
            const TextSpan(
                text: "had a tick burrow it's head into the skin.\n"),
            TextSpan(
                text: "The assessment of this app is that your overall risk of obtaining a tick-borne disease is " +
                    overRisk +
                    " based on inputed variables.   Your overall risk of dying from a tick-borne illness is extremely small. "),
          ],
        ),
      ),
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
  }
}

class BurrowedCheckBox extends StatefulWidget {
  const BurrowedCheckBox({Key? key}) : super(key: key);

  @override
  BurrowedCheckBoxState createState() => BurrowedCheckBoxState();
} // End of BurrowedCheckBox

class BurrowedCheckBoxState extends State<BurrowedCheckBox> {
  BurrowedCheckBoxState({Key? key});

  bool? burrowedIn = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
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
                          " Did the tick burrow into the skin?   Check if YES "),
                ],
              ),
            ),
          ),
          Checkbox(
            value: burrowedIn,
            onChanged: chkBxValueChanged,
          )
        ],
      ),
    ]);
  } // end of BurrowedCheckBoxState

  void chkBxValueChanged(bool? newValue) {
    setState(() {
      burrowedIn = newValue;
    });
  } // end of chkBxValueChanged

}

//  TODO  Needs a reset/restart or exit button.
