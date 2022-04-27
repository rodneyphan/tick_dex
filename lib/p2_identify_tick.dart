//  p2_identify_tick.dart

import 'package:flutter/material.dart';
import 'data_file.dart';

class TickListDisplay extends StatefulWidget {

  const TickListDisplay ({Key? key}) : super(key: key);

  @override
  TickListState createState() => TickListState();
}

class TickListState extends State<TickListDisplay> {

  @override
  void initState() { super.initState(); }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Identifier - Click on tick name. (Make note of sex/stage.)\nClick the picture to enlarge."),
          ),
        body: Padding( padding: const EdgeInsets.all(8.0),
              child: DisplayTickList( )
          ),
      );
  }

} // end of TickListState

enum Choice { male, female, nymph, larva }

class DisplayTickList extends StatelessWidget {

  DisplayTickList({Key? key}) : super(key: key);

  final List<Tick> listOfTicks = tickList;
  int tappedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfTicks.length,
      itemBuilder: buildListBody,
    );
  }

  Widget buildListBody(BuildContext context, int index) {

    String imageLocation = 'images/' + listOfTicks[index].picName + '.png';

    return
      ListTile(
          leading: GestureDetector(behavior: HitTestBehavior.translucent,
            onTap: () { tappedIndex = index;  },
          child: Container(width: 90, height: 160,
              color: tappedIndex == index? Colors.blue : Colors.grey,
              padding: const EdgeInsets.all(3.0),
              alignment: Alignment.centerLeft,
              child: SizedBox( width: 300, height: 300,
                child: Expanded( child: Image.asset(imageLocation, height: 300, ), ),
              ),
            ),
          ),
          title: Text(listOfTicks[ index ].commonName + " (" +
              listOfTicks[index].scientificName + ")", textScaleFactor: 1.2),
          subtitle: Text(
              "Associated illnesses: " + listOfTicks[index].diseases),
          onTap: ( ) => _onContactTapped( context, listOfTicks[index] ),
      );
  }
}

void _onContactTapped( BuildContext context, Tick tappedContact) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar (
        content: Column(
          children: <Widget> [
            Text( "Name of tick: " + tappedContact.commonName + "\n\nNow click: Male, Female, Larva, or Nymph\n", textScaleFactor: 1.5,),
            const RadioList(),
            ],
          ),
        duration: const Duration( seconds: 8, ),
        backgroundColor: Colors.lightGreen,
        // action:
      )
      ); // showSnackBar
  }

  class RadioList extends StatefulWidget {
    const RadioList({Key? key}) : super(key: key);

  @override
  State<RadioList> createState() => _RadioListState();
  }

  class _RadioListState extends State<RadioList> {
    Choice? _choice = Choice.male;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile( title: const Text('Male'),
          leading: Radio<Choice> (
          value: Choice.male,
          groupValue: _choice,
          onChanged: (Choice? value) { setState(() { _choice = value; }); },
            ),
          ),
        ListTile( title: const Text('Female'),
          leading: Radio<Choice> (
          value: Choice.female,
          groupValue: _choice,
          onChanged: (Choice? value) { setState(() { _choice = value; }); },
            ),
          ),
        ListTile( title: const Text('Larva'),
          leading: Radio<Choice> (
          value: Choice.larva,
          groupValue: _choice,
          onChanged: (Choice? value) { setState(() { _choice = value; }); },
            ),
          ),
        ListTile( title: const Text('Nymph'),
          leading: Radio<Choice> (
          value: Choice.nymph,
          groupValue: _choice,
          onChanged: (Choice? value) { setState(() { _choice = value; }); },
            ),
          ),
        ],
      );
  }

}



