import 'package:flutter/material.dart';
import 'data_file.dart';

class RiskAssessment extends StatelessWidget {

  RiskAssessment({Key? key}) : super(key: key);
  final int tickIndex = 0;                  //  just for initialization, NEEDS TO BE READ FROM FIREBASE OR PASSED FROM PREVIOUS PAGE
  final String tickSexStage = 'nymph.';     //  just for initialization, NEEDS TO BE READ FROM FIREBASE OR PASSED FROM PREVIOUS PAGE
  final bool highRiskArea = false;          //  just for initialization, NEEDS TO BE READ FROM FIREBASE OR PASSED FROM PREVIOUS PAGE
  String areaRisk = 'low-risk';             //  just for initialization
  bool burrowedIn = false;                  //  just for initialization
  String burrowed = 'not ';                 //  just for initialization
  String overRisk = 'extremely small';      //  just for initialization

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
      appBar: AppBar(backgroundColor: Colors.yellowAccent,
        title: const Text("TICK RISK ASSESSOR - Based on your input...",
          style: TextStyle(color: Colors.brown), textScaleFactor: 1.7,),
      ),
      body: Padding(padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Text(
                "So you have encountered a " + tickList[tickIndex].commonName,
                textScaleFactor: 1.6,),
              SizedBox(width: 100, height: 100,
                  child: Image.asset(
                      "images/" + tickList[tickIndex].picName + ".png")),
              ],
            ),
            Text(" and you believe it was a " + tickSexStage,
              textScaleFactor: 1.6,),
            Text("And this app geolocated your tick to a " + areaRisk +
                " area of the country for Lyme's Disease.\n",
              textScaleFactor: 1.6,),
            const BurrowedCheckBox(),
            Padding(padding: const EdgeInsets.all(8.0),
              child: SizedBox(width: 250,
                child: ElevatedButton(style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreen)),
                  child: const Text(
                    'Continue to your overall risk assessment ...',
                    style: TextStyle(color: Colors.brown),),
                  onPressed: () { assessTheOverallRisk(context, burrowedIn); },
                ),
              ),
            ),
            Row(children: <Widget>[
              const Text("So you, or a loved one, has"), burrowedIn ? const Text(' ') : const Text('not '), const Text("had a tick burrow it's head into the skin.\n"),
              ],
             ),
          Text( "The assessment of this app is that your overall risk of obtaining a tick-borne disease is " + overRisk + " based on inputed variables." ),
          const Text( "Your overall risk of dying from a tick-borne illness is extremely small. "),
          ],
        )
      ),
    );
  }

  String assessTheOverallRisk(context, bool burrowedIn) {
    final String overallRisk;
    if (burrowedIn) {
      if ((tickIndex == 0) || (tickIndex == 9))
        { if (highRiskArea == true)
            { overallRisk = 'moderate'; }
          else { overallRisk = 'low'; } }
      else
        { overallRisk = 'very low'; }
    }
    else { overallRisk = 'practically zero'; }
    return overallRisk;
    }
  }

class BurrowedCheckBox extends StatefulWidget{
  const  BurrowedCheckBox ({Key? key }) : super(key: key);

  @override
  BurrowedCheckBoxState   createState() =>  BurrowedCheckBoxState();

}   // End of BurrowedCheckBox

class BurrowedCheckBoxState extends State<BurrowedCheckBox> {
  BurrowedCheckBoxState ({Key? key });
  bool?  burrowedIn = false;
  @override
  Widget build(BuildContext context) {
    return Column( children:  <Widget> [
      Row( children: <Widget> [
      const Text( "Did the tick burrow into the skin? Check if YES  ", textScaleFactor: 2.0, ),
      Checkbox( value: burrowedIn, onChanged: chkBxValueChanged, )
        ],
       ),
      ]
    );
  }  // end of BurrowedCheckBoxState

  void chkBxValueChanged(bool? newValue){
    setState( ( ) { burrowedIn = newValue;
    }); }  // end of chkBxValueChanged

}

//  TODO  Needs an reset/restart or exit button.
