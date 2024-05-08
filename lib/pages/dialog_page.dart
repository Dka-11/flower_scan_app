import 'package:flutter/material.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cara pengambilan gambar"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Anyelir.JPG',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            const Text(
              "This is the main image",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("Got it"))
          ],
        ),
      ),
    );
  }
}