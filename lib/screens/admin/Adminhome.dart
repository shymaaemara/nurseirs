import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nurseries/auth/logo.dart';
import 'package:nurseries/screens/admin/AddHospitail.dart';
import 'package:nurseries/screens/admin/Adddetailes.dart';
import 'package:nurseries/screens/admin/Admindetailes.dart';
import 'package:nurseries/screens/admin/admin_Booking.dart';
import 'package:nurseries/screens/admin/admin_hospitail.dart';
import 'package:nurseries/screens/admin/admin_shaqa.dart';
import 'package:nurseries/screens/admin/adminusers.dart';

import '../../models/hospitail_model.dart';
class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Hospitail> hospitailList = [];

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchhospitail();
  }

  @override
  void fetchhospitail() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hospitails");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Hospitail p = Hospitail.fromJson(event.snapshot.value);
      hospitailList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }








  @override
  Widget build(BuildContext context) {
    return
      Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.purpleAccent,
            title: Text("الصفحه الرئيسيه لمدير النظام"),
            titleTextStyle: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
            ),
          ),
          body:  SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [


Container(child: Image.asset("images/administration-word-cloud-security-concept-56936992.jpg"),),


               Container(height: 100,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return AddHospitail();
                    }));
                  },
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.purpleAccent
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 10),
                      child: Text("اضافه مستشفيات",style:  TextStyle(
                        color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                                        ),),
                    ),),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return AdminBooking(hospitai: "");
                    }));
                  },
                  child: Container(

                    decoration: BoxDecoration(
                        color: Colors.orange[100]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 10),
                      child: Text("حجوزات الحضانه",style:  TextStyle(
                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
                                        )),
                    ),),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Adminusers();
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange[50]
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 10),
                      child: Text("تقاير المستخدمين",style:  TextStyle(
                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
                                        )),
                    ),),
                ),
                InkWell(
                  onTap: (){
                    FirebaseAuth.instance
                        .signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return logo();
                    }));
                  },
                  child: Container(

                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50
                    ),


                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 115,vertical: 10),
                      child: Text("خروج",style:  TextStyle(
                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
                                        )),
                    ),),
                )

                ]
            ),
          ),
          drawer: Drawer(
            child: Column(children: [

              Container(
                height: 200,
                width: 300,
                color: Colors.purple[400],
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    CircleAvatar(

                      radius: 50,
                      backgroundImage: AssetImage("images/miminko-610x311.png",),
                    ),
                    SizedBox(height: 20,),
                    Text("منطقه مدير النظام",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],

                ),

              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Adminhome();
                  }));
                },
                child: ListTile(
                  title: Text("الرئيسيه"),leading: Icon(Icons.home),

                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return AddHospitail();
                  }));
                },
                child: ListTile(
                  title: Text(" اضافه مستشفي "),leading: Icon(Icons.send_to_mobile),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Adminhospitail();
                  }));
                },
                child: ListTile(
                  title: Text(" المستشفيات "),leading: Icon(Icons.send_to_mobile),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return AdminShaqa();
                  }));
                },
                child: ListTile(
                  title: Text("الشكاوي"),leading: Icon(Icons.send_to_mobile),
                ),
              ),

              InkWell(
                onTap: (){
                  FirebaseAuth.instance
                      .signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                    return logo();
                  }));
                },
                child: ListTile(
                  title: Text("خروج"),leading: Icon(Icons.exit_to_app),
                ),
              )
            ],),
          ),

       ) );
  }
}
