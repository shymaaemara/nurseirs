import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nurseries/auth/logo.dart';
import 'package:nurseries/models/hosbitaildetailes_model.dart';
import 'package:nurseries/models/hospitail_model.dart';
import 'package:nurseries/screens/user/User%20Booking.dart';
import 'package:nurseries/screens/user/User_Addshaqa..dart';
import 'package:nurseries/screens/user/User_Hospitaildetailes.dart';
import 'package:nurseries/screens/user/user_answers.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  var addressController = TextEditingController();

  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Hospitail> hospitailList = [];

  List<String> keyslist = [];

  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchhospitail();
  }

  @override
  void fetchhospitail() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hospitails");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Hospitail p = Hospitail.fromJson(event.snapshot.value);
      hospitailList.add(p);
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
  appBar: AppBar(
    backgroundColor: Colors.deepPurple,
    title: Text("الصفحه الرئيسيه لولي الامر"),
    titleTextStyle: TextStyle(
      color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
    ),
  ),
  drawer: Drawer(
    child: Column(children: [

      Container(
        height: 200,
        width: 300,
        color: Colors.purple[400],
        child: Column(
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              
              radius: 50,
              backgroundImage: AssetImage("images/miminko-610x311.png",),
            ),
            SizedBox(height: 20,),
            Text("منطقه ولي الامر",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
          ],

        ),

      ),
      ListTile(
        title: Text("الرئيسيه"),leading: Icon(Icons.home),
      ),
      InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return UserAddshaqa();
          })
          );
        },
        child: ListTile(
          title: Text("ارسال شكوي"),leading: Icon(Icons.send_to_mobile),
        ),
      ),
      InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return UserBookings();
          })
          );
        },
        child: ListTile(
          title: Text("حجوزاتك"),leading: Icon(Icons.send_to_mobile),
        ),
      ),
      InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Useranswer();
          }));
        },
        child: ListTile(
          title: Text("الردود علي الشكوي"),leading: Icon(Icons.send_to_mobile),
        ),
      ),
      InkWell(
        onTap: (){
          FirebaseAuth.instance
              .signOut();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return logo();
          }));
        },
        child: ListTile(
          title: Text("خروج"),leading: Icon(Icons.exit_to_app),
        ),
      )
    ],),
  ),
  body: Container(

      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Container(
            height: 300,
            child:CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16/9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                "images/pregnancy-and-a-pandemic-12-640x426.jpg",
                "images/miminko-610x311.png",

                "images/1_USA-Utah-Payson-Nurse-listening-to-heartbeat-of-newborn-in-incubator.jpg"
                // Add more image URLs as needed
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),

          ),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: TextFormField(
              onTap: (){
                showSearch(context: context, delegate: Customsearch(list:hospitailList ));
              },

              controller: addressController,
              decoration: InputDecoration(

                  label: Text("ابحث بالعنوان"),
                  hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purpleAccent)
                  )
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("قائمه المستشفيات",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black) ,),
          ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                      itemCount: hospitailList.length,
                      itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return UserHospitaildetailes (namehospitail: "${ hospitailList[index].namehospitail.toString()}",id: '${ hospitailList[index].id.toString()}');
                        }));
                      },
                      child: Card(
                   key: ValueKey( hospitailList[index]),
                        color: Colors.deepPurple,
                        elevation: 10,

                        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.orange.shade300,
                            width: 10
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                          Text("${ hospitailList[index].namehospitail.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white) ,),
                          Text("${ hospitailList[index].address.toString()}",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white)),
                                              ],),
                        ),),
                    );
                  }),
                )
        ],),
      ),
    ),
  ),
);
  }
}


class Customsearch extends SearchDelegate {
  List list;

  Customsearch({required this.list});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = "";
      }, icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filterhospitailList = query.isEmpty ? list :


    list.where((element) =>
    element.address.contains(query) ).toList();


    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: filterhospitailList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (
                      context) {
                    return UserHospitaildetailes(
                        namehospitail: "${ filterhospitailList[index]
                            .namehospitail.toString()}",

                        id: '${ filterhospitailList[index].id.toString()}');
                  }));
                },
                child: Card(
                  key: ValueKey(filterhospitailList[index]),
                  color: Colors.deepPurple,
                  elevation: 10,

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: Colors.orange.shade300,
                          width: 10
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(
                        "${ filterhospitailList[index].namehospitail.toString()}",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),),
                      Text("${ filterhospitailList[index].address.toString()}",
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white)),
                    ],),
                  ),),
              );
            }),
      );
  }

}