
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak/bloc/CampingAPIEvent.dart';
import 'package:modak/bloc/CampingAPIState.dart';
import 'package:modak/repository/APIRepository.dart';

class CampingAPIBloc extends Bloc<CampingAPIEvent, CampingAPIState> {
  final APIRepository apiRepository;

  CampingAPIBloc({required this.apiRepository}): super(Empty());

  @override
  Stream<CampingAPIState> mapEventToState(CampingAPIEvent event) async*{
    if (event is GetCampingsEvent) {
      yield* _mapGetCampingsEvent(event);
    } else if(event is GetCampingsEnvironmentsEvent) {
      yield* _mapGetCampingsEnvironmentsEvent(event);
    } else if(event is GetCampingsOperationTypesEvent) {
      yield* _mapGetCampingsOperationTypesEvent(event);
    } else if(event is GetCampingsRegionsEvent) {
      yield* _mapGetCampingsRegionsEvent(event);
    } else if(event is GetCampingsFilterDataEvent) {
      yield* _mapGetCampingsFilterDataEvent(event);
    }
  }

  Stream<CampingAPIState> _mapGetCampingsEvent(GetCampingsEvent event) async* {
    print("_mapGetCampingsEvent");
    yield Loading();

    var response = await apiRepository.getCampings().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    if (response != null) {
      print("response: ${response.content[1].name}");
      yield Loaded();
    }else {
      print("error");
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetCampingsFilterDataEvent(GetCampingsFilterDataEvent event) async* {
    print("_mapGetCampingsFilterDataEvent");
    yield Loading();

    var response1 = await apiRepository.getCampingsEnvironments().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    var response2 = await apiRepository.getCampingsOperationTypes().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    var response3 = await apiRepository.getCampingsRegions().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    if (response1 != null && response2 != null && response3 != null) {
      print("response: ${response1.data} ${response2.data} ${response3.data}");
      yield Loaded(dataEnvironments:response1.data, dataOperationTypes: response2.data, dataRegions: response3.data);
    }else {
      print("error");
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetCampingsEnvironmentsEvent(GetCampingsEnvironmentsEvent event) async* {
    print("_mapGetCampingsEnvironmentsEvent");
    yield Loading();

    var response = await apiRepository.getCampingsEnvironments().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    if (response != null) {
      print("response: ${response.data}");
      yield Loaded(dataEnvironments:response.data);
    }else {
      print("error");
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetCampingsOperationTypesEvent(GetCampingsOperationTypesEvent event) async* {
    print("_mapGetCampingsOperationTypesEvent");
    yield Loading();

    var response = await apiRepository.getCampingsOperationTypes().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    if (response != null) {
      print("response: ${response.data}");
      yield Loaded(dataOperationTypes:response.data);
    }else {
      print("error");
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetCampingsRegionsEvent(GetCampingsRegionsEvent event) async* {
    print("_mapGetCampingsRegionsEvent");
    yield Loading();

    var response = await apiRepository.getCampingsRegions().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    if (response != null) {
      print("response: ${response.data}");
      yield Loaded(dataRegions:response.data);
    }else {
      print("error");
      yield Error();
    }
  }
}