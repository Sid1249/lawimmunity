import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color(0xffeb9404),
          padding: const EdgeInsets.only(left: 8, right: 8, top: 7, bottom: 7, ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              const Text(
                "PINNED LOCATIONS ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 2.45,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/ 2,
          child: ListView.builder(
            itemCount: 16,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return const ListTile(
                leading: Icon(Icons.my_location),
                title: Text(
                  '2.8882323,2.3422343',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.64,
                  ),
                ),
                subtitle: Text(
                  'I’M IN A CAB WITH SANTOSH AND HIS NUMBER IS 877323421',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    letterSpacing: 0.64,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
