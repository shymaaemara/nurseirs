import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:nurseries/auth/sighup.dart';
import 'package:nurseries/screens/user/UserHome.dart';
class Userlogin extends StatefulWidget {
  const Userlogin({super.key});

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(

          body:Stack(children: [


         Padding(
           padding: const EdgeInsets.only(top: 50,bottom: 40,left: 10,right: 10),
           child: Container(
              width: double.infinity,
             height: 300,
             decoration: BoxDecoration(
                 color: Colors.indigo,
               borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30) ,bottomRight:Radius.circular(30),topLeft:Radius.circular(30) ,topRight:Radius.circular(30)   )
             ),
             child: Image.asset("images/Untitled-1-2-567x348.jpg",fit: BoxFit.fitWidth,),),
         ),
            SizedBox(height: 30,),
            Container(
             child: Center(
               child: Padding(
                 padding: const EdgeInsets.only(top: 380,left: 10,right: 10),
                 child: SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                   child: Column(children: [
                     Text(" ادخل بيانات تسجيل الدخول",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),
                     SizedBox(height: 40,),
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
                     SizedBox(height: 10,),
                     Padding(
                       padding: const EdgeInsets.only(left: 30,right: 30),
                       child: TextFormField(
                         controller: passwordController,
                         decoration: InputDecoration(
                           hintText: "كلمه المرور",
                           hintStyle:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                           border: OutlineInputBorder()
                       ),),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: MaterialButton(
                         color: Colors.orange[700],
                         onPressed: () async {
                       var email = emailController.text.trim();
                       var password = passwordController.text.trim();

                       if (email.isEmpty || password.isEmpty) {
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
                       desc: 'Please Wait.............',
                       btnCancelOnPress: () {},
                       btnOkOnPress: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                       return UserHome();
                       })
                          );
                       },
                       )..show();


                       try {
                       FirebaseAuth auth = FirebaseAuth.instance;
                       UserCredential userCredential =
                       await auth.signInWithEmailAndPassword(
                       email: email, password: password);

                       if (userCredential.user != null) {


                       }
                       } on FirebaseAuthException catch (e) {

                       if (e.code == 'user-not-found') {
                       MotionToast(
                       primaryColor: Colors.blue,
                       width: 300,
                       height: 50,
                       position: MotionToastPosition.center,
                       description: Text("user not found"))
                           .show(context);
                       return;
                       } else if (e.code == 'wrong-password') {
                       MotionToast(
                       primaryColor: Colors.blue,
                       width: 300,
                       height: 50,
                       position: MotionToastPosition.center,
                       description:
                       Text("wrong email or password"))
                           .show(context);

                       return;
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
                       print(e);


                       }
                       },
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 70),
                           child: Text("سجل دخول",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                         ),),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: InkWell(onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                       return Sighup();
                        })
                         );
                       },child: Text("اضغط هنا لانشاء حساب",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold)),),
                     )
                   ],),
                 ),
               ),
             ),
            )
          ],) ,
        )
    ) ;
  }
}
