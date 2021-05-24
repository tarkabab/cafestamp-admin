import 'package:coffee_admin/customer.dart';
import 'package:coffee_admin/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerPageState();
}

class CustomerPageState extends State<CustomerPage> {
  final String customerId = "Y2ChCUGNl6LGvcT6YHs0";
  int count = 3;
  int sum = 13;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('hu', null);
  }

  @override
  Widget build(BuildContext context) {
    final customer = context.read<FirestoreService>().getCustomer(customerId);

    return ListView(
      children: [
        SizedBox(
          height: 30,
        ),
        CustomerCard(),
        Controls(),
      ],
    );
  }
}

class CustomerCard extends StatefulWidget {
  @override
  _CustomerCardState createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  @override
  Widget build(BuildContext context) {
    final customerBloc = Provider.of<CustomerBloc>(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/boxes.jpeg"), fit: BoxFit.fill),
      ),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      child: Row(
        children: [
          Text(
            "Péter",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color(0xff3aa173),
            ),
          ),
          Spacer(),
          //SizedBox(            width: 120,          ),
          Text(
            "${customerBloc.customer.numberOfStamps} / ${customerBloc.customer.sumNumberOfStamps}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xffe8c031),
            ),
          ),
        ],
      ),
    );
  }
}

class Controls extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    final customerBloc = Provider.of<CustomerBloc>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: addButton(Icons.add, () => setState(() => {_count++})),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              "$_count",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: addButton(Icons.remove, () => setState(() => {_count--})),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: addButton(
                Icons.check, () => setState(() => {customerBloc.add(_count)})),
          ),
        ],
      ),
    );
  }
}

Widget addButton(IconData iconData, void Function() onPressed) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Icon(
        iconData,
        color: Colors.white,
        size: 30,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(15),
      ),
    );

// Widget circleButton() => ElevatedButton(
//       onPressed: () {},
//       child: Text('Button'),
//       style: ElevatedButton.styleFrom(
//         shape: CircleBorder(),
//         padding: EdgeInsets.all(15),
//       ),
//     );

// Widget roundedButton() => ElevatedButton(
//       onPressed: () {},
//       child: Text('Button'),
//       style: ElevatedButton.styleFrom(shape: StadiumBorder()),
//     );

// Widget iconButton() => IconButton(
//       onPressed: () {},
//       icon: Icon(
//         Icons.check,
//         color: Colors.black,
//         size: 30,
//       ),
//       iconSize: 30,
//     );
