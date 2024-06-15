import 'dart:io';

import 'package:flutter/material.dart';

class PredictionResultScreen extends StatelessWidget {
  final File image;
  final Map listOfData;
  // final String classificationResult;
  // final String accuracy;

  PredictionResultScreen({
    required this.image,
    required this.listOfData,
    // required this.classificationResult,
    // required this.accuracy,
  });

  @override
  Widget build(BuildContext context) {
    String? classificationResult, errorMessage;
    double? accuracyInNumber;

    if (listOfData['code'] == 200) {
      classificationResult = listOfData['classificationResult'];
      accuracyInNumber = double.parse(listOfData['accuracy']) * 100;
    } else {
      errorMessage = listOfData['error'];
    }
    
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
            ), errorMessage != null
            ? Text(
                'Terjadi error : $errorMessage',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            : Column(
              children: [
                Text(
                  'Hasil Klasifikasi : $classificationResult',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Akurasi: $accuracyInNumber%',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
