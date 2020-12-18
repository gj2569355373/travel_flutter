part of 'home_bloc.dart';


class HomeInitial extends StateBase{
  final List<BannerModel> listBanner;

  HomeInitial({this.listBanner});

  StateBase clone({List<BannerModel> newList}){
    return HomeInitial(listBanner: newList??this.listBanner);
  }
}

class HomeTypeItem extends  StateBase{
  final List<TypeItem> list;

  HomeTypeItem(this.list);

}
class HomeLabelPanel extends  StateBase{
  final String dropDownValue;
  HomeLabelPanel(this.dropDownValue);
}
class HomePanel extends  StateBase{
  final List<PanelBin> list;
  HomePanel(this.list);
}
class HomeRowBin extends  StateBase{
  final List<ListRowBin> list;
  HomeRowBin(this.list);
}