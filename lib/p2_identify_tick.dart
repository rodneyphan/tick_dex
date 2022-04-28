//  p2_identify_tick.dart

import 'package:flutter/material.dart';
import 'data_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

String heroTick = 'deer_tick'; // only for initialization
const String _indexPrefsKey = 'index_key';
const String _stagePrefsKey = 'stage_key';

class TickListDisplay extends StatefulWidget {
  const TickListDisplay({Key? key}) : super(key: key);

  @override
  TickListState createState() => TickListState();
}

class TickListState extends State<TickListDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: const Text(
            "TICK IDENTIFIER - Click pictures to enlarge and examine.\nMake note of sex/stage, THEN CLICK ON TICK'S NAME.",
            style: TextStyle(color: Colors.brown)),
      ),
      body:
          Padding(padding: const EdgeInsets.all(8.0), child: DisplayTickList()),
    );
  }
} // end of TickListState

enum Choice { male, female, nymph, larva }

class DisplayTickList extends StatelessWidget {
  DisplayTickList({Key? key}) : super(key: key);

  final List<Tick> listOfTicks = tickList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfTicks.length,
      itemBuilder: buildListBody,
    );
  }

  Widget buildListBody(BuildContext context, int index) {
    int tappedIndex = -1;
    String imageLocation =
        'assets/images/' + listOfTicks[index].picName + '.png';

    return ListTile(
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          tappedIndex = index;
        },
        child: Container(
          width: 90,
          height: 160,
          color: tappedIndex == index ? Colors.blue : Colors.grey,
          padding: const EdgeInsets.all(3.0),
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 300,
            height: 300,
            child: GestureDetector(
              onTap: () {
                heroTick = listOfTicks[index].picName;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HeroPage()),
                );
              },
              child: Hero(
                  tag: "enlarged_image",
                  child: Expanded(
                    child: Image.asset(imageLocation),
                  )),
            ),
          ),
        ),
      ),
      title: Text(
          listOfTicks[index].commonName +
              " (" +
              listOfTicks[index].scientificName +
              ")",
          textScaleFactor: 1.2,
          style: const TextStyle(color: Colors.brown)),
      subtitle: Text("Associated illnesses: " + listOfTicks[index].diseases,
          style: const TextStyle(color: Colors.green)),
      onTap: () => _onContactTapped(context, listOfTicks[index], index),
    );
  }
}

void _onContactTapped(BuildContext context, Tick tappedContact, int index) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Column(
      children: <Widget>[
        Text(
          "Name of tick: " +
              tappedContact.commonName +
              "\n\nNow click: Male, Female, Larva, or Nymph\n",
          textScaleFactor: 1.5,
        ),
        const RadioList(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 280,
            child: ElevatedButton(
              child: const Text('DONE: GO TO GEOLOCATOR'),
              onPressed: () {
                _updateIndex(index);
                _navToScreen3(context);
              },
            ),
          ),
        ),
      ],
    ),
    duration: const Duration(
      seconds: 8,
    ),
    backgroundColor: Colors.lightGreen,
    // action: _navToScreen3(context),
  )); // showSnackBar
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
        ListTile(
          title: const Text('Male'),
          leading: Radio<Choice>(
            value: Choice.male,
            groupValue: _choice,
            onChanged: (Choice? value) {
              setState(() {
                _choice = value;
                _updateStage(_choice.toString().substring(7));
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female'),
          leading: Radio<Choice>(
            value: Choice.female,
            groupValue: _choice,
            onChanged: (Choice? value) {
              setState(() {
                _choice = value;
                _updateStage(_choice.toString());
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Larva'),
          leading: Radio<Choice>(
            value: Choice.larva,
            groupValue: _choice,
            onChanged: (Choice? value) {
              setState(() {
                _choice = value;
                _updateStage(_choice.toString());
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Nymph'),
          leading: Radio<Choice>(
            value: Choice.nymph,
            groupValue: _choice,
            onChanged: (Choice? value) {
              setState(() {
                _choice = value;
                _updateStage(_choice.toString());
              });
            },
          ),
        ),
      ],
    );
  }
}

Future<void> _updateStage(String stage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(_stagePrefsKey, stage);
}

Future<void> _updateIndex(int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setInt(_indexPrefsKey, index);
}

void _navToScreen3(BuildContext context) async {
  await Navigator.pushNamed(context, 'third');
}

class HeroPage extends StatelessWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Hero(
              tag: "enlarged-image",
              child: Container(
                width: double.infinity,
                height: 450.0,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    heroImage(heroTick),
                    const Text("\nClick image to return to tick list")
                  ],
                ),
              ),
            )));
  }

  Widget heroImage(String heroTick) {
    String imageLocation = 'assets/images/' + heroTick + '.png';
    return Container(
        width: double.infinity,
        height: 400.0,
        alignment: Alignment.bottomCenter,
        child: Image.asset(imageLocation));
  }
}
