part of 'plant_bloc.dart';

@immutable
abstract class PlantEvent {}

class FetchPlant extends PlantEvent{
  FetchPlant();
}

class ReloadPlant extends PlantEvent{
  ReloadPlant();
}
