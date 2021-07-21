import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/profile/presentation/getx/profile_page_controller.dart';
import 'package:party_app/global/extensions/string_initials.dart';
import 'package:party_app/global/routes/route_names.dart';
import 'package:party_app/global/widgets/bottom_menu.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';

class ProfilePage extends StatelessWidget {
  final _controller = Get.put(ProfilePageController());

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool?>(
        stream: _controller.loading.stream,
        initialData: _controller.loading.value,
        builder: (_, loading) {
          if (loading.data!)
            return Center(
              child: CircularProgressIndicator(),
            );

          return SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Spacing.hb,
                    if (_controller.profile!.images == null ||
                        _controller.profile!.images!.isEmpty)
                      Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          color: Color(0xFF111111),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                            child: Text(
                          _controller.profile!.name != null
                              ? _controller.profile!.name!.initials()
                              : "",
                          style: Get.textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                        )),
                      )
                    else
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            _controller.profile!.images!.first.url),
                        radius: 64,
                      ),
                    Spacing.hb,
                    Text(
                      _controller.profile!.name ?? "Não informado",
                      style: Get.textTheme.headline6,
                    ),
                    Text(
                      _controller.profile!.thought ?? "",
                      style: Get.textTheme.headline3,
                    ),
                    Spacing.hb,
                    GradientButton(
                      text: "EDITAR INFORMAÇÕES",
                      fn: () {},
                      pattern: GradientPatterns.blue,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomMenu(route: RouteNames.PROFILE),
    );
  }
}
