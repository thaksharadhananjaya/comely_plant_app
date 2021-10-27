part of 'plant_bloc.dart';

@immutable
abstract class PlantState {}

class PlantInitial extends PlantState {}

class LoadedPlant extends PlantState{
  final List<Plant> plantList;
  LoadedPlant({this.plantList});
  List<Object> get props => [this.plantList];
}


class PlantErrorState extends PlantState{
  final String message;
  PlantErrorState({this.message});
  List<Object> get props => [this.message];
}
