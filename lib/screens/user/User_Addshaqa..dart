import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'UserHome.dart';
class UserAddshaqa extends StatefulWidget {
  const UserAddshaqa({super.key});

  @override
  State<UserAddshaqa> createState() => _UserAddshaqaState();
}

class _UserAddshaqaState extends State<UserAddshaqa> {
  var shaqaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple[400],
          ),
          body: Container(child: Column(children: [

            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 30),
              child: Text("ادخل محتوي الشكوي",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
            ),
            Container(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                maxLines: 3,
                controller: shaqaController,
                decoration: InputDecoration(
                    hintText: "الشكوي",
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
                  var shaqa = shaqaController.text.trim();



                  if (shaqa.isEmpty


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
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    desc: 'لقد تم ارسال شكوتك بنجاح انتظر الرد',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return UserHome();
                      })
                      );
                    },
                  )..show();







                  DatabaseReference userRef = FirebaseDatabase
                      .instance
                      .reference()
                      .child('shaqa');

                  String? uid = FirebaseAuth.instance.currentUser?.uid;
                  int dt =
                      DateTime.now().millisecondsSinceEpoch;
                  String? id = userRef.push().key;

                  await userRef.child(id!).set({

                    "shaqa":shaqa,
                    "id":id,

                    'uid':uid,
                    'dt': dt,


                  })


                      ;




                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Text("  ارسال الشكوي",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return UserHome();
                })
                );
              },child: Text("اضغط هنا للعوده",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold)),),
            )
          ],),),
        ) );
  }
}
