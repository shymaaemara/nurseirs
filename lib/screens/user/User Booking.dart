import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/Booking_model.dart';
import 'package:nurseries/models/Bookings_model.dart';
import 'package:nurseries/screens/user/UserHome.dart';
import 'package:nurseries/screens/user/user_addBooking.dart';

import '../../models/users_model.dart';
import '../admin/Adddetailes.dart';
class UserBookings extends StatefulWidget {

  const UserBookings({super.key});

  @override
  State<UserBookings> createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Bookings> bookingList = [];


  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBooking();

  }
String uid=FirebaseAuth.instance.currentUser!.uid;
  @override
  void fetchBooking() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("Bookings").child(uid);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Bookings p = Bookings.fromJson(event.snapshot.value);
      bookingList.add(p);
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
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
        ),
        body:




        Container(
          child:  ListView.builder(


              scrollDirection: Axis.vertical,
              itemCount: bookingList.length,
              itemBuilder: (context,index){
                return bookingList[index].uid.toString()==FirebaseAuth.instance.currentUser!.uid
                    ?

                InkWell(
                  onTap: (){

                  },
                  child: Card(


                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(20),

                        side: BorderSide(

                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(" اسم المستشفي:    ${bookingList[index].namehospitail.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black) ,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(" اسم ولي الامر:    ${bookingList[index].name.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black) ,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(" التلفون:   ${bookingList[index].phone.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black) ,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("  تاريخ الحجز:   ${bookingList[index].histairy.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black) ,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(" عمر الطفل:   ${bookingList[index].age.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("  وصف الحضانه     ${bookingList[index].extra.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                        ),


                        InkWell(
                          onTap: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserBookings()));
                            FirebaseDatabase.instance
                                .reference()
                                .child("Bookings").child(uid)
                                .child('${bookingList[index].id}')
                                .remove();
                          },
                          child:Text("الغاء الحجز",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
                        )


                      ],),
                    ),),
                ):   null     ;
              }),
        ),
      )  );
  }
}
