//import 'package:cloud_firestore/cloud_firestore.dart';

class Stamp {
  final DateTime date;
  final int count;
  //final DocumentReference? reference;

  Stamp(this.date, this.count);
  //Stamp(this.date, this.count, {this.reference});

  Stamp.fromMap(Map<String, dynamic> map)
      //Stamp.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['date'] != null),
        assert(map['count'] != null),
        date = map['date'],
        count = map['count'];

  //Stamp.fromSnapshot(DocumentSnapshot snapshot): this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Stamp<$date:$count>";
}
