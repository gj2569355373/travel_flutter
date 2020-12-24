part of 'my_bloc.dart';

@immutable
// ignore: must_be_immutable
abstract class MyState extends StateBase {}

// ignore: must_be_immutable
class MyInitial extends MyState {
  final MyBin myBin;

  MyInitial(this.myBin);

}



class MyBin{
  String name;
  String department;
  String imageUrl;
  MyBin(this.name, this.department, this.imageUrl);
}