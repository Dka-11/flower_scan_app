import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flower_scan/pages/camera_page.dart';
import 'package:flower_scan/pages/get_image_page.dart';
import 'package:flower_scan/widgets/error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flower_scan/pages/petunjuk_page.dart';
import 'package:flower_scan/pages/prediction_page.dart';
import 'package:flower_scan/pages/results_page.dart';
import 'package:flower_scan/widgets/loading_widget.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? uploadedImage;
  int? imageHeight;
  int? imageWidth;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Petunjuk"),
            content: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Untuk mengetahui cara pengambilan gambar, silahkan klik ",
                    style: TextStyle(
                      color: Colors.black
                    )
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.info),
                  ),
                  TextSpan(
                    text: " ikon di pojok kanan atas.",
                    style: TextStyle(
                      color: Colors.black
                    )
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK",
                style: TextStyle(
                  color: Colors.green[700]
                ),),
              ),
            ],
          );
        },
      );
    });
  }

  void getImagePixels() async {
    late File processedImage;
    if(uploadedImage != null){
      processedImage = uploadedImage!;
    } else{
      return;
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

  void deleteUploadedImage() {
    setState(() {
      uploadedImage = null;
    });
  }

  Future<void> predictImage() async {
    setState(() {
      _isLoading = true;
    });

    if (uploadedImage == null) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ErrorDialog();
      },
    );
      return;
    }

    final result = await PredictionService.predictImage(uploadedImage!, useLocal: true);

    if (result != null) {
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PredictionResultScreen(
            image: uploadedImage!,
            listOfData: result,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flower Scan"),
        backgroundColor: Colors.green[400],
        actions: [
          IconButton(
            onPressed: (){
            showDialog(context: context, 
            builder: (BuildContext context){
              return const PetunjukPage();
            });
          }, icon: const Icon(Icons.info))
        ],
      ),
      body: _isLoading 
      ? LoadingPage()
      : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Start Placeholder Image
          Center(
            child: 
            uploadedImage == null ?
            Image.asset(
              'assets/images/placeholder_images.png',
              height: MediaQuery.of(context).size.height/1.7
            ):
            Column(
              children: [
                Image.file(
                  uploadedImage!,
                  height: MediaQuery.of(context).size.height/1.7
                ),
                // imageHeight != null ?
                // Text("Dimension of uploaded image : $imageHeight x $imageWidth"):
                // const Text("Failed to get image's dimension")
              ],
            )
          ),
          const SizedBox(height: 0),
          uploadedImage == null
          ? const SizedBox(height: 0)
          : Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: ElevatedButton(
              onPressed:deleteUploadedImage,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(40, 40),
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.red
              ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            )),
          ),
          ElevatedButton(onPressed: predictImage,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700]
          ),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 12, top: 12),
                child: Text(
                  "Predict", 
                style: TextStyle(fontSize: 18, color: Colors.white),),
              )),
          const SizedBox(height: 30),
          // End Placeholder Image
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () async {
                final result = await GetImage().getImageFromGallery(context);

                if (result != null){
                  setState(() {
                    uploadedImage = result;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 12),
                child: Text("Gallery", 
                style: TextStyle(
                  color: Colors.green[900],
                ),),
              )
              ),
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
                        // getImagePixels();
                        // if (kDebugMode) {
                        //   print("$imageHeight x $imageWidth");
                        // }
                      });
                    }
                  }
                );
              }, 
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 12),
                child: Text("Camera",
                style: TextStyle(
                  color: Colors.green[900]
                ),),
              )
              ),
            ],
          ),
        ],
      ),
    );
  }
}