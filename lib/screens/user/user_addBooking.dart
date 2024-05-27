import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:nurseries/screens/Showdiailog.dart';
import 'package:nurseries/screens/user/UserHome.dart';
class UserBooking extends StatefulWidget {
  final String namehospitail ,price,des,id ;

  final  number;
  const UserBooking({super.key, required this.namehospitail, required this.number, required this.price, required this.des, required this.id});

  @override
  State<UserBooking> createState() => _UserBookingState();
}

class _UserBookingState extends State<UserBooking> {
  var histairyController = TextEditingController();
  var ageController = TextEditingController();
  var extraController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var count=1;
  @override
  Widget build(BuildContext context) {
    return
      Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple[400],
          ),
          body: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ادخل بيانات حجز الحضانه",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.black),),
                ),
                Container(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    controller: histairyController,
                    decoration: InputDecoration(
                        hintText: "تاريخ الحجز",
                        hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                        hintText: "عمر الطفل",
                        hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "اسم ولي الامي ",
                        hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        hintText: "تليفون",
                        hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: TextFormField(
                    maxLines: 3,
                    controller: extraController,
                    decoration: InputDecoration(
                        hintText: "ملحوظات اضافيه",
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
                      var histairy = histairyController.text.trim();
                      var age =
                      ageController.text.trim();
                      var extra= extraController.text.trim();
                      var name= nameController.text.trim();
                      var phone= phoneController.text.trim();


                      if (histairy.isEmpty ||
                          age.isEmpty ||
                          extra.isEmpty||
                          name.isEmpty||
                          phone.isEmpty
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
                          .child('Booking');

                      String? uid = FirebaseAuth.instance.currentUser?.uid;
                      int dt =
                          DateTime.now().millisecondsSinceEpoch;
                      String? id = userRef.push().key;

                      await userRef.child(id!).set({
                        "namehospitail":widget.namehospitail,
                        "name":name,
                        "phone":phone,
                        'histairy': histairy,
                        "id":id,
                        'age': age,
                        'extra': extra,
                        'uid':uid,
                        'dt': dt,


                      });
                      DatabaseReference userRef3 = FirebaseDatabase
                          .instance
                          .reference()
                          .child('Bookings');

                      await userRef3.child( uid! ).child(id!).set({
                        "namehospitail":widget.namehospitail,
                        "name":name,
                        "phone":phone,
                        'histairy': histairy,
                        "id":id,
                        'age': age,
                        'extra': extra,
                        'uid':uid,
                        'dt': dt,


                      });





                      DatabaseReference userRef2 = FirebaseDatabase
                          .instance
                          .reference()
                          .child('hospitaildetailes');


                      int number = int.parse(widget.number);
                              number=number-count;

                      await userRef2.child(widget.namehospitail).child(widget.id).update({
                        "namehospitail":widget.namehospitail,
                        'number': number,
                        "id":id,
                       'price': widget.price,
                        'des': widget.des,
                        'uid':uid,
                        'dt': dt,


                      });

                      showDialog(
                          context: context,
                          builder:
                              (context) =>
                              AlertDialog(
                                title: Text(
                                    'ادفع الأن'),
                                content:
                                Container(
                                  height: 100,
                                  child: Text(
                                      'اختر طريقة الدفع'),
                                ),
                                actions: [
                                  ElevatedButton
                                      .icon(
                                    icon: const Icon(
                                        Icons
                                            .credit_card,
                                        size:
                                        18),
                                    label: Text(
                                        'بطاقة الأئتمان'),
                                    onPressed:
                                        () {
                                      showDialog(
                                        context:
                                        context,
                                        builder:
                                            (BuildContext
                                        context) {
                                          return AlertDialog(
                                            title:
                                            Text("Notice"),
                                            content:
                                            SizedBox(
                                              height: 65,
                                              child: TextField(
                                                decoration: InputDecoration(

                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Color(0xfff8a55f), width: 2.0),
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  hintText: 'ادخل رقم الفيزا',
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                style: TextButton.styleFrom(

                                                ),
                                                child: Text("دفع"),
                                                onPressed: () {
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserHome()));


                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  ElevatedButton
                                      .icon(
                                    icon: const Icon(
                                        Icons
                                            .credit_card,
                                        size:
                                        18),
                                    label: Text(
                                        'كاش'),
                                    onPressed:
                                        () {
                                      showDialog(
                                        context:
                                        context,
                                        builder:
                                            (BuildContext
                                        context) {
                                          return AlertDialog(
                                            title:
                                            Text("Notice"),
                                            content:
                                            Text("تم الحجز وسيتم الدفع كاش فى المركز"),
                                            actions: [
                                              TextButton(
                                                style: TextButton.styleFrom(

                                                ),
                                                child: Text("Ok"),
                                                onPressed: () {
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserHome()));


                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ));             },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Text("  ارسال طلب الحجز",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
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
              ],),
            ),
          ),
        )  );
  }

  }


