import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flower_scan/pages/camera_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flower_scan/pages/dialog_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? uploadedImage;
  int? imageHeight;
  int? imageWidth;

  void getImagePixels() async {
    late File processedImage;
    if(uploadedImage != null){
      processedImage = uploadedImage!;
    } else{
      processedImage = File("assets/components/placeholder.png");
    }
    List<int> imageBytes = await processedImage.readAsBytes();
    Uint8List uint8list = Uint8List.fromList(imageBytes);
    ui.Codec codec = await ui.instantiateImageCodec(uint8list);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    ui.Image image = frameInfo.image;
    setState(() {
      imageWidth = image.width;
      imageHeight = image.height;
    });
  }

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
          // Start Placeholder Image
          Center(
            child: 
            uploadedImage == null ?
            Image.asset(
              "",
              height: MediaQuery.of(context).size.height/1.7
            ):
            Column(
              children: [
                Image.file(
                  uploadedImage!,
                  height: MediaQuery.of(context).size.height/1.7
                ),
                imageHeight != null ?
                Text("Dimension of uploaded image : $imageHeight x $imageWidth"):
                const Text("Failed to get image's dimension")
              ],
            )
          ),
          const SizedBox(height: 20),
          // End Placeholder Image
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await availableCameras().then((value) async{
                    final result = await Navigator.push<File?>(context,
                    MaterialPageRoute(builder: 
                    (_) => CameraPage(cameras: value)
                    )
                    );

                    if (result != null){
                      setState(() {
                        uploadedImage = result;
                        getImagePixels();
                        if (kDebugMode) {
                          print("$imageHeight x $imageWidth");
                        }
                      });
                    }
                  }
                );
              }, 
              child: const Text("Camera")
              ),
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