import 'package:flutter/material.dart';
import 'package:movies_app/models/artwork.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Artwork obra = ModalRoute.of(context)!.settings.arguments as Artwork;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(obra: obra),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(obra: obra),
                _Overview(obra: obra),
                CastingCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Artwork obra;

  const _CustomAppBar({required this.obra});

  @override
  Widget build(BuildContext context) {
        return SliverAppBar(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black54,
          padding: const EdgeInsets.only(bottom: 10, top: 6, left: 10, right: 10),
          child: Text(
            obra.titol,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(obra.imatgeMiniatura),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Artwork obra;

  const _PosterAndTitile({required this.obra});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(obra.imatgeMiniatura),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  obra.titol,
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(
                  obra.artista.isEmpty ? 'Artista desconegut' : obra.artista,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(obra.data,
                          style: textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Artwork obra;

  const _Overview({required this.obra});

  Widget _fila(BuildContext context, String etiqueta, String valor) {
    if (valor.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$etiqueta: $valor',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fila(context, 'Departament', obra.departament),
          _fila(context, 'Tècnica', obra.tecnica),
          _fila(context, 'Cultura', obra.cultura),
          _fila(context, 'Dimensions', obra.dimensions),
        ],
      ),
    );
  }
}