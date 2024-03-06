import 'dart:convert';
import 'dart:developer';

import 'package:barcodescan/Accueil.dart';
import 'package:barcodescan/models/employerResult.dart';
import 'package:barcodescan/models/employre.dart';
import 'package:barcodescan/models/getOut.dart';
import 'package:barcodescan/models/myresult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import 'models/getIn.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isOpen = false;
  bool inProgress = false;
  String resultat = "";
  DateTime theDate = DateTime.now();
  GetIn? getIn = null;
  GetOut? getOut = null;
  List<EmployerR> listEmp = <EmployerR>[];
  String baseUrl = "nafasn.nafaemployee.sn";
  var client = http.Client();
  MyResult? mr = null;
  _getEmps() async {
    int dd = theDate.day;
    int mm = theDate.month;
    String ddS = "";
    String mmS = "";
    if (dd < 10)
      ddS = '0' + dd.toString();
    else
      ddS = dd.toString();
    if (mm < 10)
      mmS = '0' + mm.toString();
    else
      mmS = mm.toString();
    String year = theDate.year.toString();
    String today = year + "-" + mmS + "-" + ddS;

    final queryParameters = {
      'theDate': today,
      'HierOrMissing': 'Hier',
    };
    log("eeeeeeeee");
    var url = Uri.http(baseUrl, '/hierDate', queryParameters);
    print(url);
    await client.get(url).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          inProgress = true;
        });
        MyResult m = MyResult.fromJson(jsonDecode(response.body));
        print(response);
        setState(() {
          listEmp = m.listEmpR;
          //emps = list.map((model) => Employer.fromJson(model)).toList();
        });

        print(isOpen);
        print(listEmp.length);
      } else {
        print("error error");
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  _getEmpsMissOrHier() async {
    int dd = theDate.day;
    int mm = theDate.month;
    String ddS = "";
    String mmS = "";
    if (dd < 10)
      ddS = '0' + dd.toString();
    else
      ddS = dd.toString();
    if (mm < 10)
      mmS = '0' + mm.toString();
    else
      mmS = mm.toString();
    String year = theDate.year.toString();
    String today = year + "-" + mmS + "-" + ddS;

    final queryParameters = {
      'theDate': today,
    };
    log("inOpenday");
    var url = Uri.http(baseUrl, '/inOpenday', queryParameters);
    print(url);
    await client.get(url).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          inProgress = true;
        });
        MyResult m = MyResult.fromJson(jsonDecode(response.body));
        print(response);
        if (m.listEmpR != null) {
          if (m.listEmpR.length > 0) {
            print("------------------------yes--------");
            setState(() {
              isOpen = true;
            });
            _getEmps();
          }
        }

        print(listEmp.length);
      } else {
        print("error error");
      }
    }).catchError((onError) {
      print(onError);
      _getEmpsMissOrHier();
    });
  }

  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
    _getEmpsMissOrHier();

    //http://localhost:5172/missingOrHierDate?theDate=2023-09-29&HierOrMissing=Hier
    //print(today);
  }

  Future<void> getBarcode() async {
    //http://localhost:5172/missingOrHierDate?theDate=2023-09-29&HierOrMissing=Hier
    final queryParameters = {
      'numQr': resultat,
    };
    log("eeeeeeeee");
    var url = Uri.http(baseUrl, '/PutGetInQrCode', queryParameters);
    print(url);
    final response = await client.put(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    }).then((response) {
      print(response.body);
      log("222222");
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        GetIn g = GetIn.fromJson(jsonDecode(response.body));
        print(g);
        setState(() {
          getIn = g;
        });
        _getEmps();
        setState(() {
          getOut = null;
        });
        setState(() {
          resultat = "";
        });
      } else {
        setState(() {
          resultat = "";
        });
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }).catchError((onError) {
      print(onError);
      log("11111");
    });

    log("ttttt");
    print(response);
  }

  Future<void> getBarcode2() async {
    final queryParameters = {
      'numQr': resultat,
    };
    log("eeeeeeeee");
    var url = Uri.http(baseUrl, '/PostGetOutQrCode', queryParameters);
    print(url);
    final response = await client.post(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    }).then((response) {
      print(response.body);
      log("222222");
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        GetOut g = GetOut.fromJson(jsonDecode(response.body));
        print(g);
        setState(() {
          getOut = g;
        });
        setState(() {
          getIn = null;
        });
        setState(() {
          resultat = "";
        });
      } else {
        setState(() {
          resultat = "";
        });
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }).catchError((onError) {
      print(onError);
      log("11111");
    });

    log("ttttt");
    print(response);
  }

  Future<void> scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", 'CANCEL', true, ScanMode.QR)
        .then((value) async {
      setState(() => resultat = value);
      print("ici icic ici");
      await getBarcode();
    });
  }

  Future<void> scan2() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", 'CANCEL', true, ScanMode.QR)
        .then((value) async {
      setState(() => resultat = value);
      print("ici icic ici");
      await getBarcode2();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: inProgress
          ? isOpen
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Shadow offset
                          ),
                        ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(

                              constraints: BoxConstraints.expand(height: 80.0,width: 100.0),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Image.asset(
                                'assets/images/nafa.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.5,
                            //   child: Center(
                            //       child: Text(
                            //     "NAFA",
                            //     style: TextStyle(
                            //         fontSize: 40, color: Colors.blueAccent),
                            //   )),
                            // ),
                            Container(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    child: Text("Marquer venu"),
                                    onPressed: () => scan(),
                                  ),
                                  // SizedBox(height: 30,),
                                  ElevatedButton(
                                    child: Text("Marquer rentré"),
                                    onPressed: () => scan2(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(resultat),
                      (getIn != null)
                          ? Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.offline_pin,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                  Text("Pésence de"),
                                  Text(
                                    getIn?.employer.nameEmp ?? '',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text("Enrégistré à"),
                                  Text(getIn?.hour ?? getIn?.dateIn ?? ''),
                                  ElevatedButton(
                                      child: Text("Retour"),
                                      onPressed: () => setState(() {
                                            getIn = null;
                                          })),
                                ],
                              ),
                            )
                          : Container(),
                      (getOut != null)
                          ? Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.offline_pin,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                  Text("Rentré de"),
                                  Text(getOut?.employer.nameEmp ?? '',
                                      style: TextStyle(fontSize: 20)),
                                  Text("Enrégistré à"),
                                  Text(getOut?.hour ?? getIn?.dateIn ?? ''),
                                  ElevatedButton(
                                      child: Text("Retour"),
                                      onPressed: () => setState(() {
                                            getOut = null;
                                          })),
                                ],
                              ),
                            )
                          : Container(),
                      (listEmp.length < 1)
                          ? Container(
                              child: Center(
                                  child: Text("Pas de présence enregistrée")))
                          : Container(),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                            itemCount: listEmp.length,
                            itemBuilder: (context, index) {
                              //log(listEmp[index].nameEmp);
                              return Container(
                                margin: EdgeInsets.only(
                                    top: 8.0, left: 4.0, right: 4.0),
                                padding: EdgeInsets.all(
                                    5.0), // Adjust padding as needed
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust border radius as needed
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 1.0, // Border width
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // Shadow offset
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                      listEmp[index].employer.nameEmp ?? ''),
                                  subtitle: Text(listEmp[index].hourGetIn),

                                  leading: Icon(Icons.person),
                                  trailing: Text(listEmp[index].hourGetOut),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                )
              : Accueil()
          : Center(child: CircularProgressIndicator()),
    );
  }
}
