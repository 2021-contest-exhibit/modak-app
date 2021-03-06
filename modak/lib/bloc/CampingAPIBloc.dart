
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak/bloc/CampingAPIEvent.dart';
import 'package:modak/bloc/CampingAPIState.dart';
import 'package:modak/repository/APIRepository.dart';
import 'package:modak/repository/UserRepository.dart';
import 'package:modak/rest/Content.dart';
import 'package:modak/rest/ResponseGetCampings.dart';
import 'package:modak/rest/ResponseGetUser.dart';

class CampingAPIBloc extends Bloc<CampingAPIEvent, CampingAPIState> {
  final APIRepository apiRepository;
  final UserRepository userRepository;

  CampingAPIBloc({required this.apiRepository, required this.userRepository}): super(Empty());

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
    } else if(event is GetTodayCampingsEvent) {
      yield* _mapGetTodayCampingsEvent(event);
    } else if (event is GetUserGoodsEvent) {
      yield* _mapGetUserGoodsEvent(event);
    } else if (event is GetCampingGoodsEvent) {
      yield* _mapGetCampingGoodsEvent(event);
    } else if (event is GetCampingEvent) {
      yield* _mapGetCampingEvent(event);
    } else if (event is DeleteCampingGoodsEvent) {
      yield* _mapDeleteCampingGoodEvent(event);
    } else if (event is FindCampinsEvent) {
      yield* _mapFindCampingsEvent(event);
    } else if (event is GetAICampingsEvent) {
      yield* _mapGetAICampingsEvent(event);
    }
  }

  Stream<CampingAPIState> _mapFindCampingsEvent(FindCampinsEvent event) async* {
    print("_mapfindCampingsEvent");
    yield SearchLoading();


    List<String> operationTypeEqual = [];
    List<String> regionContains = [];
    List<String> environmentEqual = [];
    List<String> facilityEqual = [];

    event.regionMap.keys.forEach((element) { regionContains.add(element); });
    event.environmentMap.keys.forEach((element) { environmentEqual.add(element); });
    event.operationTypeMap.keys.forEach((element) { operationTypeEqual.add(element);});
    event.facilityMap.keys.forEach((element) { facilityEqual.add(element); });

    var response = await apiRepository.findCampingsByList(nameContains: event.nameContains, operationTypeEqual: operationTypeEqual, regionContains: regionContains, environmentEqual: environmentEqual, facilityEqual: facilityEqual).onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    if (response != null) {
      print("response: ${response.content}");

      yield CampingsLoaded(content: response.content);
    }else {
      print("error");
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetCampingsEvent(GetCampingsEvent event) async* {
    print("_mapGetCampingsEvent");
    yield SearchLoading();


    String region = "";
    String environment = "";
    String operationType = "";

    event.regionMap.keys.forEach((element) { region = element as String; });
    event.environmentMap.keys.forEach((element) { environment = element as String; });
    event.operationTypeMap.keys.forEach((element) { operationType = element as String;});


    var response = await apiRepository.getCampings(nameContains: event.nameContains, regionContains: region, environmentName: environment, operationType: operationType).onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return null;
    });

    if (response != null) {
      print("response: ${response.content}");

      yield CampingsLoaded(content: response.content);
    }else {
      print("error");
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetCampingsFilterDataEvent(GetCampingsFilterDataEvent event) async* {
    print("_mapGetCampingsFilterDataEvent");
    yield CampingSearchLoading();

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

    var response4 = await apiRepository.getCampingsFacilities().onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    });

    if (response1 != null && response2 != null && response3 != null && response4 != null) {
      print("response: ${response1.data} ${response2.data} ${response3.data} ${response4.data}");
      yield CampingSearchLoaded(dataEnvironments:response1.data, dataOperationTypes: response2.data, dataRegions: response3.data, dataFacilities: response4.data);
    } else {
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

  Stream<CampingAPIState> _mapGetTodayCampingsEvent(GetTodayCampingsEvent event) async* {
    yield Loading();
    var uid = userRepository.getUserToken();

    print('bloc: ${event.index}');

    var campings = await apiRepository.getTodayCampings(uid??"", event.index, 15);

    print('loaded');

    if (campings != null && campings.content.length > 0) {
      yield TodayCampingsLoaded(campings: campings.content);
    } else {
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetAICampingsEvent(GetAICampingsEvent event) async* {
    yield Loading();
    var uid = userRepository.getUserToken();


    var campings = await apiRepository.getRecommandAICampings(uid??"");

    print('loaded');

    if (campings != null && campings.content.length > 0) {
      yield AICampingsLoaded(campings: campings.content);
    } else {
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetRecommandCampingsEvent(GetTodayCampingsEvent event) async* {
    var uid = userRepository.getUserToken();

    if (uid != null) {
      var campings = await apiRepository.getTodayCampings(uid, 0, 5);

      if (campings != null && campings.content.length > 0) {
        yield TodayCampingsLoaded(campings: campings.content);
      }
    } else {
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetUserGoodsEvent(GetUserGoodsEvent event) async*{
    yield Loading();

    var uid = userRepository.getUserToken();

    if (uid != null) {
      var goods = await apiRepository.getUserFavorite(uid);
      print('goods: ${goods.content[0].goods[0].camping}');
      List<Good> campings = await Stream.fromIterable(goods.content[0].goods).asyncMap((e) async {
        var camping = await apiRepository.getCampings(contentId: e.camping.contentId);
        if (camping != null) {
          return Good(id: 0, camping: camping.content[0]);
        } else {
          return null;
        }
      }).where((event) => event != null).toList() as List<Good>;

      goods.content[0].goods = campings;

      yield UserGoodsLoaded(user: goods);
    } else {
      yield Error();
    }

  }

  Stream<CampingAPIState> _mapGetCampingGoodsEvent(GetCampingGoodsEvent event) async* {
    yield Loading();

    var uid = await userRepository.getUserToken();
    if (uid != null) {
      await apiRepository.getGoods(event.campingId, uid);
    } else {
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapGetCampingEvent(GetCampingEvent event) async* {
    yield Loading();

    var uid = userRepository.getUserToken();

    var camping = await apiRepository.getCampings(contentId: event.contentId, email: uid??"");
    print("good: ${camping!.content[0].isGoodByUser}");
    print("id: ${camping.content[0].contentId}");

    if (camping != null) {
      yield CampingLoaded(campings: camping.content);
    }else {
      yield Error();
    }
  }

  Stream<CampingAPIState> _mapDeleteCampingGoodEvent(DeleteCampingGoodsEvent event) async* {
    yield Loading();

    var uid = userRepository.getUserToken();

    if (uid != null) {
      var res = await apiRepository.deleteGoods(event.campingId, uid).onError((error, stackTrace) {
        return null;
      });

      if (res != null) {
        yield Error();
      }
    }
  }
}