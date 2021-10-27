import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak/bloc/ModakBloc.dart';
import 'package:modak/bloc/ModakEvent.dart';
import 'package:modak/bloc/ModakState.dart';
import 'package:modak/component/MatchingItemWidget.dart';
import 'package:modak/dto/ModakMatching.dart';

class MatchingPage extends StatefulWidget {
  int _selectedIndex = 0;

  @override
  MatchingPageState createState() => MatchingPageState();
}

class MatchingPageState extends State<MatchingPage> {
  List<ModakMatching> newModakMatchings = [];
  List<ModakMatching> joinModakMatchings = [];
  List<ModakMatching> myModakMatchings = [];
  bool newModakMatchingsLoading = false;
  bool joinModakMatchingLoading = false;
  bool myModakMatchingLoading = false;
  bool isNewModakMatchingEnd = false;
  bool isJoinModakMatchingEnd = false;
  bool isMyModakMatchingEnd = false;


  setIndex(int index) {
    setState(() {
      widget._selectedIndex = index;
      if (index == 0) {
        newModakMatchings = [];
        newModakMatchingsLoading = true;
        isNewModakMatchingEnd = false;
        BlocProvider.of<ModakBloc>(context).add(LoadMatchingEvent());
      } else if (index == 1) {
        print('index1');
        joinModakMatchings = [];
        joinModakMatchingLoading = true;
        isJoinModakMatchingEnd = false;
        BlocProvider.of<ModakBloc>(context).add(LoadJoinMatchingEvent());
      } else if (index == 2) {
        print('index2');
        myModakMatchings = [];
        myModakMatchingLoading = true;
        isMyModakMatchingEnd = false;
        BlocProvider.of<ModakBloc>(context).add(LoadMyMatchingEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _statusBarHeight = MediaQuery.of(context).padding.top;
    final double _height = MediaQuery.of(context).size.height;
    final double _titleHeight = 48.0;
    final double _contentHeight = _height - _statusBarHeight - 112 - 9;
    final double _contentWidth = _width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: _statusBarHeight),
            child: Column(
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                const SizedBox(
                  height: 9.0,
                ),
                const SizedBox(
                  height: 9.0,
                ),
                Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setIndex(0);
                        },
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: widget._selectedIndex == 0
                                ? FontWeight.bold
                                : null,
                            fontFamily: widget._selectedIndex == 0 ? 'NotoSansKR' : 'NotoSansKR'
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setIndex(1);
                        },
                        child: Text(
                          "JOINED",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: widget._selectedIndex == 1
                                ? FontWeight.bold
                                : null,
                            fontFamily: widget._selectedIndex == 1 ? 'NotoSansKR' : 'NotoSansKR'
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setIndex(2);
                        },
                        child: Text(
                          "MY",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: widget._selectedIndex == 2
                                ? FontWeight.bold
                                : null,
                            fontFamily: widget._selectedIndex == 2 ? 'NotoSansKR' : 'NotoSansKR'
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black,
                    height: 0.1,
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        Visibility(
                          visible: widget._selectedIndex == 0,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            height: _contentHeight,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification.metrics.maxScrollExtent < notification.metrics.pixels) {
                                  if (newModakMatchings.length > 0 && !newModakMatchingsLoading && !isNewModakMatchingEnd){
                                    newModakMatchingsLoading = true;
                                    BlocProvider.of<ModakBloc>(context).add(LoadMatchingEvent(lastDate: newModakMatchings[newModakMatchings.length - 1].matching!.createDate.toIso8601String()));
                                  }
                                }
                                return true;
                              },
                              child: BlocBuilder<ModakBloc, ModakState>(
                                builder: (_, state) {
                                  if (state is MatchingLoaded) {
                                    if (state.matchings!.length > 0){
                                      print('machings: ${state.matchings![0].matching!.createDate}');
                                      newModakMatchings.addAll(state.matchings!);
                                    } else {
                                      isNewModakMatchingEnd = true;
                                    }
                                    newModakMatchingsLoading = false;
                                    return ListView.builder(
                                      itemBuilder: (context, index) {
                                        return MatchingItemWidget(
                                          modakMatching: newModakMatchings[index],
                                        );
                                      },
                                      itemCount: newModakMatchings.length,
                                      physics: BouncingScrollPhysics(),
                                    );
                                  }
                                  return Container();
                                },
                                buildWhen: (previous, current) =>
                                current is MatchingLoaded,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget._selectedIndex == 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            height: _contentHeight,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification.metrics.maxScrollExtent < notification.metrics.pixels) {
                                  if (joinModakMatchings.length > 0 && !joinModakMatchingLoading && !isJoinModakMatchingEnd){
                                    joinModakMatchingLoading = true;
                                    BlocProvider.of<ModakBloc>(context).add(LoadJoinMatchingEvent(lastDate: joinModakMatchings[joinModakMatchings.length - 1].matching!.createDate.toIso8601String()));
                                  }
                                }
                                return true;
                              },
                              child: BlocBuilder<ModakBloc, ModakState>(
                                builder: (_, state) {
                                  if (state is JoinMatchingLoaded) {
                                    if (state.matchings!.length > 0){
                                      joinModakMatchings.addAll(state.matchings!);
                                    } else {
                                      isJoinModakMatchingEnd = true;
                                    }
                                    joinModakMatchingLoading = false;
                                    return ListView.builder(
                                      itemBuilder: (context, index) {
                                        return MatchingItemWidget(
                                          modakMatching: joinModakMatchings[index],
                                        );
                                      },
                                      itemCount: joinModakMatchings.length,
                                      physics: BouncingScrollPhysics(),
                                    );
                                  } else if (state is Error) {
                                    return Text(state.message);
                                  }
                                  return Container();
                                },
                                buildWhen: (previous, current) =>
                                current is JoinMatchingLoaded || current is Error,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget._selectedIndex == 2,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            height: _contentHeight,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification.metrics.maxScrollExtent < notification.metrics.pixels) {
                                  if (myModakMatchings.length > 0 && !myModakMatchingLoading && !isMyModakMatchingEnd){
                                    myModakMatchingLoading = true;
                                    BlocProvider.of<ModakBloc>(context).add(LoadMyMatchingEvent(lastDate: myModakMatchings[myModakMatchings.length - 1].matching!.createDate.toIso8601String()));
                                  }
                                }
                                return true;
                              },
                              child: BlocBuilder<ModakBloc, ModakState>(
                                builder: (_, state) {
                                  if (state is MyMatchingLoaded) {
                                    if (state.matchings!.length > 0){
                                      myModakMatchings.addAll(state.matchings!);
                                    } else {
                                      isJoinModakMatchingEnd = true;
                                    }
                                    myModakMatchingLoading = false;
                                    return ListView.builder(
                                      itemBuilder: (context, index) {
                                        return MatchingItemWidget(
                                          modakMatching: myModakMatchings[index],
                                        );
                                      },
                                      itemCount: myModakMatchings.length,
                                      physics: BouncingScrollPhysics(),
                                    );
                                  } else if (state is Error) {
                                    return Text(state.message);
                                  }
                                  return Container();
                                },
                                buildWhen: (previous, current) =>
                                current is MyMatchingLoaded,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<ModakBloc, ModakState>(
                      builder: (context, state) {
                        if (state is MatchingLoading) {
                          return Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Color(0x44888888),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 82.0,
            right: 24.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create_matching');
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    setIndex(0);
  }
}
