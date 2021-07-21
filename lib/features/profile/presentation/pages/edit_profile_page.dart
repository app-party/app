import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/profile/presentation/getx/edit_profile_controller.dart';
import 'package:party_app/features/profile/presentation/widgets/profile_image_widget.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';

class EditProfilePage extends StatelessWidget {
  final _controller = Get.put(EditProfileController());

  EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            children: [
              Spacing.hb,
              ProfileImageWidget(
                image: _controller.profile.images!.first,
                name: _controller.profile.name,
              ),
              Spacing.hb,
              TextFormField(
                controller: _controller.nameController,
                decoration: InputDecoration(
                  hintText: "Nome",
                ),
              ),
              Spacing.hb,
              TextFormField(
                controller: _controller.thoughtController,
                decoration: InputDecoration(
                  hintText: "Pensamento",
                ),
              ),
              Spacing.hb,
              GradientButton(
                text: "SALVAR",
                fn: _controller.updateProfile,
                pattern: GradientPatterns.blue,
                height: 50,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
