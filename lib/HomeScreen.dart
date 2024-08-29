import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanner_app/CardScannerScreen.dart';
import 'package:scanner_app/RecognizerScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ImagePicker imagePicker;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  bool scan = false;
  bool recognize = true;
  bool enhance = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50, bottom: 15, left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              color: Colors.blueAccent,
              child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.scanner,
                              size: 25,
                              color: scan ? Colors.black : Colors.white,
                            ),
                            Text(
                              'Scan',
                              style: TextStyle(
                                color: scan ? Colors.black : Colors.white,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            scan = true;
                            recognize = false;
                            enhance = false;
                          });
                        },
                      ),
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.document_scanner,
                              size: 25,
                              color: recognize ? Colors.black : Colors.white,
                            ),
                            Text(
                              'Recognize',
                              style: TextStyle(
                                color: recognize ? Colors.black : Colors.white,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            scan = false;
                            recognize = true;
                            enhance = false;
                          });
                        },
                      ),
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.assignment_sharp,
                              size: 25,
                              color: enhance ? Colors.black : Colors.white,
                            ),
                            Text(
                              'Enhance',
                              style: TextStyle(
                                color: enhance ? Colors.black : Colors.white,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            scan = false;
                            recognize = false;
                            enhance = true;
                          });
                        },
                      ),
                    ],
                  )),
            ),
            Card(
              color: Colors.black,
              child: Container(
                height: MediaQuery.of(context).size.height - 300,
              ),
            ),
            Card(
              color: Colors.blueAccent,
              child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: const Icon(Icons.rotate_left,
                            size: 35, color: Colors.white),
                        onTap: () => {},
                      ),
                      InkWell(
                        child: const Icon(Icons.camera,
                            size: 50, color: Colors.white),
                        onTap: () async {
                          XFile? image = await imagePicker.pickImage(
                              source: ImageSource.camera);
                          // You can now use the 'image' variable here
                          if (image != null) {
                            // Do something with the image, for example:
                            print('Image selected: ${image.path}');
                          } else {
                            print('No image selected.');
                          }
                        },
                      ),
                      InkWell(
                        child: const Icon(Icons.image_outlined,
                            size: 35, color: Colors.white),
                        onTap: () async {
                          XFile? xfile = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          // You can now use the 'image' variable here
                          if (xfile != null) {
                            File image = File(xfile.path);

                            final edittedImage = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageCropper(
                                        image: image.readAsBytesSync())));

                            image.writeAsBytes(edittedImage);
                            if (recognize) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return RecognizerScreen(image);
                              }));
                            } else if (scan) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return CardScannerScreen(image);
                              }));
                            }
                          } else {
                            print('No image selected.');
                          }
                        },
                      )
                    ],
                  )),
            ),
          ],
        ));
  }

  processImage(File image) async {
    final editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageCropper(
          image: image.readAsBytesSync(), // <-- Uint8List of image
        ),
      ),
    );
    image.writeAsBytes(editedImage);
    if (recognize) {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return RecognizerScreen(image);
      }));
    } else if (scan) {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return CardScannerScreen(image);
      }));
    } else if (enhance) {
      // Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      //   return EnhanceScreen(image);
      // }));
    }
  }
}
