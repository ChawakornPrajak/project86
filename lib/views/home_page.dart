import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project86/models/character.dart';
import 'package:project86/models/middle.dart';
import 'package:project86/models/voice_actor.dart';
import 'package:project86/views/detail.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.round();
    List<String> tag = ['Name','Studio','Release Date','Original Run','Synopsis'];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/icon.png"),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Stack(
          children: [ Image.asset("assets/images/bg2.jpg",width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
            ListView(
              children: [
                buildmiddle(tag),
                Center(child: Text("Character & Voiceactors",style: TextStyle(
                  fontSize: 50 ,color: Colors.white
                ),)),
                buildclickcard(width),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GridView buildclickcard(int width) {
    return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (width/400).round(),mainAxisExtent: 400,
              ),
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              itemCount: waifu.length + va.length,
              itemBuilder:(BuildContext context, int index) {
                return buildcard(index%2==0? waifu[(index/2).floor()] : va[(index/2).floor()]);
              }
          );
  }
  Widget buildcard(waifu){
    return Card(
      color: Colors.black.withOpacity(0.5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Detail(model:waifu,type:waifu.runtimeType==Character?"waifu":"actors",)),
          );
        },
        child: Stack(
          children: [
            Image.asset(waifu.images,width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(waifu.romanjiname,style: TextStyle(color: Colors.black),),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Column buildmiddle(List<String> tag) {
    return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/middle2.jpg",height: 700,),
              ),
              Card(
                color: Color(0x919191),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.all(40.0),
                elevation: 5.0,
                shadowColor: Colors.black.withOpacity(0.5),
                child:
                  Column(
                   children: [
                     for(var i =0;i<tag.length;i++)
                       tag[i]=="Synopsis"?
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(2.0),
                                 child: Text(tag[i],style: TextStyle(
                                   fontSize: 30,color: Colors.white
                                 ),),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(4.0),
                                 child: Text(middle[tag[i]]!,style: TextStyle(
                                     fontSize: 20,color: Colors.white
                                 ),),
                               ),
                             ],
                           )
                       :Row(
                         children: [
                           Text(tag[i]+":",style: TextStyle(
                             fontSize: 30,color: Colors.white
                           ),),
                           Padding(
                             padding: const EdgeInsets.only(left:10.0),
                             child: Text(middle[tag[i]]!,style: TextStyle(
                               fontSize: 20,color: Colors.white
                             ),),
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
