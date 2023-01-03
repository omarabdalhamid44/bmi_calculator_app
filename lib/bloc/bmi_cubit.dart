import 'package:bmi_calculater/contoller_db/db_controller.dart';
import 'package:bmi_calculater/model/model_database.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(BmiInitial());

  static BmiCubit get(context) =>  BlocProvider.of<BmiCubit>(context);

  List<DataBaseModel> listRead =[];
  DbController databaseBMI = DbController();
  int age= 0;
  int height = 120;
  int weight = 50;
  String genderSelected = '';


  void changeGender(String gender){
    genderSelected = gender;
    emit(GenderState());
  }
  void changeAge(String AddOrMin){
    if(AddOrMin == '+'){
      age++;
      emit(AgeState());
    }else{
      if(age>0){
        age--;
        emit(AgeState());
      }
    }
  }
  void changeHeight(int sliderHeight){
    height = sliderHeight;
    emit(HeightState());
  }
  void changeWeight(String AddOrMin){
    if(AddOrMin == '+'){
      weight++;
      emit(WeightState());
    }else{
      if(weight>10){
        weight--;
        emit(WeightState());
      }
    }
  }


  Future<int> create(DataBaseModel dataBaseModel)async{
   int created = await databaseBMI.create(dataBaseModel);
   if(created != 0 ){
     dataBaseModel.id =created;
     listRead.add(dataBaseModel);
   }
    emit(CreateState());
   emit(ListState(listRead));
    return created;
  }
  void read() async{
    emit(BmiLoading());
    listRead =await databaseBMI.read();
    emit(ListState(listRead));
  }
  void delete(int index) async{
    bool deleted = await databaseBMI.delete(listRead.elementAt(index).id);
    if(deleted){
      listRead.removeAt(index);
      emit(ListState(listRead));
    }
    emit(DeleteState());
  }

 }
