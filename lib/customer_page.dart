import 'package:coffee_admin/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerPageState();
}

class CustomerPageState extends State<CustomerPage> {
  final String customerId = "";

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
        stampsControl(),
        Card(
          elevation: 4,
          margin: EdgeInsets.all(20),
          child: Text(
              "Vendég: ${customer.displayName} Aktuális bélyegek: ${customer.numberOfStamps} Összes bélyeg: ${customer.sumNumberOfStamps}"),
        ),
        Card(
          child: Text("${DateFormat.yMMMM('hu').format(DateTime(2021, 1, 3))}"),
        ),
        ...customer.visits
            .map(
              (stampsPerDay) => Card(
                child: Text(
                    "${DateFormat.yMMMMd('hu').format(stampsPerDay.date)}: ${stampsPerDay.count} pecsét"),
              ),
            )
            .toList(),
      ],
    );
  }
}

class CustomerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black,
        //   width: 5,
        // ),
        // borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            image: AssetImage("assets/images/boxes.jpeg"), fit: BoxFit.fill),
      ),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      child: Row(
        children: [
          Text(
            "Peter",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color(0xff3aa173),
            ),
          ),
          Spacer(),
          //SizedBox(            width: 120,          ),
          Text(
            "3 / 13",
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

final textController = TextEditingController(text: "1");

Widget stampsControl() => Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //SizedBox(            width: 100,          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: textController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                textAlign: TextAlign.end,
                maxLines: 1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: IconButton(
              onPressed: () {
                print('Add was pressed ...');
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
              iconSize: 40,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: IconButton(
              onPressed: () {
                print('Remove was pressed ...');
              },
              icon: Icon(
                Icons.remove,
                color: Colors.black,
                size: 30,
              ),
              iconSize: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
            child: IconButton(
              onPressed: () {
                print('Commit was pressed ...');
              },
              icon: Icon(
                Icons.check_outlined,
                color: Colors.black,
                size: 30,
              ),
              iconSize: 30,
            ),
          ),
          //addButton(Icons.check),
        ],
      ),
    );

Widget addButton(IconData iconData) => ElevatedButton(
      onPressed: () {},
      child: Icon(
        iconData,
        color: Colors.white,
        size: 40,
      ),
      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
    );

Widget buttonStyle1() => ElevatedButton(
      onPressed: () {},
      child: Text('Button'),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(24),
      ),
    );

Widget buttonStyle2() => ElevatedButton(
      onPressed: () {},
      child: Text('Button'),
      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
    );
