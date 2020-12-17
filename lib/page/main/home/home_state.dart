part of 'home_bloc.dart';

@immutable
// ignore: must_be_immutable
abstract class HomeState extends StateBase{
 HomeState clone({List<BannerModel> newList});
}

// ignore: must_be_immutable
class HomeInitial extends HomeState{
  final List<BannerModel> listBanner;

  HomeInitial({this.listBanner});

  @override
  HomeState clone({List<BannerModel> newList}){
    return HomeInitial(listBanner: newList??this.listBanner)..httpShow=httpShow;
  }
}
