import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/profile/presentation/getx/profile_page_controller.dart';
import 'package:party_app/features/profile/presentation/widgets/profile_image_widget.dart';
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
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    Spacing.hb,
                    ProfileImageWidget(
                      image: _controller.profile!.images!.first,
                      name: _controller.profile!.name,
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
                      fn: () {
                        Get.toNamed(RouteNames.EDIT_PROFILE,
                            arguments: _controller.profile!);
                      },
                      pattern: GradientPatterns.blue,
                      height: 50,
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

class EDIT_PROFILE {}
