import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  File _image;
  final picker = ImagePicker();


  //Future<String> async
  @override
  Widget build(BuildContext context) {

    // the function below will pick the image from the gallery using image picker

//    Future getImage() async {
//      var image = await await picker.getImage(source: ImageSource.camera);
//
//      setState(() {
//        _image = image;
//        print('Image Path is: $_image');
//      });
//    }

    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        _image = File(pickedFile.path);
        print('Image Path is: $_image');
      });
    }

    // the function below adds the file on to the firebase storage i.e. firestore

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      setState(() {
        print("Profile Picture Uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
      });
    }


    return MaterialApp(
      home: Scaffold(

        body: Builder(
          builder: (context)=> Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xff476cfb),
                        child: ClipOval(
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: (_image!=null)?Image.file(_image, fit: BoxFit.fill)
                            :Image.network("https://static.independent.co.uk/s3fs-public/thumbnails/image/2020/06/18/10/avatar.jpg", fit: BoxFit.fill),
                          ),
                        ),
                      ),

                ),

                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera,
                          size: 30,
                        ),

                        onPressed: () {

                          getImage();

                        },
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text('Username',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                      ),
                    ),


                    Align(
                      alignment: Alignment.center,
                      child: Text('Aakash Baranwal',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                      ),
                    ),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xff476cfb),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 4,
                      splashColor: Colors.blueGrey,
                      child: Text('Cancel', style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ),

                    RaisedButton(
                      color: Color(0xff476cfb),
                      onPressed: () {
                        uploadPic(context);
                      },
                      elevation: 4,
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ),

                  ],
                )


              ],
            ),
          ),
        )
      ),
    );
  }
}
