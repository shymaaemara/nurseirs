import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
class Adddetailes extends StatefulWidget {
  final  String namehospitail;
  const Adddetailes({super.key, required this.namehospitail});

  @override
  State<Adddetailes> createState() => _AdddetailesState();
}

class _AdddetailesState extends State<Adddetailes> {
  var numberController = TextEditingController();
  var priceController = TextEditingController();
  var desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,

          ),
          body: Container(child: Column(children: [

            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 50),
              child: TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                    hintText: "عدد الحضانات ",
                    hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                    border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                    hintText: "السعر",
                    hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                    border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextFormField(
                controller: desController,
                decoration: InputDecoration(
                    hintText: "الوصف",
                    hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                    border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 20,),
            MaterialButton(
              color: Colors.orange[700],
              onPressed: () async {
                int number =int.parse(numberController.text);


                var price =
                priceController.text.trim();
                var des= desController.text.trim();


                if (number==0 ||
                    price.isEmpty ||
                    des.isEmpty

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




                DatabaseReference userRef = FirebaseDatabase
                    .instance
                    .reference()
                    .child('hospitaildetailes');

                String? uid = FirebaseAuth.instance.currentUser?.uid;
                int dt =
                    DateTime.now().millisecondsSinceEpoch;
                String? id = userRef.push().key;

                await userRef.child(widget.namehospitail).child(id!).set({
                  "namehospitail":widget.namehospitail,
                  'number': number,
                  "id":id,
                  'price': price,
                  'des': des,
                  'uid':uid,
                  'dt': dt,


                });

                Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : null;




              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Text("   اضافه",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),
          ],),),
        ));
  }
}
