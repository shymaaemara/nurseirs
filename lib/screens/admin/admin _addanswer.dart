import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:nurseries/screens/admin/Adminhome.dart';
class Adminanswer extends StatefulWidget {
  final String shaqa;
  const Adminanswer({super.key, required this.shaqa});

  @override
  State<Adminanswer> createState() => _AdminanswerState();
}

class _AdminanswerState extends State<Adminanswer> {
  var answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(
        appBar:AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(" الرد"),
    titleTextStyle: TextStyle(
    color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
    ),

        ),
    body:               Container(child: Column(children: [


    Container(height: 20,),
    Padding(
    padding: const EdgeInsets.only(left: 30,right: 30),
    child: TextFormField(
    maxLines: 3,
    controller: answerController,
    decoration: InputDecoration(
    hintText: "الرد",
    hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
    border: OutlineInputBorder()
    ),
    ),

    ),
    Padding(
    padding: const EdgeInsets.all(20.0),
    child: MaterialButton(
    color: Colors.orange[500],
    onPressed: () async {
    var answer = answerController.text.trim();



    if (answer.isEmpty


    ) {
    MotionToast(
    primaryColor: Colors.blue,
    width: 300,
    height: 50,
    position: MotionToastPosition.center,
    description:
    Text("please fill all fields"))
        .show(context);

    return;
    }

    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Logging In',
      desc: 'لقد تم ارسال الرد',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return Adminhome();
        })
        );
      },
    )..show();



    DatabaseReference userRef = FirebaseDatabase
        .instance
        .reference()
        .child('answer');

    String? uid = FirebaseAuth.instance.currentUser?.uid;
    int dt =
    DateTime.now().millisecondsSinceEpoch;
    String? id = userRef.push().key;

    await userRef.child(id!).set({
           "shaqa":widget.shaqa,
    "answer":answer,
    "id":id,

    'uid':uid,
    'dt': dt,


    });






    },
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 70),
    child: Text("  ارسال ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
    ),
    ),
    ),


    ]))));
  }
}
