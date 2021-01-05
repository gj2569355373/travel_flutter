/*
 * create by gj
 * Created in 2020/12/29 10:24 上午
 * description: 
 * */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_flutter/models/constant.dart';
import 'package:travel_flutter/page/Information/information_cubit.dart';
import 'package:travel_flutter/page/base/stateBase.dart';
import 'package:travel_flutter/res/styles.dart';
import 'package:travel_flutter/view/list_row_lable_input.dart';

class MyInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) => InformationCubit()..init(), child: Scaffold(
      appBar: AppBar(
        title: new Text(Translations.of(context).text(Constant.information)),
      ),
      body:MyInformationWidget(),
    ));
  }
}
class MyInformationWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(padding: EdgeInsets.all(0.0),
    children: [
      Container(padding:EdgeInsets.only(bottom: 20,top: 10),color: Colors.white,margin:EdgeInsets.only(top: 16,bottom: 10),child: _head(context),),

      BlocBuilder<InformationCubit,StateBase>( buildWhen: (previousState, currentState) =>currentState is InformationInitial,builder: (context,state){
        if(state is InformationInitial)
          return RowLableInput(Translations.of(context).text("nickName"),Translations.of(context).text("nickName")
            ,Icons.person,(value)=>BlocProvider.of<InformationCubit>(context).changNickName(value),nameText: state.model.userName,kPrimaryColor: Theme.of(context).accentColor,);
        return Container(
          height: 0.0,
        );
      }),

    ],);
  }
  Widget _head(BuildContext context) {
    return BlocBuilder<InformationCubit,StateBase>( buildWhen: (previousState, currentState) =>currentState is InformationInitial,builder: (context,state){
      if(state is InformationInitial&& state.model.imageUrl!="")
        {
          if (state.model.imageUrl.startsWith('http'))
            return InkWell(
              onTap: ()=>BlocProvider.of<InformationCubit>(context).getImage(),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(state.model.imageUrl),
                  radius: 45.0,
                ),
              ),
            );
          else
            return InkWell(
              onTap: ()=>BlocProvider.of<InformationCubit>(context).getImage(),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: FileImage(state.imageFile),
                  radius: 45.0,
                ),
              ),
            );
        }
      return Container(
        height: 0.0,
      );
    });
  }
}