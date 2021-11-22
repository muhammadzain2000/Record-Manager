import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:record_keeping/dynamic/models/file_model.dart';

class ViewImage extends StatelessWidget {
  Files file;
  ViewImage({this.file});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 60,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: MemoryImage(Base64Decoder().convert(file.fileBytes)),
              fit: BoxFit.fill)),
    );
  }
}
