import 'package:flutter/material.dart';
import 'package:movies_app/models/artwork.dart';
import 'package:movies_app/helpers/met_api.dart';

class MovieSlider extends StatelessWidget {
  final String titol;
  final int departamentId;

  const MovieSlider({required this.titol, required this.departamentId});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(titol, style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: FutureBuilder(
              future: carregarObres(departamentId: departamentId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Artwork>> snapshot) {
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

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: obres.length,
                  itemBuilder: (_, int index) =>
                    _MoviePoster(obra: obres[index])
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Artwork obra;

  const _MoviePoster({required this.obra});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: obra),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(obra.imatgeMiniatura),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            obra.titol,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}