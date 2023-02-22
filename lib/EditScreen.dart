import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/ModelClass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String lable = "Mobile";
  String? path;
  Widget bottomsheet() {
    return Container(
      height: 136,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Choose Profile Photo",
              style: TextStyle(fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF555259)),
            ),
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              SizedBox(width: 12,),
              Padding(
                padding: EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker pick = ImagePicker();
                        XFile? img = await pick.pickImage(
                            source: ImageSource.camera);
                        setState(() {
                          path = img!.path;
                        });
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black12, width: 2)
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.camera_alt, color: Colors.red,),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 12,),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 55),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker pick2 = ImagePicker();
                        XFile? img2 = await pick2.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          path = img2!.path;
                        });
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black12, width: 2)
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.image, color: Colors.red,),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 8,),
              Padding(
                padding: EdgeInsets.only(top: 115),
                child: Column(
                  children: [
                    Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45
                        )
                    )
                  ],
                ),
              ),
              SizedBox(width: 38,),
              Padding(
                padding: EdgeInsets.only(top: 115),
                child: Column(
                  children: [
                    Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    MC data = ModalRoute.of(context)!.settings.arguments as MC;
    TextEditingController txtFN = TextEditingController(text: "${data.fn}");
    TextEditingController txtLN = TextEditingController(text: "${data.ln}");
    TextEditingController txtPN = TextEditingController(text: "${data.pn}");
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Edit Contacts"),
            backgroundColor: Colors.red,
            leading: InkWell(
              onTap: (){Navigator.pop(context,'Data');},
              child: Icon(Icons.close),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 15,right: 50),
                child: InkWell(onTap: (){Navigator.pop(context,'Data');},child: Text("Save",style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold),)),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomsheet()),
                      );
                    },
                    child: (path==null)?Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.add_photo_alternate_outlined,size: 60,color: Colors.black,),
                    )
                    : CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(File("$path")),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    "Add Photo",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 21
                    ),
                  )
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 72,left: 15),
                      child: Icon(Icons.person_outline,size: 30,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60,top: 60,right: 30),
                      child: TextFormField(
                        controller: txtFN,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)
                          ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)
                            ),
                          labelText: "First Name",
                          labelStyle: TextStyle(color: Colors.red)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60,top: 140,right: 30),
                      child: TextFormField(
                        controller: txtLN,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red)
                          ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)
                            ),
                          labelText: "Last Name",
                          labelStyle: TextStyle(color: Colors.red)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 232,left: 15),
                      child: Icon(Icons.call_outlined,size: 27,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60,top: 221,right: 30),
                      child: TextFormField(
                        controller: txtPN,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)
                            ),
                            labelText: "Phone",
                            labelStyle: TextStyle(color: Colors.red)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60,top: 300,right: 30),
                      child: OutlinedButton(onPressed: (){},
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(items: [
                          DropdownMenuItem(child: Text("No Lable"),value: "No Lable",),
                          DropdownMenuItem(child: Text("Mobile"),value: "Mobile",),
                          DropdownMenuItem(child: Text("Work"),value: "Work",),
                          DropdownMenuItem(child: Text("Home"),value: "Home",),
                          DropdownMenuItem(child: Text("Main"),value: "Main",),
                          DropdownMenuItem(child: Text("Work fax"),value: "Work fax",),
                          DropdownMenuItem(child: Text("Home fax"),value: "Home fax",),
                          DropdownMenuItem(child: Text("Pager"),value: "Pager",),
                          DropdownMenuItem(child: Text("Other"),value: "Other",),
                          DropdownMenuItem(child: Text("Custom"),value: "Custom",),
                      ], onChanged: (value){
                          setState(() {
                            lable = value as String;
                          });
                      },value: lable,),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}
