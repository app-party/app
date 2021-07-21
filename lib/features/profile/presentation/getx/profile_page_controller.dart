import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:party_app/features/profile/adapters/profile_repository_adapter.dart';
import 'package:party_app/features/profile/domain/entities/profile.dart';
import 'package:party_app/features/profile/usecases/get_current_user_profile.dart';
import 'package:party_app/global/usecase/usecase.dart';
import 'package:party_app/global/utils/listfy.dart';
import 'package:party_app/global/widgets/dialog_library.dart';

class ProfilePageController extends GetxController with Listfy {
  final GetCurrentUserProfile _getCurrentUserProfile =
      GetCurrentUserProfile(ProfileRepositoryAdapter());

  Profile? profile;

  RxBool loading = true.obs;

  ProfilePageController() {
    init();
  }

  init() async {
    loading.value = true;

    final response = await _getCurrentUserProfile(NoParams());

    if (response.isLeft()) {
      Get.back();
      DialogLibrary.error(toList((response as Left).value.message));
      return;
    }

    profile = (response as Right).value;

    loading.value = false;
  }
}
