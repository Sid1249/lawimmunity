import 'package:flutter/material.dart';

class MoreOptionsModal {
  showMoreOptionsModal({required BuildContext context}) {
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
                          ListTile(
                            leading: Icon(
                              Icons.favorite,
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary,
                            ),
                            title: const Text('Try for 7 days Free'),
                          ),
                          ListTile(
                            leading: Icon(Icons.card_giftcard,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                            title: const Text('Gift LawImmunity to someone'),
                          ),
                          ListTile(
                            leading: Icon(Icons.info_outline,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                            title: const Text('Read Our FAQs'),
                          ),
                        ],
                      )));
            },
          ),
        );
      },
    );
  }
}
