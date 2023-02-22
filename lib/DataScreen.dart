import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/ModelClass.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool star = true;
  List numb = [];
  @override
  Widget build(BuildContext context) {
    MC data = ModalRoute.of(context)!.settings.arguments as MC;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            actions: [
              InkWell(onTap: (){Navigator.pushNamed(context, 'Edit',arguments: data);},child: Icon(Icons.edit_outlined)),
              SizedBox(width: 21,),
              GestureDetector(onTap:(){setState(() {star = !star;});},child: Icon(star == true ? Icons.star_border:Icons.star)),
              SizedBox(width: 6,),
              PopupMenuButton(itemBuilder: (context){
                return [
                  PopupMenuItem(child: Text("Share"),onTap: (){
                    Share.share("Name : ${data.fn} ${data.ln}\nNumber : ${data.pn}");
                  },),
                  PopupMenuItem(child: Text("Delete"),onTap: (){setState(() {
                  });},),
                  PopupMenuItem(child: Text("Help & feedback")),
                  PopupMenuItem(child: Text("Setting")),
                ];
              }),
              SizedBox(width: 5,),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 150,top: 60),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: Text("${data.fn![0]}",style: TextStyle(fontSize: 60,color: Colors.white),),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 92, top: 215),
                child: Text(
                  "${data.fn} ${data.ln}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 263),
                child: Divider(thickness: 1.5,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 55,top: 290),
                child: Column(
                  children: [
                    InkWell(onTap: () async { await FlutterPhoneDirectCaller.callNumber("${data.pn}"); },child: Icon(Icons.call_outlined,color: Colors.red,)),
                    SizedBox(height: 9,),
                    InkWell(onTap: ()async { await FlutterPhoneDirectCaller.callNumber("${data.pn}"); },child: Text("Call",style: TextStyle(fontSize: 15,color: Colors.red),))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 180,top: 291),
                child: Column(
                  children: [
                    InkWell(onTap: () async { await launch('sms://${data.pn}'); },child: Icon(Icons.message_outlined,color: Colors.blue.shade400,)),
                    SizedBox(height: 9,),
                    InkWell(onTap: () async { await launch('sms://${data.pn}'); },child: Text("Text",style: TextStyle(fontSize: 15,color: Colors.blue.shade400),))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 300,top: 287),
                child: Column(
                  children: [
                    Icon(Icons.videocam_outlined,color: Colors.black,),
                    SizedBox(height: 9,),
                    Text("Video",style: TextStyle(fontSize: 15,color: Colors.black),)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 350),
                child: Divider(thickness: 1.5,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 21,right: 21,top: 385),
                child: Container(
                  height: 160,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15,top: 16),
                        child: Text(
                          "Contact info",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 17,top: 62),
                        child: InkWell(onTap: () async { await FlutterPhoneDirectCaller.callNumber("${data.pn}"); },child: Icon(Icons.call_outlined,color: Colors.red,size: 27,)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 60,top: 60),
                        child: Text(
                          "${data.pn}\nMobile",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 250,top: 62),
                        child: Icon(Icons.videocam_outlined,color: Colors.black,size: 27,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 300,top: 62),
                        child: InkWell(onTap: () async { await launchUrl(Uri.parse('sms://${data.pn}')); },child: Icon(Icons.message_outlined,color: Colors.blue.shade400,size: 25,)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18,top: 115),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: ()async{
                                  var wn = "+91 ${data.pn}";
                                  var whatsapp_url_android = "whatsapp://send?phone="+wn+"&text=";
                                  var whatsapp_url_ios = "https://wb.me/${data.pn}?text=${Uri.parse("")}";
                                  if(Platform.isIOS)
                                    {
                                      // Only IOS
                                      await launchUrl(Uri.parse(whatsapp_url_ios));
                                    }
                                  else
                                    {
                                      //Only Android,Web
                                      await launchUrl(Uri.parse(whatsapp_url_android));
                                    }
                                },
                                child: Image.asset("assets/image/whatsapp_icon.png",color: Colors.green,),
                            ),
                            SizedBox(width: 12,),
                            Text(
                              "Message +91${data.pn}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        )
    );
  }
}
