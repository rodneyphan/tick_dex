import 'package:cloud_firestore/cloud_firestore.dart';

class FoundTick {
  int tickIndex;
  String tickType;
  GeoPoint tickLocation;
  Timestamp tickTime;

  FoundTick(this.tickIndex, this.tickType, this.tickLocation, this.tickTime);

  toJson() {
    return {
      "choice": tickType,
      "location": tickLocation,
      "tick": tickIndex,
      "time": tickTime,
    };
  }
}