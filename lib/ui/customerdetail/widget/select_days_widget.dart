import 'package:flutter/material.dart';

class SelectDaysWidget extends StatefulWidget {
  const SelectDaysWidget({super.key});

  @override
  State<SelectDaysWidget> createState() => _SelectDaysWidgetState();
}

class _SelectDaysWidgetState extends State<SelectDaysWidget> {
  List<String> option = ["Day", "Week", "Month"];
  String? selecteddaysOption;
  int number = 0;
  void _incrementCounter() {
    setState(() {
      number++;
    });
  }

  void _decrementCounter() {
    setState(() {
      number--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * 0.85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 2)),
          child: DropdownButton<String>(
            isExpanded: true,
            dropdownColor: Colors.white,
            hint: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text('Sélectionnez une ville',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "UberMove",
                      fontWeight: FontWeight.w800)),
            ),
            value: selecteddaysOption,
            onChanged: (String? newValue) {
              setState(() {
                selecteddaysOption = newValue!;
              });
            },
            underline: Container(),
            items: option.map<DropdownMenuItem<String>>((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    city,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "UberMove",
                        fontWeight: FontWeight.w800),
                  ),
                ),
              );
            }).toList(),
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Icon(
                Icons.arrow_outward,
                color: const Color(0xffff36a21),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (selecteddaysOption == "Day")
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  _decrementCounter();
                },
                icon: const Icon(
                  Icons.remove,
                  size: 30,
                  color: const Color(0xffff36a21),
                ),
              ),
              Text(
                "Jour: $number",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    fontFamily: "UberMove"),
              ),
              IconButton(
                  onPressed: () {
                    _incrementCounter();
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                    color: const Color(0xffff36a21),
                  )),
            ],
          )
        else if (selecteddaysOption == "Week")
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    _decrementCounter();
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 30,
                    color: const Color(0xffff36a21),
                  )),
              Text(
                "Semaine: $number",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    fontFamily: "UberMove"),
              ),
              IconButton(
                onPressed: () {
                  _incrementCounter();
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: const Color(0xffff36a21),
                ),
              ),
            ],
          )
        else if (selecteddaysOption == "Month")
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    _decrementCounter();
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 30,
                    color: const Color(0xffff36a21),
                  )),
              Text(
                "Mois: $number",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    fontFamily: "UberMove"),
              ),
              IconButton(
                onPressed: () {
                  _incrementCounter();
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Color(0xffff36a21),
                ),
              ),
            ],
          )
      ],
    );
  }
}
