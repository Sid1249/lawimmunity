import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/nominess_page/add_nominee_modal.dart';
import 'package:lawimmunity/screens/nominess_page/nominee_widget.dart';
import 'package:lawimmunity/services/firebase_services.dart';
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
  @override
  Widget build(BuildContext context) {
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
                child: FutureBuilder<List<NomineeWidget>>(
              future: buildNomineesList(), // async work
              builder: (BuildContext context,
                  AsyncSnapshot<List<NomineeWidget>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Error: ${snapshot.error}',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Theme.of(context).colorScheme.error),),
                      );
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return const ListEmptyContainer(
                          emptyText: 'YOUR NOMINEE LIST IS EMPTY',
                          icon: Icons.person_outline,
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return snapshot.data![index];
                          },
                        );
                      }
                    }
                }
              },
            )),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RaisedGradientButton('ADD NOMINEE', onPressed: () {
                AddNomineeModal().showAddNomineeModal(context: context,nomineeAddedOrNotCallback: (wasNomineeAdded){
                  if(wasNomineeAdded){
                    print("yes");
                  }else{
                    print("noooooo");
                  }
                });
              }),
            )
          ],
        ),
      ),
    );
  }

  Future<List<NomineeWidget>> buildNomineesList() async {
    List<NomineeWidget> listNomineesList = [];
    var tempNomineeList = await FirebaseServices().getCurrentUserNomineeList();
    for (int i = 0; i < tempNomineeList.length; i++) {
      listNomineesList.add(NomineeWidget(
        index: i,
        title: tempNomineeList[i].nomineeName ?? '',
        subtitle: tempNomineeList[i].nomineePhone ?? '',
        uid: tempNomineeList[i].nomineeUid ?? '',
        callback: () {
          setState(() {});
        },
      ));
    }
    return listNomineesList;
  }
}
