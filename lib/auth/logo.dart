import 'package:flutter/material.dart';
import 'package:nurseries/auth/sighup.dart';
import 'package:nurseries/auth/userlogin.dart';
import 'package:nurseries/screens/admin/AdminLogin.dart';
class logo extends StatefulWidget {
  const logo({super.key});

  @override
  State<logo> createState() => _logoState();
}

class _logoState extends State<logo> {
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(

          body: Container(child:
             Column(


              children: [


                Image.asset("images/pregnancy-and-a-pandemic-12-640x426.jpg")
           , Container(height: 50,)
             , Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("تطبيق لعرض وحجز حضانات الاطفال ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
             ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.black,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Userlogin();
                    }));
                  },child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Text("سجل دخول كولي امر",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellow)),
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Sighup();
                  }));
                },child: Text("اذا كان لديك حساب انشئ حساب ",style: TextStyle(fontSize: 20,color: Colors.grey)),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return AdminLogin();
                  }));
                },child: Text("منطقه مدير النظام",style: TextStyle(fontSize: 20,color: Colors.grey))),
              ),
            ],),
          ),
        );
  }
}
