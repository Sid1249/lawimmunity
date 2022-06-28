import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/faq_page/faq_model.dart';

class FAQProvider extends ChangeNotifier {
  List<FAQModel> getAllFaq() {
    List<FAQModel> faqList = [];

    faqList.add(FAQModel(
        question: '<h3>What is Law Immunity</h3>',
        answer:
            'Law Immunity safeguards you and your loved ones, it automatically tracks your <b>LOCATION</b> everytime you come in motion, and keeps it in sync with your <b>NOMINEES</b>.<br>Not only this LawImmunity also gives you the confidence that you are not alone in any situation, it gives you the option to <B>RECORD LIVE VIDEOS</b> that can be directly accessed by your nominees. The person in front of you won\'t be able to force you to delete recording.' ));

    return faqList;

  }
}
