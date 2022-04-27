import 'package:flutter/material.dart';
import 'data_file.dart';
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
  String tickSexStage = 'tick'; //  just for initialization
  bool highRiskArea = false; //  just for initialization
  String areaRisk = 'low-risk'; //  just for initialization
  bool burrowedIn = false; //  just for initialization
  String burrowed = 'not '; //  just for initialization
  String overRisk = 'extremely small'; //  just for initialization
  double latitude = 0; //  just for initialization
  double longitude = 0; //  just for initialization

  @override
  void initState() {
    super.initState();
    _getValues();
    _getLastKnownPosition();
  }

  String riskFromArea() {
    if (highRiskArea) {
      areaRisk = 'moderate-risk';
    } else {
      areaRisk = "very low-risk";
    }
    return areaRisk;
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
                  Padding( padding: const EdgeInsets.all(8.0),
                    child: RichText (
                      text: const TextSpan( style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15 ),
                      children: <TextSpan>[
                        TextSpan(  text: "So you have encountered a " + tickList[tickIndex].commonName + "   " ) ],
                          ),
                      ),
                    ),
                  SizedBox( width: 100, height: 100,
                      child: Image.asset( "assets/images/" + tickList[tickIndex].picName + ".png")),
                ],
              ),
              Padding( padding: const EdgeInsets.all(8.0),
                child: RichText (
                text: const TextSpan( style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15 ),
                  children: <TextSpan>[
                    TextSpan( text: "\nand you believe it was a " + tickSexStage ),
                    TextSpan( text: "And this app geolocated your tick to a " + areaRisk + " area of the country for Lyme's Disease.\n" ),
                    ],
                  ),
                ),
              ),
              const BurrowedCheckBox(),
              Padding( padding: const EdgeInsets.all(8.0),
                child: SizedBox( width: 250,
                  child: ElevatedButton(
                    style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)),
                    child: const Text( 'Click to Continue to your assessment...',
                      style: TextStyle(color: Colors.brown), ),
                    onPressed: () { assessTheOverallRisk(context, burrowedIn); },
                  ),
                ),
              ),
              Row( children: <Widget>[
                const Text("So you, or a loved one, has"),
                burrowedIn ? const Text(' ') : const Text('not '),
                const Text("had a tick burrow it's head into the skin.\n"),
              ],
              ),
              Text("The assessment of this app is that your overall risk of obtaining a tick-borne disease is " +
                  overRisk + " based on inputed variables."),
              const Text(
                  "Your overall risk of dying from a tick-borne illness is extremely small. "),
            ],
          )),
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
          const Text(
            "Did the tick burrow into the skin? Check if YES  ",
            textScaleFactor: 2.0,
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
