import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, this.cameras});

  final List<CameraDescription>? cameras;
  // ? dapat memiliki nilai null

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  
  @override
  void initState(){
    super.initState();
    initCamera(widget.cameras![0]);
  }

  
  // Menginisialisasi Kamera
  Future initCamera(CameraDescription cameraDescription) async {
    // Membuat instance dari CameraController yang diteruskan ke argumen dan
    // menetapkan resolusi sebelum-set 720p
    _cameraController = CameraController(cameraDescription, ResolutionPreset.high);
    try {
      // Karena inisialisasi kamera memakan waktu maka digunakan kata kunci 'await'
      await _cameraController.initialize().then((_){
        // Mounted --> Widget masih ada di pohon widget
        if (!mounted) return;
        // Memperbarui tampilan dengan status terbaru
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("Camera Error $e");
    }
  }

  // Ambil Gambar
  Future takePicture() async{
    if (!_cameraController.value.isInitialized){
      return null;
    }
    if (_cameraController.value.isTakingPicture){
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.auto);
      XFile picture = await _cameraController.takePicture();
      File castedPicture = File(picture.path);
      if(mounted){
        Navigator.pop<File?>(context, castedPicture);
      }
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            (_cameraController.value.isInitialized)
              ? CameraPreview(_cameraController)
              : Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator()
                  )
                ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    color: Colors.black),
                    child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: (){
                                  // Memperbarui status widget
                                  setState(
                                    () => _isRearCameraSelected = !_isRearCameraSelected);
                                    // Jika _isRearCameraSelected = True, maka kamera indeks 0 (kamera belakang)
                                    initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                                },
                                icon: Icon(
                                  _isRearCameraSelected
                                    ? CupertinoIcons.switch_camera
                                    : CupertinoIcons.switch_camera_solid,
                                  color: Colors.white),
                                )
                              ),
                            Expanded(
                              child: IconButton(
                                onPressed: takePicture, 
                                icon: const Icon(
                                  Icons.circle,
                                  color: Colors.white
                                  ),
                                  iconSize: 50,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  )
                              ),
                              const Spacer()
                          ],)
                  ),
                )
          ],
        ))
    );
  }
}