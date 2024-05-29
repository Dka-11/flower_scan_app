import 'dart:io';

import 'package:flutter/material.dart';

class PredictionResultScreen extends StatelessWidget {
  final File image;
  final String classificationResult;
  final String accuracy;

  PredictionResultScreen({
    required this.image,
    required this.classificationResult,
    required this.accuracy,
  });

  @override
  Widget build(BuildContext context) {
    var accuracyInNumber = double.parse(accuracy) * 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Prediction Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
            child:
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Image.file(
                    image,
                    height: MediaQuery.of(context).size.height/1.7
                  ),
            ),
          ),
            Text(
              'Hasil Klasifikasi : $classificationResult',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Akurasi: $accuracyInNumber%',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
