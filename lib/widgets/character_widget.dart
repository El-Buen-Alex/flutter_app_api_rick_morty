
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taller_2/models/character_model.dart';

class CharacterCardWidegt extends StatelessWidget {
  const CharacterCardWidegt({Key? key, required this.characterModel, required this.num}) : super(key: key);
  final CharacterModel characterModel;
  final int num;

  @override
  Widget build(BuildContext context) {
    // inspect(characterModel);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
               clipBehavior: Clip.hardEdge,
              width: double.infinity,
              decoration:   const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                gradient:  LinearGradient(colors: [
                  Colors.red,
                  Colors.blue
                ])
              ),
              
              child: Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 5, top: 5),
                child: Text(characterModel.name, textAlign: TextAlign.start, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white
                    ),
                ),
              ),
            ),
            Row(
              children: [
                 SizedBox(
                  height: 75,
                  width: 75,
                  child: Image(image: NetworkImage(characterModel.image)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      
                      Text('Especie: - ${characterModel.species}' ),
                      Text('Genero: ${characterModel.gender}'),
                      Text('Estado: ${characterModel.status}'),
                      const SizedBox(height: 10,)
                    ],
                  ),
                )
              ],
            )
           
          ],
        )
      ),
    );
  }
}