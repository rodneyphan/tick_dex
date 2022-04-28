import 'package:flutter/material.dart';
import 'data_file.dart';
import 'package:url_launcher/url_launcher.dart';

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
        appBar: AppBar(
          title: const Text("Tick-Borne Illnesses"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0), child: DisplayDiseaseList()));
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
      children: <Widget>[
        SizedBox(
          width: 300,
          child: ListTile(
            title: Text(listOfDiseases[index].disName, textScaleFactor: 1.2),
            subtitle: Text("  Cases in US for 2019:  " +
                listOfDiseases[index].disCasesPerYear),
          ),
        ),
        ElevatedButton(
          child: const Text("More Information"),
          onPressed: () => onBtnClicked(listOfDiseases[index].disURL),
        ),
      ],
    );
  }

  onBtnClicked(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
// end of p4_disease_list.dart
