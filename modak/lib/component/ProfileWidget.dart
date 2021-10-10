import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak/bloc/UserBloc.dart';
import 'package:modak/bloc/UserEvent.dart';
import 'package:modak/dto/User.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: ProfileWidget(
          user: User(userid: "ysy3350", level: 1),
        ),
      ),
    ),
  ));
}

class ProfileWidget extends StatefulWidget {
  User? user;

  ProfileWidget({this.user});

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      height: 220,
      child: Stack(
        children: [
          Positioned(
            left: 20.0,
            right: 20.0,
            top: 48.0,
            bottom: 48.0,
            child: Container(
              padding: EdgeInsets.only(
                  left: (_width-10) * 40 / 100, right: 5.0, top: 5.0, bottom: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: widget.user != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.logout,
                              size: 18,
                            ),
                          ),
                          onTap: () {
                            BlocProvider.of<UserBloc>(context).add(
                              LogoutUserEvent(),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.user != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              width: (_width-10) * 40 / 100,
                              child: AutoSizeText(
                                (widget.user != null
                                    ? (widget.user!.userid)
                                    : ""),
                                style: const TextStyle(fontSize: 40.0, ),
                                minFontSize: 12.0,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              width: (_width-10) * 15 / 100,
                              child: AutoSizeText(
                                'Lv. ${widget.user != null ? widget.user!.level.toString() : "0"}',
                                style: const TextStyle(
                                    fontSize: 18.0, color: Color(0xff87360C)),
                                minFontSize: 12.0,
                                maxLines: 1,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.user == null,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 32.0,
                        ),
                        Container(
                          width: 120.0,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "로그인",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                return Color(0xff87360C);
                              }),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                return Colors.white;
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0x2087360C),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            top: 30.0,
            bottom: 30.0,
            child: Container(
              width: (_width-10) * 40 / 100,
              height: (_width-10) * 40 / 100,
              child: Icon(
                Icons.person_outline,
                size: 64,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x55efefef),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 10.0,
                      spreadRadius: 5.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
