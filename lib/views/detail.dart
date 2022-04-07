import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project86/models/character.dart';

class Detail extends StatelessWidget {
  final String type;
  final dynamic model;
  const Detail({Key? key, required this.model, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/bg2.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [builddetail(type)],
            ),
          ],
        ),
      ),
    );
  }

  Column builddetail(type) {
    List<String> tag = type == "waifu"
        ? [
            'Name',
            'Appears In',
            'Place Of Origin',
            'Age',
            'Date Of Birht',
            'Height',
            'Description'
          ]
        : [
            'Name',
            'Voice As',
            'Date Of Birth',
            'Gender',
            'HomeTown',
            'BloodType'
          ];
    Map<String, dynamic> waifu = type == "waifu"
        ? {
            'images': model.images,
            'Name': model.romanjiname,
            'Appears In': model.appears,
            'Place Of Origin': model.placeori,
            'Age': model.age,
            'Date Of Birht': model.brith,
            'Height': model.height,
            'Description': model.describ
          }
        : {
            'images': model.images,
            'Name': model.romanjiname,
            'Voice As': model.voiceas,
            'Date Of Birth': model.brith,
            'Gender': model.gender,
            'HomeTown': model.hometown,
            'BloodType': model.bloodtype
          };
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            waifu['images'],
            height: 450,
          ),
        ),
        Card(
          color: Color(0x919191),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(40.0),
          elevation: 5.0,
          shadowColor: Colors.black.withOpacity(1),
          child: Column(
            children: [
              for (var i = 0; i < tag.length; i++)
                tag[i] == "Description"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              tag[i],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              waifu[tag[i]]!.toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tag[i] + ":",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              waifu[tag[i]]!.toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
            ],
          ),
        ),
      ],
    );
  }
}
