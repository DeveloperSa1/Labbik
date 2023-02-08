/*
 * Copyright 2020 Cagatay Ulusoy (Ulus Oy Apps). All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:labbaik/shared/store/CustomChart/widgets/contained_input_chip.dart';
class Activity {
  late final int id;
  final String name;
  final String type;
  final int rating;
   String? studentID;
  final List<String>? goals;

  Activity({
    this.studentID,
    required this.id,
    required this.name,
    required this.type,
    required this.rating,
    this.goals,
  });
}

class PieChartLegend extends StatelessWidget {
  final List<MaterialColor> supplementaryColors;

  const PieChartLegend({Key? key, required this.supplementaryColors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
  final List<Activity> activities = [
    Activity(
        id: 1,
        name: "المهارات الادراكية",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 2,
        name: "مهارات حركية كبرى",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 3, name: "مهارات الحساب", type: 'activity', rating: 0, goals: []),
    Activity(
        id: 4,
        name: "مهارات التربيه الاسلامية",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 5,
        name: "مهارات الانتباه و التركيز",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 6, name: "مهارات معرفية", type: 'activity', rating: 0, goals: []),
    Activity(
        id: 7,
        name: "مهارات حركية دقيقه",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 8, name: "مهارات معرفيه", type: 'activity', rating: 0, goals: []),
    Activity(
        id: 9,
        name: "مهارات حركية دقيقه",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 10, name: "مهارات القراءه", type: 'activity', rating: 0, goals: []),
    Activity(
        id: 11,
        name: "مهارات إجتماعيه",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 12,
        name: "مهارات التواصل السمعي / البصري",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 13, name: "مهارات الكتابه", type: 'activity', rating: 0, goals: []),
    Activity(
        id: 14,
        name: "مهارات رعاية ذات",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 15,
        name: "مهارات الذاكرة السمعيه / البصرية ",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 16, name: "مهارات التقليد", type: 'activity', rating: 0, goals: []),
    Activity(
        id: 17,
        name: "مهارات التلوين و القص",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 18, name: "مهارات العلوم", type: 'activity', rating: 0, goals: []),
    Activity(
        id: 19,
        name: " مهارات ما قبل الأكاديمية",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 20,
        name: "سيكوموتر / نفسي حركي",
        type: 'activity',
        rating: 0,
        goals: []),
    Activity(
        id: 22, name: "تنمية المهارات", type: 'solo', rating: 0, goals: []),
    Activity(
        id: 23,
        name: "تنمية و تنظيم المدخلات الحسية",
        type: 'solo',
        rating: 0,
        goals: []),
    Activity(
        id: 24, name: "English الانجليزي", type: 'solo', rating: 0, goals: []),
    Activity(id: 25, name: "الاكاديمي", type: 'solo', rating: 0, goals: []),
    Activity(id: 26, name: "تعديل سلوك", type: 'solo', rating: 0, goals: []),
    Activity(
        id: 27,
        name: " تطوير الاداء الوظيفي",
        type: 'solo',
        rating: 0,
        goals: []),
  ];

    return Wrap(
      spacing: AppDimens.SIZE_SPACING_MEDIUM,
      direction: Axis.horizontal,
      children: [
        for (int i = 0; i < supplementaryColors.length; i++)
          ContainedInputChip(labelText: '${activities[i].name}', color: supplementaryColors[i])
      ],
    );
  }
}
