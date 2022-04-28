// data_file.dart

import 'package:flutter/cupertino.dart';
import 'p1_introduction.dart';
import 'p2_identify_tick.dart';
import 'p3_geolocator.dart';
import 'p4_disease_list.dart';
import 'p5_risk_assessment.dart';

var myNavRoutes = <String, WidgetBuilder>{
  'first': (context) => const Introduction(),
  'second': (context) => const TickListDisplay(),
  'third': (context) => const GeolocatorWidget(),
  'fourth': (context) => const DiseaseListDisplay(),
  'fifth': (context) => const RiskAssessment()
};

String appTitle = 'Tick-Dex';

class Tick {
  final String commonName;
  final String scientificName;
  final String diseases;
  final String picName;

  Tick(this.commonName, this.scientificName, this.diseases, this.picName);
}

// Data was hard-coded because we were concerned that the app could not be used "out in the field" such as when hiker's might use it, or where cell reception was poor
List<Tick> tickList = [
  Tick(
      "Deer or Blacklegged tick",
      "Ixodes scapularis",
      "Lyme's Disease, Anaplasmosis, Babesiosis, Powassan Encephalitis",
      "deer_tick"),
  Tick("American dog tick", "Dermacentor variabilis ",
      "Rocky Mountain Spotted Fever, Tularemia", "american_dog_tick"),
  Tick("Brown dog tick", "Rhipicephalus sanguineus",
      "Rocky Mountain Spotted Fever, Q Fever", "brown_dog_tick"),
  Tick("Groundhog tick", "Ixodes cookei", "Powassan Encephalitis",
      "groundhog_tick"),
  Tick(
      "Western Blacklegged tick",
      "Ixodes pacificus",
      "Borreliosis (a relapsing fever), Ehrlichiosis, Anaplasmosis",
      "west_blackleg_tick"),
  Tick(
      "Pacific Coast tick",
      "Dermacentor occidentalis",
      "Rocky Mountain Spotted Fever, Colorado Tick Fever, Tularemia, Q Fever",
      "pac_coast_tick"),
  Tick(
      "Lone Star tick",
      "Amblyomma americanum",
      "Southern Tick Rash Illness, Heartland Virus, Tularemia, Ehrlichiosis, Q Fever",
      "lone_star_tick"),
  Tick(
      "Rocky Mountain Wood tick",
      "Rickettsia rickettsii",
      "Rocky Mountain Spotted Fever, Colorado Tick Fever, Tularemia, Q Fever",
      "rocky_mtn_wood_tick"),
  Tick("Cayenne tick", "Amblyomma cajennense", "Rocky Mountain Spotted Fever",
      "cayenne_tick"),
  Tick(
      "Ixodes Ticks - multiple species",
      "Ixodes xxxxxx",
      "Lyme's Disease, Babesiosis, Powassan Encephalitis, Anaplasmosis",
      "ixodes_ticks"),
  Tick("African tick", "Amblyomma hebraeum or variegatum",
      "Tick-borne Relapsing Fever", "african_tick"),
  Tick("Soft ticks", "Ornithodoros", "Tick-borne Relapsing Fever", "soft_ticks")
];

class Disease {
  String disName;
  String disCasesPerYear;
  String disURL;

  Disease(this.disName, this.disCasesPerYear, this.disURL);
}

// Data was hard-coded because we were concerned that the app could not be used "out in the field" such as when hiker's might use it, or where cell reception was poor
List<Disease> diseaseList = [
  Disease("Lyme's Disease", "34,945", "https://www.cdc.gov/niosh/topics/lyme/"),
  Disease("Anaplasmosis", "5,655",
      "https://www.health.state.mn.us/diseases/anaplasmosis/basics.html"),
  Disease("Rocky Mountain Spotted Fever", "5,207",
      "https://www.cdc.gov/rmsf/stats/index.html"),
  Disease("Babesiosis", "2,420",
      "https://www.cdc.gov/parasites/babesiosis/index.html"),
  Disease("Ehrlichiosis", "2,093",
      "https://www.cdc.gov/ehrlichiosis/symptoms/index.html"),
  Disease("Tularemia", "274",
      "https://www.mayoclinic.org/diseases-conditions/tularemia/symptoms-causes/syc-20378635"),
  Disease("Q Fever", "179", "https://www.cdc.gov/qfever/"),
  Disease("Heartland Virus","about 50", "https://www.cdc.gov/heartland-virus/symptoms-treatment/index.html"),
  Disease("Powassan Encephalitis", "43", "https://www.cdc.gov/powassan/index.html"),
  Disease("Tick-borne Relapsing Fever", "23",
      "https://doh.wa.gov/you-and-your-family/illness-and-disease-z/tick-borne-relapsing-fever"),
  Disease("Colorado Tick Fever", "6",
      "https://www.cdc.gov/coloradotickfever/index.html"),
  Disease("Southern Tick Rash Illness", "Not Reported",
      "https://www.floridahealth.gov/diseases-and-conditions/southern-tick-rash-illness/index.html")
];

// ------------- End of data_file.dart ---------------
