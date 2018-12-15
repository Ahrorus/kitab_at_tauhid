import 'package:flutter/material.dart';

import '../../book_resource/book.dart';
import 'chapter_tabs_screen.dart';

class BookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                  title: Text(
                    chapters[position].russianTitle,
                  ),
                  subtitle: Text(chapters[position].arabicTitle),
                  leading: CircleAvatar(
                    child: Text((position + 1).toString()),
                  ),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookTabsScreen(position: position)),
                      ));
            }));
  }
}
