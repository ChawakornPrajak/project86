class Actor {
  final String images;
  final String romanjiname;
  final String voiceas;
  final String brith;
  final String gender;
  final String hometown;
  final String bloodtype;

  Actor({required this.images,required this.voiceas,required this.romanjiname, required this.brith, required this.gender, required this.hometown, required this.bloodtype});
}
List<Actor> va = [
  Actor(images: "assets/images/Ikumi.png",
      romanjiname: "Ikumi Hasegawa",
      voiceas: "Vuradirēna Mirīze",
      brith: "May 31",
      gender: "Female",
      hometown: "Tochigi Prefecture, Japan",
      bloodtype: "A"
  ),
  Actor(images: "assets/images/Saori.png",
      romanjiname: "Saori Hayami",
      voiceas: "Anju Emma" ,
      brith: "May 29",
      gender: "Female",
      hometown: "Tokyo, Japan",
      bloodtype: "AB"
  ),
  Actor(images: "assets/images/Sayumi.png",
      romanjiname: "Saori Hayami",
      voiceas: "Kurena Kukumila" ,
      brith: "Feb 4",
      gender: "Female",
      hometown: "Kanagawa Prefecture, Japan",
      bloodtype: "Unknow"
  ),
  Actor(images: "assets/images/Misaki.png",
      romanjiname: "Misaki Kuno",
      voiceas: "Furederika Rо̄zenforuto",
      brith: "Jan 19",
      gender: "Female",
      hometown: "Tokyo, Japan",
      bloodtype: "A"
  ),
  Actor(images: "assets/images/Riho.png",
      romanjiname: "Riho Sugiyama",
      voiceas: "Henrietta 'Annette' Penrose",
      brith: "Dec 31",
      gender: "Female",
      hometown: "Hokkaido Prefecture, Japan",
      bloodtype: "Unknow"
  ),
  Actor(images:"assets/images/Shouya.png",
      romanjiname: "Shouya Chiba",
      voiceas: "Shinei Nouzen",
      brith: "Aug 29",
      gender: "Male",
      hometown: "Tokyo, Japan",
      bloodtype: "B"
  ),
  Actor(images: "assets/images/Seiichirou.png",
      romanjiname: "Seiichirou Yamashita",
      voiceas: "Raiden Shuga",
      brith: "May 21",
      gender: "Male",
      hometown: "Hiroshima Prefecture, Japan",
      bloodtype: "Unknow"
  ),
  Actor(images: "assets/images/Natsumi.png",
      romanjiname: "Natsumi Fujiwara",
      voiceas: "Seoto Rikka",
      brith: "Jun 2",
      gender: "Female",
      hometown: "Shizuoka, Japan",
      bloodtype: "Unknow"
  ),
];