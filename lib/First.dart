import 'package:flutter/material.dart';
import 'package:project/DataScreen.dart';
import 'package:project/EditScreen.dart';
import 'package:project/HomeScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int place=1;
  List screen = [
    DataScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: screen[place],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: place,
            onTap: (index){
              setState(() {
                place=index;
              });
            },
            fixedColor: Colors.red,

            items: [
              BottomNavigationBarItem(
                  backgroundColor: Colors.blue,
                  icon: Icon(place==0?Icons.star:Icons.star_border,),
                  label: "Favourites"
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.red,
                icon: Icon(place==1?Icons.watch_later:Icons.watch_later_outlined,),
                label: "Recent",
              ),
              BottomNavigationBarItem(
                  backgroundColor: Colors.yellowAccent,
                  icon: Icon(place==2?Icons.people_alt:Icons.people_alt_outlined,),
                  label: "Contacts"
              ),
            ],),
        )
    );
  }
}
