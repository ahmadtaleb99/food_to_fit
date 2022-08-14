// import 'package:easy_localization/easy_localization.dart';
// class EnumValues<T> {
//   Map<String, T>? map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String>? get reverse {
//     if (reverseMap == null) {
//       reverseMap = map!.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
// enum Qualifications{
//   ELEMENTARY_SCHOOL,
//   JUNIOR_HIGH_SCHOOL,
//   SENIOR_HIGH_SCHOOL,
//   UNDERGRADUATE,
//   POST_GRADUATE,
//   MASTER,
//   DOCTORATE,
//   BACHELOR
// }
// extension on Qualifications {
//   String getValue(){
//     switch(this){
//
//       case Qualifications.ELEMENTARY_SCHOOL:
//         return 'elementary school'.tr();
//         break;
//       case Qualifications.JUNIOR_HIGH_SCHOOL:
//         return 'junior high school'.tr();
//
//         break;
//       case Qualifications.SENIOR_HIGH_SCHOOL:
//         return 'senior high school'.tr();
//
//         break;
//       case Qualifications.UNDERGRADUATE:
//         return 'undergraduate'.tr();
//
//         break;
//       case Qualifications.POST_GRADUATE:
//         return 'post undergraduate'.tr();
//
//         break;
//       case Qualifications.MASTER:
//         return 'master'.tr();
//
//         break;
//       case Qualifications.DOCTORATE:
//         return 'doctorate'.tr();
//
//         break;
//       case Qualifications.BACHELOR:
//         return 'bachelor'.tr();
//
//         break;
//     }
//   }
//
// }
// final qualificationsValues = EnumValues(
//     {
//       "electronics": Category.ELECTRONICS,
//       "jewelery": Category.JEWELERY,
//       "men's clothing": Category.MEN_S_CLOTHING,
//       "women's clothing": Category.WOMEN_S_CLOTHING
//     }
// );
