import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/models/artwork.dart';

const String _base = 'https://collectionapi.metmuseum.org/public/collection';

Future<List<Artwork>> carregarObres({
  int? departamentId,
  String? cerca,
  int quantes = 10,
}) async {
  final parametres = <String, String>{
    'isHighlight': 'true',
    'hasImages': 'true',
    'limit': '${quantes * 2}',
    if (departamentId != null) 'departmentId': '$departamentId',
    if (cerca != null) 'q': cerca,
  };

  final url =
      Uri.parse('$_base/v1.1/search').replace(queryParameters: parametres);
  final resposta = await http.get(url);
  if (resposta.statusCode != 200) {
    throw Exception('Error ${resposta.statusCode} en la cerca');
  }

  final dades = json.decode(resposta.body);
  final ids = (dades['objectIDs'] as List? ?? []).whereType<int>().toList();

  final obres = <Artwork>[];
  for (final id in ids) {
    if (obres.length >= quantes) break;
    try {
      final r = await http.get(Uri.parse('$_base/v1/objects/$id'));
      if (r.statusCode != 200) continue;
      final obra = Artwork.fromJson(json.decode(r.body));
      if (obra.teImatge) obres.add(obra);
    } catch (e) {
      continue;
    }
  }
  return obres;
}