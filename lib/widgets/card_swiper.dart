import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/helpers/met_api.dart';
import 'package:movies_app/models/artwork.dart';

class CardSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        height: size.height * 0.5,
        // color: Colors.red,
        child: FutureBuilder(
          future: carregarObres(cerca: 'painting'),
          builder:
              (BuildContext context, AsyncSnapshot<List<Artwork>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text('No s\'han pogut carregar les obres')
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final obres = snapshot.data!;
            if (obres.isEmpty) {
              return const Center(child: Text('No hi ha obres'));
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
        ));
  }
}