import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:nurseries/screens/admin/Adminhome.dart';

import '../../auth/logo.dart';
import '../user/UserHome.dart';
class AddHospitail extends StatefulWidget {
  const AddHospitail({super.key});

  @override
  State<AddHospitail> createState() => _AddHospitailState();
}

class _AddHospitailState extends State<AddHospitail> {
  var logtitudeController = TextEditingController();
  var latitudeController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var namehospitalController = TextEditingController();
  var addressController = TextEditingController();
  var numberController = TextEditingController();
  var priceController = TextEditingController();
  var desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(

          body: Container(child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [

              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text("ادخل بيانات اضافه مستشفي",style:  TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextFormField(
                  controller: namehospitalController,
                  decoration: InputDecoration(
                      hintText: "اسم المستشفي",
                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      hintText: "  عنوان المستشفي",
                      hintStyle:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                      border: OutlineInputBorder()
                  ),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(
                      hintText: "  عدد حضانات المستشفي",
                      hintStyle:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                      border: OutlineInputBorder()
                  ),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                      hintText: "  سعر الحضانه في الليله",
                      hintStyle:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                      border: OutlineInputBorder()
                  ),),
              ),
              SizedBox(height: 20,),Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextFormField(
                  controller: desController,
                  decoration: InputDecoration(
                      hintText: "  وصف الحضانه",
                      hintStyle:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                      border: OutlineInputBorder()
                  ),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextFormField(
                  controller: latitudeController,
                  decoration: InputDecoration(
                      hintText: "خط الطول",
                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                      border: OutlineInputBorder()
                  ),
                ),
                             ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: TextFormField(
                  controller: logtitudeController,
                  decoration: InputDecoration(
                      hintText: "خط عرض",
                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 20,),

              SizedBox(height: 20,),

              MaterialButton(
                color: Colors.orange[700],
                onPressed: () async {
                  var namehospitail = namehospitalController.text.trim();
                  var phoneNumber =
                  phoneNumberController.text.trim();
                  double latitude = double.parse(latitudeController.text);
                  double logtitude = double.parse(logtitudeController.text);
                  var address = addressController.text.trim();
                  int number = int.parse(numberController.text);
                  var price = priceController.text.trim();
                  var des= desController.text.trim();
                  if (namehospitail.isEmpty ||
                      address.isEmpty ||
                      logtitude==0 ||
                      latitude==0||
                      number==0||
                      price.isEmpty||
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


                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,

                    desc: 'لقد تم اضافه المستشفي بنجاح ',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Adminhome();
                      }));
                    },
                  )..show();

                      DatabaseReference userRef = FirebaseDatabase
                          .instance
                          .reference()
                          .child('hospitails');

                      String? uid = FirebaseAuth.instance.currentUser?.uid;
                      int dt =
                          DateTime.now().millisecondsSinceEpoch;
                  String? id = userRef.push().key;

                      await userRef.child(id!).set({
                        'namehospitail': namehospitail,
                             "id":id,
                        'logtitude': logtitude,
                        'latitude': latitude,
                        'uid':uid,
                        'dt': dt,
                        'address': address,
                        'number': number,
                        'price': price,
                        'des': des,
                      });
                  DatabaseReference userRef2 = FirebaseDatabase
                      .instance
                      .reference()
                      .child('hospitaildetailes');



                  await userRef2.child(namehospitail).child(id!).set({
                    "namehospitail":namehospitail,
                    'number': number,
                    "id":id,
                    'price': price,
                    'des': des,
                    'uid':uid,
                    'dt': dt,
                    'logtitude': logtitude,
                    'latitude': latitude,

                  });











                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: Text("  ادخل بيانات المستشفى والحضانه",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(

                  onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Adminhome();
                  }));
                },child: Text("اضغط هنا العوده",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold)),),
              )
            ],),
          ),),
        ) );
  }
}
