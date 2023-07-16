import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MaterialApp(
      title: "Simple Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Robota',
      ),
      home: homepage(),
    ));

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String equation = " ";
  String result = " ";
  String expression = " ";
  double equationFontSize = 36;
  double resultFontSize = 48;
  Color equationColor = Colors.black;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = " ";
        result = " ";
        equationFontSize = 36;
        resultFontSize = 48;
      } else if (buttonText == "DEL") {
        equationFontSize = 36;
        resultFontSize = 48;
        equation = equation.substring(0, equation.length - 1);
        if (equation == " ") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 26;
        resultFontSize = 48;
        equationColor = Colors.grey;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          // result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          double evalResult = exp.evaluate(EvaluationType.REAL, cm);
          //check if the result has any decimal value
          if (evalResult % 1 == 0) {
            result = evalResult.toInt().toString();
          } else {
            result = evalResult.toStringAsFixed(2);
          }
        } catch (e) {
          result = "error";
        }
      } else {
        equationFontSize = 36;
        resultFontSize = 48;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildbutton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: Color.fromARGB(179, 226, 224, 224),
                width: 3,
                style: BorderStyle.solid)),
        padding: EdgeInsets.all(0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: buttonText == '=' ? 35 : 27,
              fontWeight: FontWeight.normal,
              color: buttonText == '='
                  ? Colors.white
                  : Color.fromARGB(255, 18, 18, 18)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey, size: 28),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print('History');
              },
              icon: Icon(
                Icons.history,
                color: Colors.grey,
                size: 30,
              ))
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 14,
            ),
            ListTile(
              leading: Icon(
                Icons.menu,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Calculator',
                style: TextStyle(fontSize: 26, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.calculate,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Standard',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.science,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Scientific',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.bar_chart_sharp,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Graphing',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.code_outlined,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Programmer',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Date caculation',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Converter',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.currency_exchange,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Currency',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.area_chart_outlined,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Volume',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.scale_sharp,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Length',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.line_weight,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Weight and mass',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.device_thermostat,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Temperature',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.air,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Energy',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.area_chart,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Area',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.run_circle,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Speed',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.watch_rounded,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Time',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.data_array_rounded,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Data',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.medical_information,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Pressure',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.rotate_90_degrees_ccw,
                          size: 22,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Angle',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              onTap: () {
                print('Setting');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              equation,
              style: TextStyle(
                  //fontSize: equationFontSize,
                  fontSize: equation == expression ? 26 : equationFontSize,
                  color: equation == expression ? equationColor : Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildbutton("%", 1, Colors.white),
                        buildbutton("÷", 1, Colors.white),
                        buildbutton("DEL", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("7", 1, Colors.white),
                        buildbutton("8", 1, Colors.white),
                        buildbutton("9", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("4", 1, Colors.white),
                        buildbutton("5", 1, Colors.white),
                        buildbutton("6", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("1", 1, Colors.white),
                        buildbutton("2", 1, Colors.white),
                        buildbutton("3", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("0", 1, Colors.white),
                        buildbutton(".", 1, Colors.white),
                        buildbutton("00", 1, Colors.white),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildbutton("AC", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("×", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("-", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("+", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildbutton("=", 1, Colors.lightBlue),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
