import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/nominess_page/add_nominee_modal.dart';
import 'package:lawimmunity/screens/nominess_page/nominee_widget.dart';
import 'package:lawimmunity/widgets/custom_app_bar.dart';
import 'package:lawimmunity/widgets/custom_raised_button.dart';
import 'package:lawimmunity/widgets/description_widget.dart';
import 'package:lawimmunity/widgets/list_empty_container.dart';

class NomineesPage extends StatefulWidget {
  const NomineesPage({Key? key}) : super(key: key);

  @override
  State<NomineesPage> createState() => _NomineesPageState();
}

class _NomineesPageState extends State<NomineesPage> {
  List<NomineeWidget> listNomineesList = [];

  @override
  Widget build(BuildContext context) {
    buildNomineesList();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Nominees',
        ),
        body: Column(
          children: [
            DescriptionText(
              edgeInsetsTop: const EdgeInsets.only(top: 24, left: 13),
              edgeInsetsBottom: const EdgeInsets.only(top: 8, left: 13),
              title: 'MY NOMINEES',
              subtitle:
                  'YOUR NOMINEES CAN ACCESS YOUR RECORDED VIDEOS AND LAST LOCATION IN CASE OF EMERGENCY.',
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: listNomineesList.isEmpty
                    ? const ListEmptyContainer(
                        emptyText: 'YOUR NOMINEE LIST IS EMPTY',
                        icon: Icons.person_outline,
                      )
                    : ListView.builder(
                        itemCount: listNomineesList.length,
                        itemBuilder: (context, index) {
                          return listNomineesList[index];
                        },
                      )),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RaisedGradientButton('ADD NOMINEE', onPressed: () {
                AddNomineeModal().showAddNomineeModal(context: context);
              }),
            )
          ],
        ),
      ),
    );
  }

  void buildNomineesList() {
    listNomineesList = [];
    for (int i = 0; i < 2; i++) {
      listNomineesList.add(NomineeWidget(
        index: i,
        title: 'Manvendra Singh',
        subtitle: '+918707857915',
      ));
    }
  }
}
