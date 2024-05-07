import 'package:flutter/material.dart';
import 'package:flower_scan/pages/dialog_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flower Scan"),
        actions: [
          IconButton(
            onPressed: (){
            showDialog(context: context, 
            builder: (BuildContext context){
              return const DialogPage();
            });
          }, icon: const Icon(Icons.info))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Placeholder for image
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){

              }, 
              child: const Text("Camera")),
              ElevatedButton(onPressed: (){

              },
              child: const Text("Upload Photo"))
            ],
          ),
          const SizedBox(height: 20),

          ElevatedButton(onPressed: (){

          },
          child: const Text("Predict "))
        ],
      ),
    );
  }
}