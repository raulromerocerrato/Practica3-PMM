import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/artwork.dart';

class CardSwiper extends StatelessWidget {
  Future<List<Artwork>> _carregarObres() async {
    const base = 'https://collectionapi.metmuseum.org/public/collection/v1';

    final resposta = await http.get(Uri.parse('$base.1/search?isHighlight=true&hasImages=true&q=painting&limit=10'));
    final dades = json.decode(resposta.body);
    final ids = (dades['objectIDs'] as List? ?? []).whereType<int>().toList();
    if (ids.isEmpty) {
      throw Exception('La cerca no ha retornat cap obra');
    }
    final obres = <Artwork>[];
    for (final id in ids) {
      try {
        final r = await http.get(Uri.parse('$base/objects/$id'));
        if (r.statusCode != 200) continue;
        final obra = Artwork.fromJson(json.decode(r.body));
        if (obra.teImatge) obres.add(obra);
      } catch (e) {
        continue;
      }
    }
    if (obres.isEmpty) {
      throw Exception('Cap obra té imatge');
    }
    return obres;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.red,
      child: FutureBuilder(
        future: _carregarObres(),
        builder: (BuildContext context, AsyncSnapshot<List<Artwork>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final obres = snapshot.data!;
          if (obres.isEmpty) {
            return const Center(child: Text('Llista buida'));
          }

          return Swiper(
            itemCount: obres.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (BuildContext context, int index) {
              final obra = obres[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details',
                    arguments: obra),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(obra.imatgeMiniatura),
                      fit: BoxFit.cover),
                ),
              );
            },
          );
        },
      )
    );
  }
}