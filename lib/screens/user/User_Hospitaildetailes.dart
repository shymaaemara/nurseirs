import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/hosbitaildetailes_model.dart';
import 'package:nurseries/screens/Fluttermap.dart';
import 'package:nurseries/screens/admin/Adminhome.dart';
import 'package:nurseries/screens/user/User%20Booking.dart';
import 'package:nurseries/screens/user/user_addBooking.dart';

import '../../models/hospitail_model.dart';
import '../../models/users_model.dart';
class UserHospitaildetailes extends StatefulWidget {
  final String namehospitail,id;

  UserHospitaildetailes({super.key, required this.namehospitail, required this.id});

  @override
  State<UserHospitaildetailes> createState() => _UserHospitaildetailesState();
}

class _UserHospitaildetailesState extends State<UserHospitaildetailes> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Hospitaildetailes> detailesList = [];
  List<Users> userList = [];
  late Users currentUser;

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchhospitaildetailes();
    fetchhospitail();

  }

  @override
  void fetchhospitaildetailes() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hospitaildetailes").child("${widget.namehospitail}");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Hospitaildetailes p = Hospitaildetailes.fromJson(event.snapshot.value);
      detailesList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }
  List<Hospitail> hospitailList = [];
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
          appBar: AppBar(
            backgroundColor: Colors.purple[400],

          ),
          body: Container(child:ListView.builder(


              scrollDirection: Axis.vertical,
              itemCount: detailesList.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){

                  },
                  child: Column(
                    children: [
                      Container(height: 100,),
                      Center(
                        child: Card(


                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Container(height: 50,),
                            Text("بيانات الحضانه",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.orange)),
                              Text("     ${widget.namehospitail}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)),
                              Container(height: 10,),
                              Text(" عدد الحضانات:   ${detailesList[index].number.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Container(height: 10,),

                              Text("    سعر الحضانه:   ${detailesList[index].price.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                              Container(height: 10,),
                              Text(" الوصف:   ${detailesList[index].des.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                              Container(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 110),
                                  child: MaterialButton(

                                    height: 60,

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)

                                    ),
                                    color:  Colors.purple[400],
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                        return UserBooking(  namehospitail: '${widget.namehospitail}', number: "${detailesList[index].number.toString()}", id: '${widget.id}', price: '${detailesList[index].price.toString()}', des: '${detailesList[index].des.toString()}',);
                                      }));
                                    },child:
                                       Row(
                                        children: [
                                          Icon(Icons.book_online,color: Colors.indigo,),
                                          SizedBox(width: 5,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 10),
                                            child: Text("حجز الحظانه ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                                          ),

                                        ],
                                      ),
                                    ),
                                ),

                            Container(height: 10,),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 110),
                               child: MaterialButton(
                                 height: 70,

                                 shape: RoundedRectangleBorder(

                                   borderRadius: BorderRadius.circular(10)
                                 ),
                                  color:  Colors.purple[400],
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){

                                      return Fluttermap(lat:   double.parse("${detailesList[index].latitude.toString()}"), log:  double.parse("${detailesList[index].logtitude.toString()}"),);

                                    }));
print("${detailesList[index].latitude.toString()}");
                                    print("${detailesList[index].logtitude.toString()}");
                                  },child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.book_online,color: Colors.indigo,),
                                        SizedBox(width: 10,),
                                        Column(
                                          children: [
                                            Text("الموقع  ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                                            Text("الجغرافي ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),),
                             )

                              ,Container(height: 30,),
                            ],),


                          ),),
                      ),
                    ],
                  ),
                );
              }), ),
          ),
        ) ;
  }
}
