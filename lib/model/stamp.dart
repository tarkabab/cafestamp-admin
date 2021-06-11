class Stamp {
  final DateTime date;
  final int count;

  Stamp(this.date, this.count);

  Stamp.fromMap(Map<String, dynamic> map)
      : assert(map['date'] != null),
        assert(map['count'] != null),
        date = map['date'],
        count = map['count'];

  @override
  String toString() => "Stamp<$date:$count>";
}
