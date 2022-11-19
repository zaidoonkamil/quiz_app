import 'package:flutter/material.dart';

const KprimaryColor= Color(0xffed475a);
final KprimaryScafoldColor=  Colors.grey.shade100;
final KprimarySupTextColor=  Colors.grey.shade900;

class ListDetail {
  ListDetail(
      {required this.title,
      required this.iconAssetName,
      required this.gradients,
      required this.shadowColor,
      required this.iconTag,
      required this.category,
      required this.textColor});
  final String title;
  final String iconAssetName;
  final List<Color> gradients;
  final Color shadowColor;
  final Object iconTag;
  final String category;
  final Color textColor;
}

const double opacity = 0.4;

final List<ListDetail> cardDetailList = [
  ListDetail(
    title: 'رياضة',
    iconAssetName: 'assets/images/sports and leisure.png',
    gradients: [
      const Color(0xff089e44),
      const Color(0xff3dd178),
    ],
    shadowColor: const Color(0xff3dd178).withOpacity(opacity),
    iconTag: 'sports_icon',
    category: 'sport_and_leisure',
    textColor: const Color(0xff089e44),
  ),
  ListDetail(
    title: 'مشاهير',
    iconAssetName: 'assets/images/film and tv.png',
    gradients: [
      const Color(0xff1c0659),
      const Color(0xff3c2a70),
    ],
    shadowColor: const Color(0xff8048f0).withOpacity(opacity),
    iconTag: 'film_icon',
    category: 'film_and_tv',
    textColor: const Color(0xff3c2a70),
  ),
  ListDetail(
    title: 'ثقافة',
    iconAssetName: 'assets/images/history.png',
    gradients: [
      const Color(0xffd6182e),
      const Color(0xffed475a),
    ],
    shadowColor: const Color(0xffed475a).withOpacity(opacity),
    iconTag: 'history_icon',
    category: 'history',
    textColor: const Color(0xffd6182e),
  ),
  ListDetail(
    title: 'جغرافيا',
    iconAssetName: 'assets/images/geography.png',
    gradients: [
      const Color(0xffd97014),
      const Color(0xfff2a057),
    ],
    shadowColor: const Color(0xfff2a057).withOpacity(opacity),
    iconTag: 'geography_icon',
    category: 'geography',
    textColor: const Color(0xffd97014),
  ),
  // ListDetail(
  //   title: 'History',
  //   iconAssetName: 'assets/images/history.png',
  //   gradients: [
  //     const Color(0xff1c0659),
  //     const Color(0xff3c2a70),
  //   ],
  //   shadowColor: const Color(0xff3c2a70).withOpacity(opacity),
  //   iconTag: 'history_icon',
  //   category: 'history',
  //   textColor: const Color(0xff3c2a70),
  // ),
  // ListDetail(
  //   title: 'Music',
  //   iconAssetName: 'assets/images/music.png',
  //   gradients: [
  //     const Color(0xff28272b),
  //     const Color(0xff48474a),
  //   ],
  //   shadowColor: const Color(0xff48474a).withOpacity(opacity),
  //   iconTag: 'music_icon',
  //   category: 'music',
  //   textColor: const Color(0xff28272b),
  // ),
  // ListDetail(
  //   title: 'Science',
  //   iconAssetName: 'assets/images/science.png',
  //   gradients: [
  //     const Color(0xffeb2aeb),
  //     const Color(0xfffc7efc),
  //   ],
  //   shadowColor: const Color(0xfffc7efc).withOpacity(opacity),
  //   iconTag: 'science_icon',
  //   category: 'science',
  //   textColor: const Color(0xffeb2aeb),
  // ),
  // ListDetail(
  //   title: 'Society and Culture',
  //   iconAssetName: 'assets/images/society and culture.png',
  //   gradients: [
  //     const Color(0xfff2bd05),
  //     const Color(0xffe6c657),
  //   ],
  //   shadowColor: const Color(0xffe6c657).withOpacity(opacity),
  //   iconTag: 'society_icon',
  //   category: 'society_and_culture',
  //   textColor: const Color(0xfff2bd05),
  // ),
  // ListDetail(
  //   title: 'Sports and Leisure',
  //   iconAssetName: 'assets/images/sports and leisure.png',
  //   gradients: [
  //     const Color(0xff395c91),
  //     const Color(0xff75aafa),
  //   ],
  //   shadowColor: const Color(0xff75aafa).withOpacity(opacity),
  //   iconTag: 'sports_icon',
  //   category: 'sport_and_leisure',
  //   textColor: const Color(0xff395c91),
  // ),
];
