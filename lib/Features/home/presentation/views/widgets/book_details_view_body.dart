import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'books_details_sectioni.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody(
      {super.key,
      required this.authorName,
      required this.bookName,
      required this.bookDescription,
      required this.aboutAuthor,
      required this.coverImage,
      required this.coverPdf});
  final String authorName;
  final String bookName;
  final String bookDescription;
  final String aboutAuthor;
  final String coverImage;
  final String coverPdf;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                BookDetailsSection(
                  authorName: authorName,
                  bookName: bookName,
                  aboutAuthor: aboutAuthor,
                  bookDescription: bookDescription,
                  coverImage: coverImage,
                  bookPdf: coverPdf,
                ),
                const Expanded(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
