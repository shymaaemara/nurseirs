import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:nurseries/auth/logo.dart';
import 'package:nurseries/auth/userlogin.dart';

import '../screens/user/UserHome.dart';
class Sighup extends StatefulWidget {
  const Sighup({super.key});

  @override
  State<Sighup> createState() => _SighupState();
}

class _SighupState extends State<Sighup> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(
         body: Container(child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Column(children: [
             Container(height: 100,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("ادخل بيانات انشاء حساب",style:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30),
               child: TextFormField(
                 controller: emailController,
                 decoration: InputDecoration(
                     hintText: "البريد الالكتروني",
                     hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                     border: OutlineInputBorder()
                 ),
               ),
             ),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30),
               child: TextFormField(
                 controller: nameController,
                 decoration: InputDecoration(
                     hintText: "الاسم",
                     hintStyle:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                     border: OutlineInputBorder()
                 ),),
             ),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30),
               child: TextFormField(
                 controller: addressController,
                 decoration: InputDecoration(
                     hintText: "العنوان",
                     hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                     border: OutlineInputBorder()
                 ),
               ),
             ),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30),
               child: TextFormField(
                 controller: phoneNumberController,
                 decoration: InputDecoration(
                     hintText: "الهاتف",
                     hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                     border: OutlineInputBorder()
                 ),
               ),
             ),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30),
               child: TextFormField(
                 controller: passwordController,
                 decoration: InputDecoration(
                     hintText: "كلمه المرور",
                     hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                     border: OutlineInputBorder()
                 ),
               ),
             ),
             SizedBox(height: 20,),

             MaterialButton(
               color: Colors.orange[700],
               onPressed: () async {
                 var name = nameController.text.trim();
                 var phoneNumber =
                 phoneNumberController.text.trim();
                 var email = emailController.text.trim();
                 var password = passwordController.text.trim();
                 var address = addressController.text.trim();

                 if (name.isEmpty ||
                     email.isEmpty ||
                     password.isEmpty ||
                     phoneNumber.isEmpty ||
                     address.isEmpty) {
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

                 if (password.length < 6) {
                   // show error toast
                   MotionToast(
                       primaryColor: Colors.blue,
                       width: 300,
                       height: 50,
                       position: MotionToastPosition.center,
                       description: Text(
                           "Weak Password, at least 6 characters are required"))
                       .show(context);

                   return;
                 }

                 AwesomeDialog(
                   context: context,
                   dialogType: DialogType.success,
                   animType: AnimType.rightSlide,

                   desc: 'لقد تم انشاء الحساب بنجاح ',
                   btnCancelOnPress: () {},
                   btnOkOnPress: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                       return Userlogin();
                     }));
                   },
                 )..show();

                 try {
                   FirebaseAuth auth = FirebaseAuth.instance;

                   UserCredential userCredential =
                       await auth.createUserWithEmailAndPassword(
                     email: email,
                     password: password,
                   );
                   User? user = userCredential.user;

                   if (userCredential.user != null) {
                     DatabaseReference userRef = FirebaseDatabase
                         .instance
                         .reference()
                         .child('users');

                     String uid = userCredential.user!.uid;
                     int dt =
                         DateTime.now().millisecondsSinceEpoch;

                     await userRef.child(uid).set({
                       'name': name,
                       'email': email,
                       'password': password,
                       'uid': uid,
                       'dt': dt,
                       'address': address,
                       'phoneNumber': phoneNumber,
                     });










                   } else {
                     MotionToast(
                         primaryColor: Colors.blue,
                         width: 300,
                         height: 50,
                         position:
                         MotionToastPosition.center,
                         description: Text("failed"))
                         .show(context);
                   }

                 } on FirebaseAuthException catch (e) {

                   if (e.code == 'email-already-in-use') {
                     MotionToast(
                         primaryColor: Colors.blue,
                         width: 300,
                         height: 50,
                         position:
                         MotionToastPosition.center,
                         description:
                         Text("email is already exist"))
                         .show(context);
                   } else if (e.code == 'weak-password') {
                     MotionToast(
                         primaryColor: Colors.blue,
                         width: 300,
                         height: 50,
                         position:
                         MotionToastPosition.center,
                         description:
                         Text("password is weak"))
                         .show(context);
                   }
                 } catch (e) {

                   MotionToast(
                       primaryColor: Colors.blue,
                       width: 300,
                       height: 50,
                       position: MotionToastPosition.center,
                       description:
                       Text("something went wrong"))
                       .show(context);
                 }
               },
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 70),
                 child: Text("   سجل حساب",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: InkWell(onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context){
                   return logo();
                 }));
               },child: Text("اضغط هنا العوده",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold)),),
             )
           ],),
         ),),
        ));
  }
}
