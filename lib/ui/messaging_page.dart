import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(
        height: 30.0,
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: _buildTextField(context),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () => {},
            child: Text(
              'Send',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ]),
      ),
      ListTile(
        subtitle: Text("2021.04.06"),
        title: Text(
            """‼️‼️Nyerj 1 kg.  "CAPARAO" BRAZIL  KÁVÉT A CASINO MOCCA-TÓL‼️‼️
            👍👍👍👍👍Like & Share👍👍👍👍👍
            GUTENBERG COFFEE  2️⃣0️⃣2️⃣1️⃣-ben is kedveskedik Facebook látogatói számára👌
            Nincs más dolgod mint kedvelni a 
            Gutenberg coffe - Hivatalos Facebook oldalát
            és megosztani a fotót!!  
            Sorsolás: 2021.04.10.""",
            style: TextStyle(
              fontSize: 12,
            )),
      ),
      ListTile(
        subtitle: Text("2021.04.19"),
        title: Text("""‼️‼️GYERTEK KÓSTÓLJÁTOK MEG‼️‼️
          ❗PÉNTEKEN EGÉSZ NAP!!!  50% OFF❗
          ❗"CASINO MOCCA BRAZIL CAPARAO"❗
            ‼️☕👌‼️☕ 2021.04.23.‼️☕👌‼️""",
            style: TextStyle(
              fontSize: 12,
            )),
      ),
      ListTile(
        subtitle: Text("2021.04.01"),
        title: Text(
            """Eljött a várva-várt pillanat, ma végre megnyitottuk Nektek a teraszunkat!!🥳🥳🥳
          Várunk Titeket sok szeretettel, hogy ott folytassuk, ahol abbahagytuk... 😉😎☕🥐🥯☕
          ...és ne feledjétek, vigyázzatok magatokra és egymásra is! ✌️🤜🤛""",
            style: TextStyle(
              fontSize: 12,
            )),
      ),
      ListTile(
        subtitle: Text("2021.03.26"),
        title: Text("""Ugandai kávékülönlegesség csütörtöktől a Gutin!""",
            style: TextStyle(
              fontSize: 12,
            )),
      ),
      ListTile(
        subtitle: Text("2021.03.19"),
        title: Text("""Ugandai kávékülönlegesség csütörtöktől a Gutin!""",
            style: TextStyle(
              fontSize: 12,
            )),
      ),
      ListTile(
        subtitle: Text("2021.03.12"),
        title: Text("""Ugandai kávékülönlegesség csütörtöktől a Gutin!""",
            style: TextStyle(
              fontSize: 12,
            )),
      ),
      ListTile(
        subtitle: Text("2021.03.05"),
        title: Text("""Ugandai kávékülönlegesség csütörtöktől a Gutin!""",
            style: TextStyle(
              fontSize: 12,
            )),
      ),
    ]);
  }

  Widget _buildTextField(BuildContext context) => TextField(
        controller: controller,
        maxLength: 280,
        maxLines: 11,
        minLines: 1,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        decoration: InputDecoration(
          hintText: 'Enter the message',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      );
}
