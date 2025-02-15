import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project_book_app/logic/tech_mobile.dart';
import 'package:graduation_project_book_app/models/vdp.dart';
import 'package:graduation_project_book_app/screens/fliter/fliter_screen.dart';
import 'package:graduation_project_book_app/screens/navigation_screen.dart';
import 'package:graduation_project_book_app/screens/search/item_card.dart';
import 'package:graduation_project_book_app/screens/vdp/vdp_Screen.dart';
import 'package:graduation_project_book_app/widgets/google_map.dart';
import 'package:graduation_project_book_app/widgets/search_inbox.dart';

class SearchScreen extends StatefulWidget {
  final LatLng searchLocation;

  const SearchScreen({Key key, this.searchLocation}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShow = false;

  bool isCheckEntireRoom = false;
  List<Coordinates> coordinators = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //getCurrentLocation(context);
      getListSave(context);
    });
  }

  void getListSave(BuildContext context) {
    print('chay lai khong');
    var techMobile = TechMobile.of(context);
    var result;
    // if (techMobile.listSaveUser?.length ?? 0 == 0) {
    result = techMobile.getListSave();
    // }
    if (result != null) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      //statusBarBrightness: Brightness.dark,
    ));
    var techMobile = TechMobile.of(context);

    return techMobile.vdpList == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: Stack(
              children: [
                GestureDetector(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child: MapScreen(
                          item: techMobile.vdpList,
                          location: widget.searchLocation)),
                ),
                Container(
                  // cái mới làm nè
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  alignment: isShow ? Alignment.topCenter : Alignment.center,
                  height: isShow ? 100 : 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 3,
                        offset: Offset(1, 0),
                      ),
                    ],
                  ),
                  child: isShow
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isShow ? isShow = false : isShow = true;
                                      });
                                    },
                                    child: Icon(Icons.close)),
                                Text(
                                  'Ho chi minh',
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 600,
                                            color: Colors.amber,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Text(
                                                      'Modal BottomSheet'),
                                                  ElevatedButton(
                                                    child: const Text(
                                                        'Close BottomSheet'),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(Icons.tune))
                              ],
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchInbox()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 10, left: 10),
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.4))),
                                child: Row(
                                  children: [
                                    Icon(Icons.search),
                                    Text(
                                      "Khu vực ${techMobile.searchRoomLocation}",
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShow ? isShow = false : isShow = true;
                                });
                              },
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return NavigationScreen();
                                        }));
                                      },
                                      child: Icon(Icons.arrow_back)),
                                  Text(
                                   "Khu vực ${techMobile.searchRoomLocation}",
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FliterScreen();
                                  }));
                                },
                                child: Icon(Icons.tune))
                          ],
                        ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: DraggableScrollableSheet(
                      //bottomsheet
                      maxChildSize: 1,
                      minChildSize: 0.1,
                      initialChildSize: .5,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: techMobile.vdpList?.length != 0
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Container(
                                          height: 3,
                                          width: 30,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                          '${techMobile?.vdpList?.length} places to stay',
                                          style: TextStyle(fontSize: 15)),
                                      Expanded(
                                        child: ListView.builder(
                                          controller: scrollController,
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              techMobile.vdpList?.length ?? 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            //print(state.vdpItem[index].type);
                                            return FlatButton(
                                              onPressed: () async {
                                                List<VdpItem> s =
                                                    await techMobile
                                                        .getListSave();
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return VdpScreens(
                                                    listSave: s,
                                                    user: techMobile.user,
                                                    item: techMobile
                                                            ?.vdpList[index] ??
                                                        {},
                                                  );
                                                }));
                                              },
                                              child: ItemCard(
                                                item: techMobile
                                                        ?.vdpList[index] ??
                                                    {},
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Text('Không có phòng ở khu vực này'),
                        );
                      },
                    ))
              ],
            ));
  }
}
