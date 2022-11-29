import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_routes.dart';
import '../../utils/statusFree_User.dart';
import '../../utils/tema.dart';

class ModalMenu extends StatefulWidget {
  const ModalMenu({Key? key}) : super(key: key);

  @override
  State<ModalMenu> createState() => _ModalMenuState();
}

class _ModalMenuState extends State<ModalMenu> {
  late int theme;
  late int status;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 260,
          // height: 360,
          decoration: BoxDecoration(
              color: status == 0
                  ? theme == 0
                      ? Colors.white
                      : context.watch<TemaApp>().getBackgroundColorUser
                  : theme == 0
                      ? Colors.white
                      : context.watch<TemaApp>().getBackgroundColorFree,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.settings, size: 25, color: textColor),
                  title: Text(
                    'Configurações',
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: textColor,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.configs);
                  },
                ),
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   leading: Icon(Icons.history, size: 25, color: textColor),
                //   title: Text(
                //     'Histórico de transações',
                //     style: TextStyle(fontSize: 16, color: textColor),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios,
                //     color: textColor,
                //   ),
                //   onTap: () {
                //     Navigator.of(context).pushNamed(AppRoutes.configs);
                //   },
                // ),
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   leading: Icon(Icons.archive, size: 25, color: textColor),
                //   title: Text(
                //     'Projetos',
                //     style: TextStyle(fontSize: 16, color: textColor),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios,
                //     color: textColor,
                //   ),
                //   onTap: () {
                //     Navigator.of(context).pushNamed(AppRoutes.configs);
                //   },
                // ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.work, size: 25, color: textColor),
                  title: Text(
                    'Anúncios',
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: textColor,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.todosMeusAnuncios);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 260,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(textColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: textColor),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
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
