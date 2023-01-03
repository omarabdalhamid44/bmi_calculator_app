part of 'bmi_cubit.dart';

abstract class BmiState {}

class BmiInitial extends BmiState {}

class BmiLoading extends BmiState{}

class ListState extends BmiState{
  List<DataBaseModel> list;

  ListState(this.list);
}

class CreateState extends BmiState{}

class DeleteState extends BmiState{}
class AgeState extends BmiState{

}
class GenderState extends BmiState{}
class HeightState extends BmiState{}
class WeightState extends BmiState{}
