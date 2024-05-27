import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/shaqa_model.dart';

import '../user/UserHome.dart';
import 'admin _addanswer.dart';
class AdminShaqa extends StatefulWidget {

  const AdminShaqa({super.key, });

  @override
  State<AdminShaqa> createState() => _AdminShaqaState();
}

class _AdminShaqaState extends State<AdminShaqa> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Shaqa> shaqaList = [];

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchshaqa();
  }

  @override
  void fetchshaqa() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("shaqa");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Shaqa p = Shaqa.fromJson(event.snapshot.value);
      shaqaList.add(p);
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
            title: Text("الشكاوي"),
            titleTextStyle: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
            ),
          ),
          body:
             ListView.builder(


                scrollDirection: Axis.vertical,
                itemCount: shaqaList.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){

                    },
                    child: Card(



                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
side: BorderSide()
                      ),
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child:
                              Text(" الشكوي : ${shaqaList[index].shaqa.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: MaterialButton(
                              color: Colors.orange[500],
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return
                                      Adminanswer(shaqa:"${shaqaList[index].shaqa.toString()}" ,);
                                }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 70),
                                child: Text("  الرد",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AdminShaqa()));
                              FirebaseDatabase.instance
                                  .reference()
                                  .child("shaqa")
                                  .child('${shaqaList[index].id}')
                                  .remove();
                            },
                            child: Icon(Icons.delete,
                                color: Colors.orangeAccent),
                          ),
                          Container(height: 10,)

                        ],
                      ),),
                  );
                }),
          ),
        ) ;
  }
}
