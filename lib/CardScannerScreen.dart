import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class CardScannerScreen extends StatefulWidget {
  File image;
  CardScannerScreen(this.image);

  @override
  State<CardScannerScreen> createState() => _CardScannerScreenState();
}

class _CardScannerScreenState extends State<CardScannerScreen> {
  @override
  late TextRecognizer textCardScanner;
  late EntityExtractor entityExtractor;
  List<EntityDM> entitiesList = [];

  initState() {
    print('Cardscanner started');
    super.initState();
    textCardScanner = TextRecognizer(script: TextRecognitionScript.latin);
    entityExtractor =
        EntityExtractor(language: EntityExtractorLanguage.english);

    doTextRecognition();
  }

  String results = "";
  doTextRecognition() async {
    InputImage inputImage = InputImage.fromFile(this.widget.image);
    final RecognizedText recognizedText =
        await textCardScanner.processImage(inputImage);
    entitiesList.clear();
    results = recognizedText.text;

    print(results);
    final List<EntityAnnotation> annotations =
        await entityExtractor.annotateText(results);

    print('doTextRecognition in the card scanner');
    print(annotations.length);

    results = "";
    for (final annotation in annotations) {
      annotation.start;
      annotation.end;
      annotation.text;
      for (final entity in annotation.entities) {
        results += entity.type.name + "\n" + annotation.text + "\n\n";
        entitiesList.add(EntityDM(entity.type.name, annotation.text));
      }
    }
    print(results);
    setState(() {
      results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent, title: Text('Card Scanner')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.file(this.widget.image),
              Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.grey.shade300,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.document_scanner,
                                color: Colors.white,
                              ),
                              const Text(
                                'Results',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: results));
                                  SnackBar sn =
                                      SnackBar(content: Text("Copied"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(sn);
                                },
                                child: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        results,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class EntityDM {
  String name;
  String value;
  IconData? iconData;

  EntityDM(this.name, this.value) {
    if (name == "phone") {
      iconData = Icons.phone;
    } else if (name == "address") {
      iconData = Icons.location_on;
    } else if (name == "email") {
      iconData = Icons.mail;
    } else if (name == "url") {
      iconData = Icons.web;
    } else {
      iconData = Icons.ac_unit_outlined;
    }
  }
}
