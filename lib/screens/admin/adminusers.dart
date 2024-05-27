import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/models/users_model.dart';



class Adminusers extends StatefulWidget {
  const Adminusers({super.key});

  @override
  State<Adminusers> createState() => _AdminusersState();
}

class _AdminusersState extends State<Adminusers> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Users> userList = [];
  late Users currentUser;

  List<String> keyslist = [];


  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchusers() ;
  }
  void fetchusers() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("users");
    final snapshot = await base.get();
    base.onChildAdded.listen((event) {

      Users user = Users.fromSnapshot(event.snapshot);
      userList.add(user);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }
  @override

  @override
  Widget build(BuildContext context) {

    return
      Directionality(textDirection: TextDirection.rtl, child:
        Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text("المستخدمين"),
            titleTextStyle: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
            ),
          ),
          body:  ListView.builder(


          scrollDirection: Axis.vertical,
    itemCount:  userList.length,
    itemBuilder: (context,index){
    return InkWell(
    onTap: (){

    },
    child: Card(


    elevation: 10,

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
    Text("      اسم المستخدم ${ userList[index].fullName.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





    ),
    Padding(
    padding: const EdgeInsets.all(20.0),
    child:
    Text("       تلفون  :  ${ userList[index].phoneNumber.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





    ),
    Padding(
    padding: const EdgeInsets.all(20.0),
    child:
    Text(              "           العنوان:${ userList[index].address.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black) ,),





      )])));})
        ) );
  }
}
