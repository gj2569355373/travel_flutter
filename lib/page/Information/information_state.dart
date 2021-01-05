part of 'information_cubit.dart';

class MyInformationModel{
  String userName;
  String imageUrl;
  String sex;
  String birthday;


  MyInformationModel({this.userName="", this.sex="", this.birthday="", this.imageUrl=""});

  MyInformationModel.fromJson(Map<String, dynamic> json):
        userName=json['userName'],sex=json['sex'],imageUrl=json['imageUrl'],birthday=json['birthday'];

  Map<String, dynamic> toJson() =>
      {
        'birthday':birthday,
        'userName': userName,
        'sex': sex,
        'imageUrl':imageUrl,
      };
}

class InformationInitial extends StateBase {
  File imageFile;
 final MyInformationModel model;
 InformationInitial(this.model);
  InformationInitial clone(){
    return InformationInitial(this.model)..imageFile=imageFile;
  }
}
