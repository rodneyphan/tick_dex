import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'data_file.dart';

class DiseaseListDisplay extends StatefulWidget {

  const DiseaseListDisplay({Key? key}) : super(key: key);

  @override
  DiseaseListState createState() => DiseaseListState();
}

class DiseaseListState extends State<DiseaseListDisplay> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.yellowAccent,
          title: const Text("Tick-Borne Illnesses in the US",
              style: TextStyle(color: Colors.brown)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DisplayDiseaseList()
        )
    );
  }

} // end of DiseaseListState

class DisplayDiseaseList extends StatelessWidget {

  DisplayDiseaseList({Key? key}) : super(key: key);

  final List<Disease> listOfDiseases = diseaseList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfDiseases.length,
      itemBuilder: buildListBody,
    );
  }

  Widget buildListBody(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 380,
          child: ListTile(
              title: Text(listOfDiseases[ index ].disName, textScaleFactor: 1.3,
                  style: const TextStyle(color: Colors.brown)),
              subtitle: Text("  Cases in US for 2019:  " +
                  listOfDiseases[index].disCasesPerYear,
                  style: const TextStyle(color: Colors.green)),
              trailing: ElevatedButton(
                child: const Text("Open Website"),
                onPressed: () => onBtnClicked(listOfDiseases[index].disURL),
              ),
          ),
        ),

      ],
    );
  }

  onBtnClicked(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }

}
// end of p4_disease_list.dart
