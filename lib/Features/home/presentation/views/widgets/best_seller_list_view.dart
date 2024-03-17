// import 'package:bookly/core/widgets/custom_error_widget.dart';
// import 'package:bookly/core/widgets/custom_loading_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'best_seller_list_view_item.dart';
//
// class BestSellerListView extends StatelessWidget {
//   const BestSellerListView({super.key,required this.authorName,required this.bookName,required this.coverImage});
//   final String bookName;
//   final String authorName;
//   final String coverImage;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.zero,
//       itemBuilder: (context, index) {
//         return  Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: BookListViewItem(
//             authorName:authorName ,
//              bookName: bookName,
//             coverImage:coverImage ,
//
//           ),
//         );
//       },
//     );
//   }
// }
