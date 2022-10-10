import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

class ModalMenu extends StatelessWidget {
  const ModalMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -15,
          child: Container(
            width: 60,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              )),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
                title: const Text(
                  'Configurações',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
