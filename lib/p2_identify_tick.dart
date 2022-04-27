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
          title: const Text("Tick-Identifier\nClick on the identified tick's row:"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DisplayTickList( )
        )
    );
  }

} // end of TickListState

enum Choice { male, female, nymph, larva }

class DisplayTickList extends StatelessWidget {

  DisplayTickList({Key? key}) : super(key: key);

  final List<Tick> listOfTicks = tickList;
  int tappedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfTicks.length,
      itemBuilder: buildListBody,
    );
  }

  Widget buildListBody(BuildContext context, int index) {
    String imageLocation = 'assets/images/' + listOfTicks[index].picName + '.png';

    return
      SizedBox(width: 500, height: 300 ,
        child: ListTile(
          leading: GestureDetector(behavior: HitTestBehavior.translucent,
            onTap: () { tappedIndex = index; RadioList(); },
            child: Container(width: 150, height: 300,
              color: tappedIndex == index? Colors.blue : Colors.grey,
              padding: const EdgeInsets.all(3.0),
              alignment: Alignment.centerLeft,
              child: Image.asset(imageLocation, height: 300, scale: 2.0, ),
            ),
          ),
          title: Text(listOfTicks[ index ].commonName + " (" +
              listOfTicks[index].scientificName + ")", textScaleFactor: 1.5),
          subtitle: Text(
              "Associated illnesses: " + listOfTicks[index].diseases),
        ),
      );
  }
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
