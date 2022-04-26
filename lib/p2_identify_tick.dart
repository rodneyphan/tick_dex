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
          title: const Text("Tick-Identifier"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DisplayTickList( )
        )
    );
  }

} // end of TickListState

class DisplayTickList extends StatelessWidget {

  DisplayTickList ({Key? key}) : super(key: key);

  final List<Tick> listOfTicks = tickList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfTicks.length,
      itemBuilder: buildListBody,
    );
  }

  Widget buildListBody(BuildContext context, int index) {
    return
      SizedBox(width: 600,
        child: ListTile(
          leading: GestureDetector( behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Container(width: 30, height: 30,
            padding: const EdgeInsets.symmetric(vertical: 4.0), alignment: Alignment.center,
            child: CircleAvatar( radius: 30.0, backgroundColor: Colors.brown,
              child: ClipRect( child: Image.asset( 'images/' + listOfTicks[index].picName + '.png' ), ),
              ),
            ),
          ),
        title: Text(listOfTicks[ index ].commonName + " (" + listOfTicks[index].scientificName + ")",
                        textScaleFactor: 1.5),
        subtitle: Text( "Associated illnesses: " + listOfTicks[index].diseases),
        ),
      );
  }

}
