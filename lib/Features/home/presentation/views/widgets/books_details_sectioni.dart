import 'package:bookly/presentation/screens/pdf.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';
import 'custom_book_item.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection(
      {super.key,
      required this.authorName,
      required this.bookName,
      required this.aboutAuthor,
      required this.bookDescription,
      required this.coverImage,
      required this.bookPdf});
  final String authorName;
  final String bookName;
  final String bookDescription;
  final String aboutAuthor;
  final String coverImage;
  final String bookPdf;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .2,
          ),
          child: CustomBookImage(
            imageUrl: coverImage,
          ),
        ),
        const SizedBox(
          height: 43,
        ),
        Text(
          bookName,
          style: Styles.textStyle30.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 6,
        ),
        Opacity(
          opacity: .7,
          child: Text(
            "المؤلف: $authorName",
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Opacity(
          opacity: .7,
          child: Text(
            bookDescription,
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          endIndent: 30,
          indent: 30,
        ),
        const SizedBox(height: 12),
        Opacity(
          opacity: .7,
          child: Text(
            "حسن الجندي مؤلف مصري شاب حصل على شهرة من خلال ثلاثية (مخطوطة بن إسحاق) والتي وضعت منذ مدة طويلة على المنتديات العربية وانتهت بطباعتها ونزولها المكتبات المصرية، يتميز بسهولة تعبيراته واهتمامه بعامل التشويق داخل الروايات واختراقه أماكن كثيرة محرمة، يقول في أحد اللقاءات الصحفية أنه تلقى الكثير من الاتصالات والرسائل تطلب منه أرقام هواتف شخصيات معينة في روايته وعندما كان يخبرهم بأنها شخصيات ليست حقيقية كان البعض يصر على أنه يخفي حقيقتها لدواعي أمنية.دائماً ما يقول أنه يحاول أن يوجد نوعاً جديداً من أدب الرعب يناسب العقلية المصرية والعربية ويمكنه أن يفرض نفسه على الساحة العالمية وليس مجرد تقليد أو مسخ للقصص الأوربية عن الرعب والتي تتكلم عن مصاصي الدماء والمتحولين والمذؤوب، يجمع الكثير على أنه استطاع بعد ظهور أولى رواياته أن يثبت أنه يسير على الطريق الصحيح.",
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(
          height: 37,
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfView(bookUrl: bookPdf),
              )),
          child: Container(
            width: 80,
            height: 35,
            decoration: BoxDecoration(
                // color: const Color(0xfffbf4ea),
                //
                color: Colors.red,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                "Read",
                style: Styles.textStyle20
                    .copyWith(fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 37,
        ),
        // BooksAction(
        //   bookModel: book,
        // ),
      ],
    );
  }
}
