import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/hosbitaildetailes_model.dart';
import 'package:nurseries/screens/admin/AddHospitail.dart';
import 'package:nurseries/screens/admin/Adddetailes.dart';

import 'Adminhome.dart';
class Admindetailes extends StatefulWidget {
  final String namehospitail;
  const Admindetailes({super.key, required this.namehospitail});

  @override
  State<Admindetailes> createState() => _AdmindetailesState();
}

class _AdmindetailesState extends State<Admindetailes> {


  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Hospitaildetailes> hospitailList = [];

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchhospitail();
  }

  @override
  void fetchhospitail() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hospitaildetailes").child("${widget.namehospitail}");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Hospitaildetailes p = Hospitaildetailes.fromJson(event.snapshot.value);
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
            backgroundColor: Colors.deepPurple,
            title: Text(" اضافه "),
            titleTextStyle: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
            ),
            actions: [
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return Adddetailes(namehospitail: "${widget.namehospitail}");
                }));
              }, icon: Icon(Icons.add,color: Colors.white,))
            ],
          ),
          body: Container(
           child:  ListView.builder(
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               scrollDirection: Axis.vertical,
               itemCount: hospitailList.length,
               itemBuilder: (context,index){
                 return InkWell(
                   onTap: (){

                   },
                   child: Card(


                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20),

                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("       مستشفي  ${widget.namehospitail}",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("       عدد الحضانات   ${hospitailList[index].number.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black) ,),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("          سعر الحضانه  ${hospitailList[index].price.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("     وصف الحضانه   ${hospitailList[index].des.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                         ),

                         InkWell(
                           onTap: () async {
                             Navigator.pushReplacement(
                                 context,
                                 MaterialPageRoute(
                                     builder: (BuildContext context) =>
                                         Adminhome()));
                             FirebaseDatabase.instance
                                 .reference()
                                 .child("hospitaildetailes").child("${widget.namehospitail}")
                                 .child('${hospitailList[index].id}')
                                 .remove();
                           },
                           child: Icon(Icons.delete,
                               color: Colors.deepPurple),
                         )


                       ],),
                     ),),
                 );
               }),
          ),
    )  );
  }
}
