import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/hospitail_model.dart';
import 'package:nurseries/screens/admin/Adddetailes.dart';
import 'package:nurseries/screens/admin/Admindetailes.dart';

import 'Adminhome.dart';
class Adminhospitail extends StatefulWidget {
  const Adminhospitail({super.key});

  @override
  State<Adminhospitail> createState() => _AdminhospitailState();
}

class _AdminhospitailState extends State<Adminhospitail> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Hospitail> hospitailList = [];

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchbooking();
  }

  @override
  void fetchbooking() async {
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
              backgroundColor: Colors.deepPurple,
              title: Text(" قائمه المستشفيات"),
              titleTextStyle: TextStyle(
                  color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
              ),
            ),
            body: ListView.builder(


                scrollDirection: Axis.vertical,
                itemCount:  hospitailList.length,
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
                            padding: const EdgeInsets.all(20.0),
                            child:
                            Text("اسم المستشفي      ${ hospitailList[index].namehospitail.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child:
                            Text(" عنوان المستشفي:      ${ hospitailList[index].address.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                          ),


                          InkWell(
                            onTap: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Adminhospitail()));
                              FirebaseDatabase.instance
                                  .reference()
                                  .child("hospitails")
                                  .child('${hospitailList[index].id}')
                                  .remove();
                            },
                            child: Icon(Icons.delete,
                                color: Colors.orangeAccent),
                          ),
                          Container(height: 10,)

                              ],),
                          )


                  );
                }),
          ) );
  }
}
