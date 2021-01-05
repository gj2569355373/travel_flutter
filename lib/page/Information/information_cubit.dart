import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:travel_flutter/page/base/blocBase.dart';
import 'package:travel_flutter/page/base/stateBase.dart';

part 'information_state.dart';

class InformationCubit extends BaseCubit {
  String nickName;
  String sex;
  String imageUrl;
  String birthday;
  File imageFile;
  InformationInitial informationInitial;
  final picker = ImagePicker();

  InformationCubit() : super(InformationInitial(MyInformationModel()));

  void init() {
    emit(HttpState(true));

    request.getMyInformationModel().then((value) {
      emit(InformationInitial(value));
      emit(HttpState(false));
    }, onError: (Object err, StackTrace stackTrace) {
      emit(HttpState(false));
      showToast(err);
    });
  }

  void changNickName(String text) {
    nickName = text;
  }

  void changSex(String text) {
    sex = text;
  }

  void changBirthday(String text) {
    birthday = text;
  }

  @override
  void onLoading() {
    // TODO: implement onLoading
  }

  @override
  void onChange(Change<StateBase> change) {
    if (change.nextState is InformationInitial)
      informationInitial = change.nextState;
    super.onChange(change);
  }

  void getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    emit(informationInitial
      ..imageFile = File(pickedFile.path)
      ..model.imageUrl = pickedFile.path);
  }

  @override
  void onRefresh() {
    // TODO: implement onRefresh
  }
}
