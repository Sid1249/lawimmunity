import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawimmunity/screens/faq_page/faq_page.dart';
import 'package:lawimmunity/screens/proscreen/pro_pricing_page.dart';
import 'package:lawimmunity/screens/settings_page/delete_data_modal.dart';
import 'package:lawimmunity/widgets/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValueNotifyNominees = false;
  bool _switchValue3secTimer = false;
  bool _switchValueSyncLocation = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Settings',
          actionWidgets: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, ModalRoute.withName('/redirect'));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Logged in As :',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '+918707857915',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProPricingPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 13.0, bottom: 4, left: 17, right: 17),
                          child: Text(
                            'UPGRADE TO PRO ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 13.0, top: 3, left: 17, right: 17),
                          child: Text(
                            'SAFEGUARD YOUR PROTECTION IN UNEXPECTED SITUATIONS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'GENERAL SETTINGS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: ListTile(
                          title: const Text(
                              'NOTIFY NOMINEES WHEN I START RECORDING VIDEO'),
                          trailing: CupertinoSwitch(
                            value: _switchValueNotifyNominees,
                            onChanged: (value) {
                              setState(() {
                                _switchValueNotifyNominees = value;
                              });
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: ListTile(
                          title: const Text(
                              'ENABLE 3 SECONDS TIMER BEFORE RECORDING VIDEO'),
                          trailing: CupertinoSwitch(
                            value: _switchValue3secTimer,
                            onChanged: (value) {
                              setState(() {
                                _switchValue3secTimer = value;
                              });
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: ListTile(
                          title: const Text(
                              'SYNC LOCATION EVEN WHEN NOT USING APP'),
                          subtitle: Text(
                            'ONLY FOR PRO',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                          trailing: CupertinoSwitch(
                            value: _switchValueSyncLocation,
                            onChanged: (value) {
                              setState(() {
                                _switchValueSyncLocation = value;
                              });
                            },
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'NOMINEE SETTINGS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: const ListTile(
                          title: Text('LOGIN AS NOMINEE'),
                          trailing: Icon(Icons.navigate_next)),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: const ListTile(
                          title: Text('ADD/REMOVE NOMINEE'),
                          trailing: Icon(Icons.navigate_next)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'OTHER SETTINGS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: const ListTile(
                          title: Text('UPDATE YOUR NAME'),
                          trailing: Icon(Icons.navigate_next)),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: const ListTile(
                          title: Text('GIFT LAW IMMUNITY TO SOMEONE'),
                          trailing: Icon(Icons.navigate_next)),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        color: const Color(0xfff3f5ed),
                      ),
                      child: ListTile(
                        title: const Text('FREQUENTLY ASKED QUESTIONS'),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FAQPage()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Color(0xfff3f5ed),
                  thickness: 1.3,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xfff3f5ed),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'ABOUT US',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xfff3f5ed),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'CONTACT US',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      DeleteDataModal().showDeleteDataModal(context: context);
                    },
                    child: const Text(
                      'DELETE MY DATA',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
