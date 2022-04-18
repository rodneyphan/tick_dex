// data_file.dart

import 'package:flutter/cupertino.dart';
import 'p1_introduction.dart';

var myNavRoutes = <String, WidgetBuilder>
{
  'first': (context) => const  Introduction(),
  // 'second': (context) => const ChooseATick(),
  // 'third': (context) => const Geolocation(),
  //  'fourth': (context) => const DiseasesAndRisks()
};

String appTitle = 'Tick-Dex';

class Tick {
  final String commonName;
  final String scientificName;
  final String diseases;
  final String picName;
  Tick( this.commonName, this.scientificName, this.diseases, this.picName );
}

  List<Tick> tickList = [
    Tick( "Deer or Blacklegged tick", "Ixodes scapularis", "Lyme Disease, Anaplasmosis, Babesiosis, Powassan Encephalitis", "deer_tick"),
    Tick( "American dog tick", "Dermacentor variabilis ", "Rocky Mountain Spotted Fever, Tularemia", "american_dog_tick" ),
    Tick( "Brown dog tick", "Rhipicephalus sanguineus", "Rocky Mountain Spotted Fever, Q Fever", "brown_dog_tick" ),
    Tick( "Groundhog tick", "Ixodes cookei", "Powassan Encephalitis", "groundhog_tick"),
    Tick( "Western Blacklegged tick", "Ixodes pacificus", "Borreliosis (a relapsing fever), Ehrlichiosis, Anaplasmosis", "west_blackleg_tick" ),
    Tick( "Pacific Coast tick", "Dermacentor occidentalis", "Rocky Mountain Spotted Fever, Colorado Tick Fever, Tularemia, Q Fever", " " ),
    Tick( "Lone Star tick", "Amblyomma americanum", "Southern Tick Rash Illness, Heartland Virus, Tularemia, Ehrlichiosis, Q Fever", "lone_star_tick" ),
    Tick( "Rocky Mountain Wood tick", " ", "Rocky Mountain Spotted Fever, Colorado Tick Fever, Tularemia, Q Fever", "rocky_mtn_wood_tick" ),
    Tick( "Cayenne tick", " ", "Rocky Mountain Spotted Fever", "cayenne_tick" ),
    Tick( "Ixodes Ticks (multiple species)", "Ixodes xxxxxx", "Lyme Disease, Babesiosis, Powassan Encephalitis, Anaplasmosis", "ixodes_ticks" ),
    Tick( "African tick", " ", "Tick-borne Relapsing Fever", "african_tick" ),
    Tick( "Soft ticks", "Ornithodoros", "Tick-borne Relapsing Fever", "soft_ticks" )
  ];

class Disease {
  String disName;
  String disCasesPerYear;
  String disURL;
  Disease( this.disName, this.disCasesPerYear, this.disURL );
}

List<Disease> diseasesList = [
    Disease( "Lyme Disease", "34945", "https://www.cdc.gov/niosh/topics/tick-borne/default.html" ),
    Disease( "Anaplasmosis", "5655", "https://www.health.state.mn.us/diseases/anaplasmosis/basics.html" ),
    Disease( "Rocky Mountain Spotted Fever", "5207", "https://www.cdc.gov/rmsf/stats/index.html" ),
    Disease( "Babesiosis", "2420", "https://www.cdc.gov/parasites/babesiosis/index.html" ),
    Disease( "Ehrlichiosis", "2093", "https://www.cdc.gov/ehrlichiosis/symptoms/index.html" ),
    Disease( "Tularemia", "274", "https://www.mayoclinic.org/diseases-conditions/tularemia/symptoms-causes/syc-20378635" ),
    Disease( "Q Fever", "179", "https://www.cdc.gov/qfever/index.html, https://www.mayoclinic.org/diseases-conditions/q-fever/symptoms-causes/syc-20352995"),
    Disease( "Powassan Encephalitis", "43", "https://www.cdc.gov/powassan/index.html" ),
    Disease( "Tick-borne Relapsing Fever", "23", "https://doh.wa.gov/you-and-your-family/illness-and-disease-z/tick-borne-relapsing-fever" ),
    Disease( "Colorado Tick Fever", "6", "https://www.cdc.gov/coloradotickfever/index.html" ),
    Disease( "Southern Tick Rash Illness", "Not Reported", "https://www.floridahealth.gov/diseases-and-conditions/southern-tick-rash-illness/index.html")
  ];

// ------------- End of data_file.dart ---------------
