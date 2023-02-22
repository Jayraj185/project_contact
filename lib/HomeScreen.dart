import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:project/DataScreen.dart';
import 'package:project/EditScreen.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'ModelClass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List name = [
    "Jayraj",
    "Sumit",
    "Dharmik",
    "Raj",
    "Pratik",
    "Bhavin",
    "Smit",
    "Prajay",
    "Ronak",
    "Tushar",
    "Parth",
  ];
  List surname = [
    "Kalsariya",
    "Gohil",
    "Bhaliya",
    "Ghetiya",
    "Bhatti",
    "Ambaliya",
    "Sarkheliya",
    "Bokha",
    "Kanani",
    "Radadiya",
    "Kathariya",
  ];
  List number = [
    "9104497779",
    "7096536027",
    "9099769877",
    "9574984084",
    "8460849834",
    "7383569403",
    "6352280084",
    "6315794649",
    "9313076796",
    "7984511007",
    "7201061197",
  ];
  TextEditingController txtFN = TextEditingController();
  TextEditingController txtLN = TextEditingController();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtName = TextEditingController();
  String FN = "";
  String LN = "";
  String PN = "";
  String uc="";
  String uppar="";
  var valid = GlobalKey<FormState>();
  int unumber=0;
  double le=240;
  String unum="";
  dynamic text;
  int place=1;
  List numlist = [];
  int j=1;
  int len=0;
  List UserNumber = [];
  String query="";
  List  nn = ["Jay","Raj"];
  static const String Key1 = "Name";
  static const String Key2 = "Surname";
  static const String Key3 = "Number";
  @override
  void initState() {
    super.initState();
    getValue();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
          key: valid,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Contacts",
              ),
              centerTitle: true,
              backgroundColor: Colors.red,
              actions: [
                InkWell(
                    onTap: (){
                      showSearch(
                        context: context, delegate: Delegate(),
                      );
                    },
                    child: Icon(Icons.search,color: Colors.white,size: 25,)
                ),
                PopupMenuButton(itemBuilder: (context){
                  return [
                    PopupMenuItem(child: Row(
                      children: [
                        InkWell(onTap: (){add();},child: Icon(Icons.add,color: Colors.black,size: 30,)),
                        SizedBox(width: 6,),
                        InkWell(onTap: (){add();},child: Text("New Number")),
                      ],
                    )),
                    // PopupMenuItem(child: InkWell(
                    //   onTap: (){
                    //     // showSearch(
                    //     //     context: context,
                    //     //     delegate: Delegate(),
                    //     // );showSearch(
                    //     //     context: context,
                    //     //     delegate: Delegate(),
                    //     // );
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.search,color: Colors.black,size: 30,),
                    //       SizedBox(width: 6,),
                    //       Text("Search Number")
                    //     ],
                    //   ),
                    // )),
                  ];
                },),
              ],
            ),
              body: Stack(
                children: [
                  ListView.builder(itemBuilder: (context,i){
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(onPressed: ((context) async {
                            await FlutterPhoneDirectCaller.callNumber("${number[i]}");
                          }),flex: 1,icon: Icons.call,label: "Call",backgroundColor: Colors.green,)
                        ],
                      ),
                      child: FocusedMenuHolder(
                        onPressed: (){},
                        menuItems: [
                          FocusedMenuItem(title: Text("${number[i]}"),onPressed: (){}),
                          FocusedMenuItem(title: Text("Share"),trailingIcon: Icon(Icons.share_outlined), onPressed: (){
                            Share.share("Name : ${name[i]} ${surname[i]}\nNumber : ${number[i]}");
                          }),
                          FocusedMenuItem(title: Text("Copy To Clipboard"),trailingIcon: Icon(Icons.copy_outlined), onPressed: () async {
                            Clipboard.setData(ClipboardData(text: number[i]));
                          }),
                          FocusedMenuItem(title: Text("Edit Number"),trailingIcon: Icon(Icons.edit_outlined), onPressed: (){
                            MC m1 = MC(fn: name[i],ln: surname[i],pn: number[i]);
                            Navigator.pushNamed(context, 'Edit',arguments: m1);
                          }),
                          FocusedMenuItem(title: Text("Delete"),trailingIcon: Icon(Icons.delete_outline), onPressed: (){
                            // var pref1 = await SharedPreferences.getInstance();
                            // pref1.remove(Key1!);
                            // var pref2 = await SharedPreferences.getInstance();
                            // pref2.remove(Key2!);
                            // var pref3 = await SharedPreferences.getInstance();
                            // pref3.remove(Key3!);
                            setState(() {
                              number.removeAt(i);
                              name.removeAt(i);
                              surname.removeAt(i);
                              print("$number\n$name\n$surname");
                            });
                          }),
                        ],
                        child: ExpansionTile(
                          title: Text("${name[i]} ${surname[i]}"),
                          subtitle: Text("${number[i]}"),
                          leading: InkWell(
                            onTap: (){
                              // uc=name[i][0];
                              // uppar.toUpperCase();
                              MC m1 = MC(fn: name[i],ln: surname[i],pn: number[i]);
                              Navigator.pushNamed(context, 'Data',arguments: m1,);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              alignment: Alignment.center,
                              child: Text("${name[i][0]}",style: TextStyle(fontSize: 30,color: Colors.white),),
                            ),
                          ),
                          trailing: InkWell(onTap: () async {
                            //Indirect Call
                            //await launch("tel://${number[i]}");
                            //direct Call
                            await FlutterPhoneDirectCaller.callNumber("${number[i]}");
                          },child: Icon(Icons.call_outlined)),
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 30,top: 15,bottom: 15),
                                  child: Column(
                                    children: [
                                      Icon(Icons.videocam_outlined,color: Colors.black,),
                                      SizedBox(height: 9,),
                                      Text("Video Call",style: TextStyle(fontSize: 15,color: Colors.black),)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 75,top: 15,bottom: 15),
                                  child: Column(
                                    children: [
                                      InkWell(onTap: () async { await launchUrl(Uri.parse('sms://${number[i]}')); },child: Icon(Icons.message_outlined,color: Colors.blue.shade400,)),
                                      SizedBox(height: 9,),
                                      InkWell(onTap: () async { await launchUrl(Uri.parse('sms://${number[i]}')); },child: Text("Message",style: TextStyle(fontSize: 15,color: Colors.blue.shade400),))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 75,top: 15,bottom: 15,),
                                  child: Column(
                                    children: [
                                      Icon(Icons.history,color: Colors.black45,),
                                      SizedBox(height: 9,),
                                      Text("History",style: TextStyle(fontSize: 15,color: Colors.black45),)
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },itemCount: name.length,),
                  // Padding(
                  //   padding: const EdgeInsets.all(15),
                  //   child: TextField(
                  //     controller: txtName,
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(21),
                  //         borderSide: BorderSide(color: Colors.red),
                  //       ),
                  //       labelText: "Name"
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(150),
                  //   child: ElevatedButton(onPressed: () async {
                  //     var pref = await SharedPreferences.getInstance();
                  //     pref.setString(Key1, txtName.text.toString());
                  //   }, child: Text("Save")),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 100,left: 30),
                  //   child: Text(
                  //     "Name  : $nn",
                  //     style: TextStyle(
                  //       fontSize: 21,
                  //       color: Colors.red
                  //     ),
                  //   ),
                  // ),
                  Align(alignment: Alignment.bottomRight,child: Padding(
                    padding: const EdgeInsets.only(bottom: 15,right: 21),
                    child: FloatingActionButton(onPressed: (){
                      setState(() {
                        showModalBottomSheet(context: context, builder: ((builder) => OpenDialPad()),);
                      });
                    },child: Icon(Icons.dialpad),backgroundColor: Colors.red),
                  )),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 315),
                  //   child: TextFormField(
                  //     controller: txtFN,
                  //     keyboardType: TextInputType.name,
                  //     textInputAction: TextInputAction.next,
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.all(15),
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.red,),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.red,),
                  //       ),
                  //       labelText: "First Name",
                  //       labelStyle: TextStyle(color: Colors.red),
                  //     ),
                  //     validator: (value){
                  //       if(value!.isEmpty)
                  //       {
                  //         return "Please Enter Your First Name";
                  //       }
                  //       else
                  //       {
                  //         return null;
                  //       }
                  //     },
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 390),
                  //   child: TextFormField(
                  //     controller: txtLN,
                  //     keyboardType: TextInputType.name,
                  //     textInputAction: TextInputAction.next,
                  //     decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.all(15),
                  //         border: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.red,),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.red,),
                  //         ),
                  //         labelText: "Last Name",
                  //         labelStyle: TextStyle(color: Colors.red)
                  //     ),
                  //     validator: (value){
                  //       if(value!.isEmpty)
                  //       {
                  //         return "Please Enter Your Last Name";
                  //       }
                  //       else
                  //       {
                  //         return null;
                  //       }
                  //     },
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 460,),
                  //   child: TextFormField(
                  //     controller: txtNumber,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.all(15),
                  //         border: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.red,),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.red,),
                  //         ),
                  //         labelText: "Mobile Number",
                  //         labelStyle: TextStyle(color: Colors.red)
                  //     ),
                  //     validator: (value){
                  //       if(value!.isEmpty)
                  //       {
                  //         return "Please Enter Your Mobile Number";
                  //       }
                  //       else if(value.length != 10)
                  //         {
                  //           return "Please Enter Your Valid Mobile Number";
                  //         }
                  //       else
                  //       {
                  //         return null;
                  //       }
                  //     },
                  //
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 550,left: 100,right: 100),
                  //   child: ElevatedButton(onPressed: (){
                  //     FN = txtFN.text;
                  //     LN = txtLN.text;
                  //     PN = txtNumber.text;
                  //     if (valid.currentState!.validate()) {
                  //       setState(() {
                  //         name.add(FN);
                  //         surname.add(LN);
                  //       });
                  //       print("$name\n$surname");
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfull "),),);
                  //     }
                  //     else
                  //     {
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill All Deatail"),),);
                  //     }
                  //
                  //   }, child: Row(
                  //     children: [
                  //       SizedBox(width: 40,),
                  //       Icon(Icons.save_alt),
                  //       SizedBox(width: 21,),
                  //       Text("Save",style: TextStyle(color: Colors.white,fontSize: 15),)
                  //     ],
                  //   ),style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),),
                  // )
                ],
              ),
          ),
        ),

    );

  }

  MaterialStateProperty<Color> getColor(Color color,Color colorPressed)
  {
    final getColors = (Set<MaterialState> states)
    {
      if(states.contains(MaterialState.pressed))
        {
          return colorPressed;
        }
      else
        {
          return color;
        }
    };
    return MaterialStateProperty.resolveWith(getColors);
  }
  void add()
  {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 300,
          width: 350,
          color: Colors.white,
          child: Column(
            children: [
              TextFormField(
                controller: txtFN,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red,),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red,),
                  ),
                  labelText: "First Name",
                  labelStyle: TextStyle(color: Colors.red),
                ),
                validator: (value){
                  if(value!.isEmpty && value.length != 10
                  )
                  {
                    return "Please Enter Your First Name";
                  }
                  else
                  {
                    return null;
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: TextFormField(
                  controller: txtLN,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,),
                      ),
                      labelText: "Last Name",
                      labelStyle: TextStyle(color: Colors.red)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 21,),
                child: TextFormField(
                  controller: txtNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,),
                      ),
                      labelText: "Mobile Number",
                      labelStyle: TextStyle(color: Colors.red)
                  ),
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return "Please Enter Your Mobile Number";
                    }
                    else if(value.length != 10)
                      {
                        return "Please Enter Your Valid Mobile Number";
                      }
                    else
                    {
                      return null;
                    }
                  },

                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 21),
                child: ElevatedButton(onPressed: () async {
                  FN = txtFN.text;
                  LN = txtLN.text;
                  PN = txtNumber.text;
                  if (valid.currentState!.validate()) {
                    var pref1 = await SharedPreferences.getInstance();
                    pref1.setString(Key1, FN.toString());
                    var pref2 = await SharedPreferences.getInstance();
                    pref2.setString(Key2, LN.toString());
                    var pref3 = await SharedPreferences.getInstance();
                    pref3.setString(Key3, PN.toString());
                    // setState((){
                    //   name.add(FN);
                    //   surname.add(LN);
                    //   number.add(PN);
                    // });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Contact Number Add Recently"),),);
                    txtFN.clear();
                    txtLN.clear();
                    txtNumber.clear();
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill All Deatail"),),);
                  }

                }, child: Row(
                  children: [
                    SizedBox(width: 70,),
                    Icon(Icons.save_alt),
                    SizedBox(width: 21,),
                    Text("Save",style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],
                ),style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),),
              )
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextField(
              //     controller: txtName,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(21),
              //           borderSide: BorderSide(color: Colors.red),
              //         ),
              //         labelText: "Name"
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(50),
              //   child: ElevatedButton(onPressed: () async {
              //     var pref = await SharedPreferences.getInstance();
              //     pref.setString(Key, txtName.text.toString());
              //     initState();
              //   }, child: Text("Save")),
              // ),
            ],
          ),
        ),
      );
    }
    );
  }
  Widget OpenDialPad()
  {
      return Container(
        height: 440,
        color: Colors.green[50],
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: UserNumber.map((e) => Text(
                  "$e",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 33,
                      overflow: TextOverflow.ellipsis
                  ),
                ),).toList(),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10),
                  //   child: unumber==0?Text(""):InkWell(onTap: (){},child: PopupMenuButton(itemBuilder: (context){
                  //     return [
                  //       PopupMenuItem(child: Text("Add 2-sec pause"),onTap: (){setState(() {
                  //         unum = unum + ",";
                  //       });},),
                  //       PopupMenuItem(child: Text("Add wait"),onTap: (){setState(() {
                  //         unum = unum + ";";
                  //       });},),
                  //     ];
                  //   },)),
                  // ),

                  // Padding(
                  //   padding: unum==""?EdgeInsets.only(left: 290,top: 10):EdgeInsets.only(left: le,top: 10),
                  //   child: InkWell(
                  //     onTap: (){
                  //       setState(() {
                  //         unumber = 1;
                  //         print("$unumber\n$unum");
                  //       });
                  //     },
                  //     child: Container(
                  //         height: 45,
                  //         width: 45,
                  //         decoration: BoxDecoration(
                  //           color: Colors.green[50],
                  //           shape: BoxShape.circle
                  //         ),
                  //         alignment: Alignment.center,
                  //         child: Icon(Icons.backspace_outlined,color: unumber==0 ? Colors.black26:Colors.black,size: 21,)
                  //     ),
                  //   ),
                  // ),
              ),
              // child: Padding(
              //   padding: EdgeInsets.only(bottom: 18,left: 21),
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: TextField(
              //       controller: nom,
              //       keyboardType: TextInputType.none,
              //       cursorColor: Colors.black12,
              //       cursorHeight: 40,
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0,),
              child: Divider(thickness: 0.8,),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12,),
              child: Row(
                children: [
                  button("1"),
                  button("2"),
                  button("3"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  button("4"),
                  button("5"),
                  button("6"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  button("7"),
                  button("8"),
                  button("9"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12,),
              child: Row(
                children: [
                  button("*"),
                  button("0"),
                  button("#"),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 145,top: 10),
                  child: SizedBox(
                    height: 57,
                    width: 103,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        //overlayColor: getColor(Colors.red,Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.green.shade700
                          )
                      ),
                      onPressed: () async {
                        for(int i=0; i<UserNumber.length; i++)
                          {
                            unum=unum+UserNumber[i];
                          }
                        await FlutterPhoneDirectCaller.callNumber("${unum}");
                        UserNumber.clear();
                        unum="";
                      },
                      child : Row(
                        children: [
                          Icon(Icons.call_outlined),
                          SizedBox(width: 12,),
                          Text("Call",style: TextStyle(color: Colors.white,fontSize: 15,),),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 21,top: 5),
                  child: SizedBox(
                    height: 57,
                    width: 103,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: getColor(Colors.red,Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white
                          )
                      ),
                      onPressed: (){
                        if(UserNumber.length!=0)
                          {
                            UserNumber.removeLast();
                          }
                      },
                      onLongPress: (){
                        UserNumber.clear();
                        unum="";
                      },
                      child : Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Icon(Icons.backspace_outlined,color: Colors.black,size: 30,),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
  }
  Widget button(String no)
  {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 64,
        width: 115,
        child: ElevatedButton(
          style: ButtonStyle(
              overlayColor: getColor(Colors.red,Colors.green.shade200),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                  Colors.white
              )
          ),

          onPressed: (){
            setState(() {
              UserNumber.add(no);
            });
          },
          child : Text("$no",style: TextStyle(color: Colors.black,fontSize: 40,),),
        ),
      ),
    );
  }
  void result(String click)
  {
    if(click=="AC")
      {
        return null;
      }
    else
      {
        text = int.parse(unum + click).toString();
      }
    setState(() {
      unum = text;
      //print("Result===>> $unum\nResult===>> $text");
    });
  }

  void getValue() async {
    var prefs1 = await SharedPreferences.getInstance();
    var getName1 = prefs1.getString(Key1);
    var prefs2 = await SharedPreferences.getInstance();
    var getName2 = prefs2.getString(Key2);
    var prefs3 = await SharedPreferences.getInstance();
    var getName3 = prefs3.getString(Key3);
    setState(() {
      name.add(getName1);
      surname.add(getName2);
      number.add(getName3);
    });
  }


}
class Delegate extends SearchDelegate {
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: (){
          if(query.isEmpty)
          {
            close(context, null);
          }
          else
          {
            query = '';
          }
        },
        icon: Icon(Icons.clear)
    ),
  ];
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      close(context, null);
    },
  );
  Widget buildSuggestions(BuildContext context)
  {
    List match = [];
    for(var item in _HomeScreenState.name){
      if(item.toLowerCase().contains(query.toLowerCase()))
      {
        match.add(item);
      }
    }
    return ListView.builder(
      itemCount: match.length,
      itemBuilder: (context, index) {
        var result = match[index];
        return ListTile(
          title: Text("$result"),
          onTap: (){
            query = result;
            print("$result\n$query");
            showResults(context);
          },
        );
      },);
  }
  Widget buildResults(BuildContext context) => Center(
    child: Text(
      query,
      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),
    ),
  );
}


