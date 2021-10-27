import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/models/plantModel.dart';
import 'package:plant_app/respositories/plant_respo..dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  final bool isFeatued;
  final String search;
  PlantBloc(this.isFeatued, this.search) : super(PlantInitial());
  List<Plant> plantList = [];
  PlantRepo plantRepo = PlantRepo();
  int page = -5;
  bool isLoading = false;
  @override
  Stream<PlantState> mapEventToState(PlantEvent event) async* {
    if (event is FetchPlant) {
      if (!isLoading) {
        isLoading = true;
        page += 5;
        List<Plant> list = await plantRepo.getPlant(isFeatued, page, search);
        try {
          if (list == null) {
            if (plantList.length > 0) {
              page -= 5;
              yield LoadedPlant(plantList: plantList);
            } else {
              yield search!=null? PlantErrorState(message: "Search result not found !"): PlantErrorState(message: "Not found plant");
            }
          } else {
            plantList.addAll(list);
            yield LoadedPlant(plantList: plantList);
          }
        } catch (e) {
          page -= 5;
          yield PlantErrorState(message: "Error !");
        }
        isLoading = false;
      }
    } else if (event is ReloadPlant) {
      yield null;
      print("objectrrr");
      plantList.clear();
      List<Plant> list = await plantRepo.getPlant(isFeatued, 0, search);
      try {
        if (list == null) {
          yield PlantErrorState(message: "Empty");
        } else {
          plantList.addAll(list);
          yield LoadedPlant(plantList: plantList);
        }
      } catch (e) {
        yield PlantErrorState(message: "Error !");
      }
    }
  }
}
