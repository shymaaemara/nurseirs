import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/Booking_model.dart';
import 'package:nurseries/screens/admin/Adminhome.dart';

import '../../models/Bookings_model.dart';
class AdminBooking extends StatefulWidget {
  final String hospitai;
  const AdminBooking({super.key, required this.hospitai});

  @override
  State<AdminBooking> createState() => _AdminBookingState();
}

class _AdminBookingState extends State<AdminBooking> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Bookings> bookingList = [];

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchbooking();
  }

  @override
  void fetchbooking() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("Booking");
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
          appBar:AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text(" قائمه الحجوزات"),
            titleTextStyle: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
            ),
          ),
          body:  ListView.builder(


              scrollDirection: Axis.vertical,
              itemCount:  bookingList.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){

                  },
                  child: Card(



                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(

                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Text("اسم المستشفي      ${ bookingList[index].namehospitail.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Text("اسم ولي الامر      ${ bookingList[index].name.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Text(" تليفون ولي الامر      ${ bookingList[index].phone.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Text(" تاريخ الحجز:      ${ bookingList[index].histairy.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Text("        عمر الطفل  :  ${ bookingList[index].age.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Text(            "    ملحوظات اضافيه       ${ bookingList[index].extra.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
          Center(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: Colors.orange[500],
                onPressed: () async {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,

                    desc: '   تم قبول طلبك بنجاح      ',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Adminhome();
                      })
                      );
                    },
                  )..show();

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(" قبول ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                ),
              ),
            ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.orange[500],
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AdminBooking(hospitai: "${widget.hospitai}")));
                    FirebaseDatabase.instance
                        .reference()
                        .child("Booking").child(widget.hospitai)
                        .child('${bookingList[index].id}')
                        .remove();

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("  رفض ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                  ),
                ),
              ),


            ],),
          )
                      ],
                    ),),
                );
              }),) );
  }
}
