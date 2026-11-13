import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Met Museum'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(),

              MovieSlider(titol: 'Pintura europea', departamentId: 11),
              MovieSlider(titol: 'Art egipci', departamentId: 10),
              MovieSlider(titol: 'Art modern', departamentId: 21),
            ],
          ),
        ),
      ),
    );
  }
}
