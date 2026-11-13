import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  // Llista d'URLs de les imatges addicionals de l'obra
  final List<String> imatges;

  const CastingCards({required this.imatges});

  @override
  Widget build(BuildContext context) {
    // Moltes obres no tenen imatges addicionals: llavors no mostrem res
    if (imatges.isEmpty) return const SizedBox(height: 30);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text('Altres vistes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 200,
          // color: Colors.red,
          child: ListView.builder(
              itemCount: imatges.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) =>
                  _CastCard(imatge: imatges[index], numero: index + 1)),
        ),
      ],
    );
  }
}

class _CastCard extends StatelessWidget {
  final String imatge;
  final int numero;

  const _CastCard({required this.imatge, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(imatge),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Vista $numero',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}