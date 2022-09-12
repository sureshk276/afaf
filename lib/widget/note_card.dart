import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:speechreg/style/appStyle.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.8),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Appstyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          doc["Note_Title"],
          style: Appstyle.mainTitle,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          doc["Create_date"],
          style: Appstyle.dateTitle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          doc["Note_Content"],
          style: Appstyle.mainContent,
          overflow: TextOverflow.ellipsis,
        ),
      ]),
    ),
  );
}
