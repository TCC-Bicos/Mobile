import 'package:flutter/material.dart';
import '../../utils/app_routes.dart';

class ModalMenu extends StatelessWidget {
  const ModalMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  title: const Text(
                    'Configurações',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.configs);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.history,
                    size: 25,
                  ),
                  title: const Text(
                    'Histórico de transações',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.configs);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.archive,
                    size: 25,
                  ),
                  title: const Text(
                    'Projetos',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.configs);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.work,
                    size: 25,
                  ),
                  title: const Text(
                    'Anúncios',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.configs);
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          child: Container(
            width: 60,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 145, 145, 145),
            ),
          ),
        ),
      ],
    );
  }
}
