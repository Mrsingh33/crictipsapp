import 'package:crickettips_app/controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bettingmodel.dart';
import 'idmodel.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/services.dart';
import 'dart:io';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {

  }
  FirebaseCrashlytics.instance.checkForUnsentReports();


  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket Tips And Predictions',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

 class MyHomePage extends StatefulWidget {
   @override
   _MyHomePageState createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
   BettingNumber bettingNumber;
   IdNumber idNumber;
   String getbetting;
   String getid;
   void initState() {
     super.initState();

     GetNumbers();


   }

   Future<void> GetNumbers() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
      getbetting = prefs.getString('betting');
      getid = prefs.getString('id');
     if(getbetting == null || getid == null || getbetting == "" || getid == "" ){
      await ControllerBetting.getBettingNumber().then((resultbetting) {
         setState(() {
           bettingNumber = resultbetting;

         });

       });
      await ControllerID.getIdNumber().then((resultId) {
         setState(() {
           idNumber = resultId;

         });

       });

       SharedPreferences prefs = await SharedPreferences.getInstance();

       prefs.setString('betting',bettingNumber.number);
       prefs.setString('id', idNumber.number);
     }
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(
           "Cricket Tips And Predictions"
         ),
       ),
       body: SingleChildScrollView(
         child: Center(
           child: Container(
             padding: EdgeInsets.all(20),
             child: Column(
               children: [

                 InkWell(
                   onTap: (){
                     _launchURL(getbetting);
                     launchWhatsApp(getbetting);

                   },
                   splashColor: Colors.grey[500],
                   child: Card(


                     color: Colors.white,
                      elevation: 10,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            "images/betting.png",
                            height: 120,
                            width: 120,
                          ),
                          Divider(

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Contact For Cricket Betting Tips ",
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),

                   ),
                 ),
                 InkWell(
                   onTap: (){
                     _launchURL(getid);
                     launchWhatsApp(getid);

                   },
                   splashColor: Colors.grey[500],
                   child: Card(
                     color: Colors.white,
                     elevation: 10,
                     child: Column(
                       children: [
                         SizedBox(
                           height: 10,
                         ),
                         Image.asset(
                           "images/betting.png",
                           height: 120,
                           width: 120,
                         ),
                         Divider(

                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text(
                           "Contact For ID ",
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                           ),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                       ],
                     ),

                   ),
                 ),
                 InkWell(
                   splashColor: Colors.grey[500],
                   onTap: (){
                     showDialog(
                       context: context,
                       child: new AlertDialog(
                         title: const Text("Coming Soon"),

                         actions: [
                           new FlatButton(
                             child: const Text("Ok"),
                             onPressed: () => Navigator.pop(context),
                           ),
                         ],
                       ),
                     );
                   },

                   child: Card(
                     color: Colors.white,
                     elevation: 10,
                     child: Column(
                       children: [
                         SizedBox(
                           height: 10,
                         ),
                         Image.asset(
                           "images/tl.png",
                           height: 120,
                           width: 120,
                         ),
                         Divider(

                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text(
                           "Join on telegram ",
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                           ),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                       ],
                     ),

                   ),
                 )
               ],
             ),
           ),
         ),
       ),
     );
   }
   _launchURL(number) async {
     print("dusravala");
     String url = 'whatsapp://send?phone=+91'+number;
     // if (await canLaunch(url)) {
     //   await launch(url);
     // } else {
     //   throw 'Could not launch $url';
     // }
     await canLaunch(url)? launch(url):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
   }

   void launchWhatsApp(number) async {
     print("+91$number");
     String url() {
       if (Platform.isIOS) {
         return "whatsapp://wa.me/+91$number/?text=Hello";
       } else {
         return "whatsapp://send?phone=+91$number&text=Hello";
       }
     }

     if (await canLaunch(url())) {
       await launch(url());
     } else {
       throw 'Could not launch ${url()}';
     }
   }

 }
