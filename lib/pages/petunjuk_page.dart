import 'package:flutter/material.dart';

class PetunjukPage extends StatelessWidget {
  const PetunjukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Cara Pengambilan Gambar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                  "Pengambilan Gambar dengan Camera",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20), // Add some spacing at the top
              Image.asset(
                'assets/images/Anyelir.JPG',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10),
              const Text(
                  "1. Tekan tombol Camera.                                                ",
                  textAlign: TextAlign.justify,
                ),
              const Text(
                  "2. Fokuskan pengambilan gambar pada satu bunga seperti gambar di atas menggunakan kamera belakang.",
                  textAlign: TextAlign.justify,
                ),
              const Text(
                  "3. Pastikan pengambilan gambar tidak jauh dari bunga dan tampak jelas sehingga mendapatkan hasil yang maksimal.",
                  textAlign: TextAlign.justify,
                ),
              const SizedBox(height: 20),
                const Text(
                  "Pengambilan Gambar dengan Gallery",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Image.asset(
                'assets/images/choose_gallery.jpg',
                width: 200,
              ),
              const SizedBox(height: 10),
                const Text(
                  "1.   Tekan tombol Gallery.                                                              ",
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  "2.   Pilih gambar bunga yang akan diprediksi.                                        ",
                  textAlign: TextAlign.justify,
                ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}