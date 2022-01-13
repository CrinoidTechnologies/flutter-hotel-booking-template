import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/generated/l10n.dart';
import '../../../../app/ui/appTheme.dart';
import '../../../hotel/domain/entities/hotel_entity.dart';
import '../widgets/search_types_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List<HotelEntity> lastsSearchesList = HotelEntity.lastsSearchesList;

  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: appBar(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getTheme().backgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(38)),
                              // border: Border.all(
                              //   color: HexColor("#757575").withOpacity(0.6),
                              // ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppTheme.getTheme().dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                height: 48,
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.search,
                                        size: 18,
                                        color: AppTheme.getTheme().primaryColor,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          maxLines: 1,
                                          onTap: () {},
                                          onChanged: (String txt) {},
                                          style: TextStyle(
                                            fontSize: 16,
                                            // color: AppTheme.dark_grey,
                                          ),
                                          cursorColor: AppTheme.getTheme().primaryColor,
                                          decoration: new InputDecoration(
                                            errorText: null,
                                            border: InputBorder.none,
                                            hintText: S.of(context).whereAreYouGoing,
                                            hintStyle: TextStyle(color: AppTheme.getTheme().disabledColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SearchTypes(),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  S.of(context).lastSearches,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        S.of(context).clearAll,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: AppTheme.getTheme().primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ] +
                      getPList() +
                      [
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 16,
                        )
                      ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getPList() {
    List<Widget> noList = [];
    var cout = 0;
    final columCount = 2;
    for (var i = 0; i < lastsSearchesList.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final date = lastsSearchesList[cout];
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController!,
              curve: Interval((1 / lastsSearchesList.length) * cout, 1.0, curve: Curves.fastOutSlowIn),
            ),
          );
          animationController!.forward();
          listUI.add(Expanded(
            child: SerchView(
              hotelInfo: date,
              animation: animation,
              animationController: animationController,
            ),
          ));
          cout += 1;
        } catch (e) {
          print(e);
        }
      }
      noList.add(
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: listUI,
          ),
        ),
      );
    }
    return noList;
  }

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24),
          child: Text(
            S.of(context).search,
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class SerchView extends StatelessWidget {
  final HotelEntity? hotelInfo;
  final AnimationController? animationController;
  final Animation? animation;

  const SerchView({Key? key, this.hotelInfo, this.animationController, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.getTheme().backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.getTheme().dividerColor,
                        blurRadius: 16,
                        offset: Offset(8, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: Image.asset(
                            hotelInfo!.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  hotelInfo!.titleTxt,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  hotelInfo!.subTxt,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 12,
                                    color: AppTheme.getTheme().disabledColor.withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  hotelInfo!.dateTxt,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 12,
                                    color: AppTheme.getTheme().disabledColor.withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
