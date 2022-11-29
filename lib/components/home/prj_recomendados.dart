import 'package:bicos_app/components/home/constants.dart';
import 'package:flutter/material.dart';

import '../../utils/app_routes.dart';

class PrjRecomendados extends StatelessWidget {
  final int index;

  const PrjRecomendados({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          RecomendPlantCard(
            image:
                index == 1 ? "assets/images/web.jpg" : "assets/images/web2.png",
            title: index == 1 ? "Roberto" : 'Ricardo',
            country: "Web",
            price: index == 1 ? 110 : 150,
            press: () {
              //Navigator.push(
              //context,
              //MaterialPageRoute(
              //builder: (context) => DetailsScreen(),
              // ),
              //);
            },
          ),
          RecomendPlantCard(
            image: index == 1
                ? "assets/images/celulinhos.jpg"
                : "assets/images/celulinhos2.png",
            title: index == 1 ? "Carlos" : 'Richarlison',
            country: "Mobile",
            price: index == 1 ? 220 : 170,
            press: () {
              // Navigator.push(
              //context,
              // MaterialPageRoute(
              // builder: (context) => DetailsScreen(),
              //),
              //);
            },
          ),
          RecomendPlantCard(
            image: index == 1
                ? "assets/images/design.jpg"
                : "assets/images/design2.png",
            title: index == 1 ? "Ogaua" : 'Jefferson',
            country: "Design",
            price: index == 1 ? 50 : 70,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          GestureDetector(
            onTap: press(),
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
