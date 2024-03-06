import 'dart:convert';

import 'package:barcodescan/Home.dart';
import 'package:barcodescan/models/myresult.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  String resultat="";
  DateTime theDate=DateTime.now();
  String baseUrl="nafasn.nafaemployee.sn";
  var client = http.Client();
  _openDay()async {
    int dd=theDate.day;
    int mm=theDate.month;
    String ddS="";
    String mmS="";
    if(dd<10)ddS='0'+dd.toString();
    else ddS=dd.toString();
    if(mm<10)mmS='0'+mm.toString();
    else mmS=mm.toString();
    String year=theDate.year.toString();
    String today=year+"-"+mmS+"-"+ddS;

    final queryParameters = {



    };
    var url =Uri.http(baseUrl, '/openDay');
    print(url);
    await client.get(url)
        .then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        //MyResult m=MyResult.fromJson(jsonDecode(response.body));

       print('ok----------------ok');
       Navigator.pop(context);
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));

      }

    }).catchError((onError){print(onError);});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

              constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height * 0.2),
              decoration: BoxDecoration(color: Colors.white),
              child: Image.asset(
                'assets/images/nafa.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),

            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              child: Text("Ouvrir la journée"),
              onPressed: ()=>_openDay()
            ),
          ],
        );

  }
}
