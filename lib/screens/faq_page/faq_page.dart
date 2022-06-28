import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:lawimmunity/screens/faq_page/faq_model.dart';
import 'package:lawimmunity/screens/faq_page/faq_provider.dart';
import 'package:lawimmunity/widgets/custom_app_bar.dart';
import 'package:lawimmunity/widgets/text_component.dart';
import 'package:provider/provider.dart';

class FAQPage extends StatelessWidget {
  FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FAQProvider faqProvider = Provider.of<FAQProvider>(context, listen: false);
    List<FAQModel> faqList = faqProvider.getAllFaq();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FAQ',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const SizedBox(height: 10,),
          //
          // UpperCaseText('FREQUENTLY ASKED QUESTIONS',
          //     style: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: 'Calistoga')),
          const SizedBox(height: 10,),
          Expanded(
              child: ListView.builder(
                  itemCount: faqList.length,
                  itemBuilder: (context, i) {
                    return ListTileTheme(
                      contentPadding: const EdgeInsets.all(0),
                      child: Text("")
,
                      // ExpansionTile(
                      //   title: Html(
                      //     data: faqList[i].question,
                      //     // style: Theme.of(context).textTheme.titleLarge,
                      //   ),
                      //   children: <Widget>[
                      //     Html(data: faqList[i].answer.replaceAll('~', '\n'),
                      //         // style: Theme.of(context).textTheme.subtitle2
                      //     ),
                      //   ],
                      // ),
                    );
                  })),
        ]),
      ),
    );
  }
}
