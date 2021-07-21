import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:party_app/global/routes/route_names.dart';
import 'package:party_app/global/widgets/bottom_menu.dart';
import 'package:party_app/global/widgets/spacing.dart';

class HomePage extends StatelessWidget {
  final double cardWidth = Get.width - (Spacing.big * 2);
  final double thinCardWidth = (Get.width - Spacing.bigger) / 2;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Spacing.normal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing.hn,
              Text("Descubra", style: Get.textTheme.headline6),
              Spacing.hb,
              Text(
                "EM ALTA",
                style: Get.textTheme.headline3,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    highlight(),
                    highlight(),
                    highlight(),
                    highlight(),
                    highlight(),
                  ],
                ),
              ),
              Spacing.hbg,
              Text(
                "NA PISTA",
                style: Get.textTheme.headline3,
              ),
              Spacing.htr,
              StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                crossAxisCount: 4,
                itemCount: 10,
                crossAxisSpacing: Spacing.tinier,
                mainAxisSpacing: Spacing.tinier,
                itemBuilder: (_, __) {
                  return thinCard("banner.jpg");
                },
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index.isEven ? 3 : 2),
              )
              //         (
              //   shrinkWrap: true,
              //   gridDelegate:
              //       SliverStaggeredGridDelegateWithFixedCrossAxisCount(
              //     staggeredTileBuilder: (int index) =>
              //         new StaggeredTile.count(2, index.isEven ? 2 : 1),
              //     crossAxisCount: 2,
              //   ),
              //   children: [
              //     thinCard("banner.jpg"),
              //     thinCard("bg.jpeg"),
              //     thinCard("banner.jpg"),
              //     thinCard("bg.jpeg")
              //   ],
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(route: RouteNames.HOME),
    );
  }

  Container thinCard(String img) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/$img"),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text("Teste teste teste"),
      ),
    );
  }

  Container highlight() {
    return Container(
      width: cardWidth,
      margin: EdgeInsets.only(right: Spacing.normal),
      child: Column(
        children: [
          Image(
            image: AssetImage("assets/images/banner.jpg"),
            fit: BoxFit.fitWidth,
          ),
          Spacing.htr,
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Festa na Esquina",
                    style: Get.textTheme.headline2!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "De Fernando Éricles",
                    style: Get.textTheme.headline1!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.person),
              Text("2000"),
            ],
          ),
        ],
      ),
    );
  }
}
