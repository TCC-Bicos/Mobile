import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final VoidCallback onDeleted;
  final bool isEdit;

  int hasImage = 0;

  EditProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
          Positioned(
            bottom: 0,
            left: 4,
            child: buildDeleteIcon(Colors.red),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    imagePath.isEmpty ? hasImage = 0 : hasImage = 1;
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));
    final img = Image.asset('assets/images/standardProfilePic.png');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: img.image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );

    // return hasImage == 0
    //     ? ClipOval(
    //         child: Material(
    //           color: Colors.transparent,
    //           child: Ink.image(
    //             image: img.image,
    //             fit: BoxFit.cover,
    //             width: 128,
    //             height: 128,
    //             child: InkWell(onTap: onClicked),
    //           ),
    //         ),
    //       )
    //     : ClipOval(
    //         child: Material(
    //           color: Colors.transparent,
    //           child: Ink.image(
    //             image: image as ImageProvider,
    //             fit: BoxFit.cover,
    //             width: 128,
    //             height: 128,
    //             child: InkWell(onTap: onClicked),
    //           ),
    //         ),
    //       );
  }

  buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 1,
        child: buildCircle(
          color: color,
          all: 0,
          child: IconButton(
            icon: Icon(
              isEdit ? Icons.add_a_photo : Icons.edit,
              color: Colors.white,
            ),
            iconSize: 17,
            onPressed: onClicked,
          ),
        ),
      );
  buildDeleteIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 1,
        child: buildCircle(
          color: color,
          all: 0,
          child: IconButton(
            icon: Icon(
              Icons.delete,
              color: hasImage == 0 ? Colors.white24 : Colors.white,
            ),
            iconSize: 17,
            onPressed: hasImage == 0 ? null : onDeleted,
          ),
        ),
      );

  buildCircle({
    required Color color,
    required double all,
    required Widget child,
  }) =>
      ClipOval(
        child: Container(
          width: 35,
          height: 35,
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
