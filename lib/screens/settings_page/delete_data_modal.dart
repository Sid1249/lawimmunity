import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDataModal {
  bool _deleteVideosData = false;
  bool _deleteLocationData = false;

  showDeleteDataModal({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      isScrollControlled: true,
      builder: (BuildContext bcontext) {
        return AnimatedPadding(
          padding: MediaQuery.of(bcontext).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: BottomSheet(
            onClosing: () {},
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, setState) =>
                      SingleChildScrollView(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'YOU CAN REQUEST YOUR DATA TO BE REMOVED PERMANENTLY FROM OUR SERVERS, JUST SELECT WHAT DATA TO DELETE:'.toLowerCase(),textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Calistoga'),),
                          ),
                          ListTile(
                              title: const Text('DELETE MY VIDEOS DATA',style: TextStyle(fontWeight: FontWeight.w700),),
                              trailing: CupertinoSwitch(
                                  value: _deleteVideosData,
                                  onChanged: (value) {
                                    setState(() => _deleteVideosData = value);
                                  })),
                          ListTile(
                            title: const Text('DELETE MY LOCATION DATA',style: TextStyle(fontWeight: FontWeight.w700)),
                            trailing: CupertinoSwitch(
                                value: _deleteLocationData,
                                onChanged: (value) {
                                  setState(() => _deleteLocationData = value);
                                }),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'CONFIRM DELETE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                        ],
                      )));
            },
          ),
        );
      },
    );
  }
}
