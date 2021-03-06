
import 'package:equatable/equatable.dart';

abstract class CampingAPIEvent extends Equatable{}

class FindCampinsEvent extends CampingAPIEvent {
  String nameContains;
  Map regionMap;
  Map operationTypeMap;
  Map environmentMap;
  Map facilityMap;

  FindCampinsEvent({required this.nameContains, required this.regionMap, required this.operationTypeMap, required this.environmentMap, required this.facilityMap});

  @override
  List<Object?> get props => [];
}

class GetCampingsEvent extends CampingAPIEvent {
  String nameContains;
  Map regionMap;
  Map operationTypeMap;
  Map environmentMap;

  GetCampingsEvent({required this.nameContains, required this.regionMap, required this.operationTypeMap, required this.environmentMap});

  @override
  List<Object?> get props => [];
}

class GetCampingEvent extends CampingAPIEvent {
  final int contentId;

  GetCampingEvent({required this.contentId});

  @override
  List<Object?> get props => [];
}

class GetCampingsEnvironmentsEvent extends CampingAPIEvent {
  @override
  List<Object?> get props => [];
}

class GetCampingsOperationTypesEvent extends CampingAPIEvent {
  @override
  List<Object?> get props => [];
}

class GetCampingsRegionsEvent extends CampingAPIEvent {
  @override
  List<Object?> get props => [];
}

class GetCampingsFilterDataEvent extends CampingAPIEvent {
  @override
  List<Object?> get props => [];
}

class GetTodayCampingsEvent extends CampingAPIEvent {
  final int index;

  GetTodayCampingsEvent({required this.index});

  @override
  List<Object?> get props => [];
}

class GetAICampingsEvent extends CampingAPIEvent {

  @override
  List<Object?> get props => [];
}

class GetUserGoodsEvent extends CampingAPIEvent {
  @override
  List<Object?> get props => [];
}

class GetCampingGoodsEvent extends CampingAPIEvent {
  final int campingId;

  GetCampingGoodsEvent({required this.campingId});

  @override
  List<Object?> get props => [];

}

class DeleteCampingGoodsEvent extends CampingAPIEvent {
  final int campingId;

  DeleteCampingGoodsEvent({required this.campingId});

  @override
  List<Object?> get props => [];

}