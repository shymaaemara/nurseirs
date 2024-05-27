import 'package:flutter/material.dart';
import 'package:nurseries/screens/user/UserHome.dart';
class Showdialiog extends StatelessWidget {
  const Showdialiog({super.key});

  @override
  Widget build(BuildContext context) {
    return

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
    );
  }
}
