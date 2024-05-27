import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/Answer_model.dart';
import 'package:nurseries/screens/user/UserHome.dart';
class Useranswer extends StatefulWidget {
  const Useranswer({super.key});

  @override
  State<Useranswer> createState() => _UseranswerState();
}

class _UseranswerState extends State<Useranswer> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Answer> answerList = [];

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchshaqa();
  }

  @override
  void fetchshaqa() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("answer");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Answer p = Answer.fromJson(event.snapshot.value);
      answerList.add(p);
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
            title: Text("الردود"),
            titleTextStyle: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
            ),
          ),
          body: ListView.builder(


              scrollDirection: Axis.vertical,
              itemCount: answerList.length,
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
                          Text("    الشكوي : ${answerList[index].shaqa.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child:
                          Text("     الرد: ${answerList[index].answer.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserHome()));
                            FirebaseDatabase.instance
                                .reference()
                                .child("answer")
                                .child('${answerList[index].id}')
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
        ));
  }
}
