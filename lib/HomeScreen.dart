import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.scanner_outlined,
                                size: 25, color: Colors.white),
                            const Text('Scan',
                                style: TextStyle(
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        onTap: () => {},
                      ),
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.assignment_sharp,
                                size: 25, color: Colors.white),
                            const Text('Recognize',
                                style: TextStyle(
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        onTap: () => {},
                      ),
                      InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.image_outlined,
                                size: 25, color: Colors.white),
                            const Text('Enhance',
                                style: TextStyle(
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        onTap: () => {},
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
              child: Container(
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
                        onTap: () => {},
                      ),
                      InkWell(
                        child: const Icon(Icons.image_outlined,
                            size: 35, color: Colors.white),
                        onTap: () => {},
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}
