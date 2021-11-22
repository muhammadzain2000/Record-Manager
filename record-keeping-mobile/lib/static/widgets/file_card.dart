import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:record_keeping/dynamic/models/file_model.dart';
import 'package:record_keeping/static/screens/view_image.dart';

class FileCard extends StatefulWidget {
  Files file;
  FileCard({this.file});
  @override
  _FileCardState createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewImage(
                            file: widget.file,
                          )),
                );
              },
              child: Container(
                height: 80,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    image: DecorationImage(
                        image: MemoryImage(
                            Base64Decoder().convert(widget.file.fileBytes)),
                        fit: BoxFit.fill)),
              ),
            ),
            title: Text(widget.file.name),
            subtitle: Text(widget.file.subject),
            trailing: FlatButton.icon(
                icon: Icon(Icons.send),
                color: Colors.brown,
                label: Text('Forward'),
                onPressed: () async {}),
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
