import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:propertystop/controllers/resale_list_viewmodel.dart';
import 'package:propertystop/models/response/resale_client_list_response.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:carousel_slider/carousel_slider.dart';
import '../../../add_property_bottomsheet.dart';
import '../../../models/response/resale_property_list_response.dart';
import '../../../utils/constants.dart';

class ResalePage extends StatefulWidget {
  const ResalePage({Key? key}) : super(key: key);

  @override
  State<ResalePage> createState() => _ResalePageState();
}

class _ResalePageState extends State<ResalePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyclient =
  GlobalKey<RefreshIndicatorState>();

    bool auto=false;
  late TabController _tabController;
  late List<ResalePropertyListResponse> test;
  final controller = ResaleListViewModel();
  TextEditingController mobileNumberInput=new TextEditingController();
  TextEditingController mobileNumberInput1=new TextEditingController();




  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    controller.getResalePropertyList();
    controller.getResaleClientList();
    test=controller.resalePropertyList();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  "Resale",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  indicatorWeight: 3.0,
                  tabs: const [
                    Tab(text: "Resale Property"),
                    Tab(text: "Resale Client"),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  Obx(() => SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextFormField(
                                   controller: mobileNumberInput,
                                      onChanged: (text) {
                                        setState(() {
                                          print(text);
                                        });
                                      },
                                  style: Theme.of(context).textTheme.headline6,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      // color: constants.PRIMARY_COLOR,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: constants.FIELD_COLOR,
                                    contentPadding: const EdgeInsets.all(12),
                                    hintText:
                                        "Search by location, area, pincode",
                                    hintStyle: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Expanded(
                                child: (controller.isPropertyLoading.value)
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              child: GifView.asset(
                                                'assets/gifs/logo_red.gif',
                                                height: 50,
                                                width: 50,
                                                frameRate:
                                                    30, // default is 15 FPS
                                              ),
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        ],
                                      )
                                    : RefreshIndicator(
                                  key: _refreshIndicatorKey,
                                  color: Colors.white,
                                  backgroundColor: Colors.red,
                                  strokeWidth: 4.0,
                                  onRefresh: () async {
                                    _refreshIndicatorKey.currentState?.show(); setState(() {
                                      controller.getResalePropertyList();
                                      test=controller.resalePropertyList();
                                  });
                                    return Future<void>.delayed(const Duration(seconds: 3));
                                  },
                                      child: controller
                                          .resalePropertyList.length>0?ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: controller
                                              .resalePropertyList.length,
                                          itemBuilder: ((context, index) {
                                            List<ResalePropertyListResponse> test=controller
                                                .resalePropertyList[index].otherBrokerClientData;
                                            var property = controller
                                                .resalePropertyList[index];

                                            if(test.length>1)
                                              {
                                                auto=true;
                                              }
                                              if (property.projectName
                                                .toString()
                                                .toLowerCase()
                                                .contains(mobileNumberInput.value.text
                                                .toLowerCase())) {
                                              return Container(
                                              margin: const EdgeInsets.symmetric(vertical: 20),
                                              // height: 250,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(0, 2),
                                                    blurRadius: 12,
                                                    color: Colors.black12,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 10.0,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              property.projectName,
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                           Icons.add_business_rounded,
                                                            color: Colors.black87,
                                                            size: 18,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              property.buildFloors.toString(),
                                                              style: const TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w500,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.note,
                                                            color: Colors.black87,
                                                            size: 18,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              property.propAbout,
                                                              style: const TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w500,
                                                                overflow: TextOverflow.clip,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(thickness: 1,),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                      property.propRoom.trim(),
                                                                      style: const TextStyle(
                                                                        color: Colors.black87,
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.w500,
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                        property.propCarpetArea.toString(),
                                                                          style: const TextStyle(
                                                                            color: Colors.black87,
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w500,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        ),Text(" sqft",style: TextStyle(fontSize: 15,),),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.fromLTRB(8,8,20,8),
                                                                child: Align(alignment:Alignment.topRight,child: Text(
                                                                    "??? "+property.propPrice.toString(),
                                                                    style: const TextStyle(
                                                                      color: PRIMARY_COLOR,
                                                                      fontSize: 22,
                                                                      fontWeight: FontWeight.w500,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ))),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    test.length>0?
                                                    Divider(thickness: 1,):Container(),
                                                    test.length>0?
                                                    CarouselSlider.builder(
                                                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                                            Container(
                                                              child: Card(
                                                                margin: EdgeInsets.zero,
                                                                color: Color(0xfff5f7f8),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                elevation: 5,
                                                                child: Column(

                                                                 children: [
                                                            Row(
                                                            children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  test[itemIndex].projectName,
                                                              style: const TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w600,
                                                              overflow: TextOverflow.ellipsis,
                                                              ),
                                                              ),
                                                            ),
                                                            ],
                                                            ),
                                            Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                            child: Row(
                                            children: [
                                            const Icon(
                                            Icons.add_business_rounded,
                                            color: Colors.black54,
                                            size: 18,
                                            ),
                                            const SizedBox(
                                            width: 5,
                                            ),
                                            Text(
                                                test[itemIndex].buildFloors.toString(),
                                            style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                            ),
                                            ),
                                            ],
                                            ),
                                            ),
                                            Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                            child: Row(
                                            children: [
                                            const Icon(
                                            Icons.note,
                                            color: Colors.black54,
                                            size: 18,
                                            ),
                                            const SizedBox(
                                            width: 5,
                                            ),
                                            Expanded(
                                            child: Text(
                                                test[itemIndex].propAbout,
                                            style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.clip,
                                            ),
                                            ),
                                            ),
                                            ],
                                            ),
                                            ),
                                            Divider(thickness: 1,),
                                                                   Padding(
                                                                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                                                     child: Column(
                                                                       children: [
                                                                         Row(
                                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                           children: [
                                                                             Column(
                                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                                               children: [
                                                                                 Padding(
                                                                                   padding: const EdgeInsets.all(8.0),
                                                                                   child: Text(
                                                                                     test[itemIndex].propRoom,
                                                                                     style: const TextStyle(
                                                                                       color: Colors.black54,
                                                                                       fontSize: 15,
                                                                                       fontWeight: FontWeight.w500,
                                                                                       overflow: TextOverflow.ellipsis,
                                                                                     ),
                                                                                   ),
                                                                                 ),
                                                                                 Padding(
                                                                                   padding: const EdgeInsets.all(8.0),
                                                                                   child: Row(
                                                                                     children: [
                                                                                       Text(
                                                                                         test[itemIndex].propCarpetArea.toString(),
                                                                                         style: const TextStyle(
                                                                                           color: Colors.black54,
                                                                                           fontSize: 15,
                                                                                           fontWeight: FontWeight.w500,
                                                                                           overflow: TextOverflow.ellipsis,
                                                                                         ),
                                                                                       ),Text(" sqft",style: TextStyle(fontSize: 15,),),
                                                                                     ],
                                                                                   ),
                                                                                 )
                                                                               ],
                                                                             ),
                                                                             Padding(
                                                                               padding: const EdgeInsets.fromLTRB(8,8,20,8),
                                                                               child: Container(alignment:Alignment.topRight,child: Text(
                                                                                   "??? "+test[itemIndex].propPrice.toString(),
                                                                                   style: const TextStyle(
                                                                                     color: PRIMARY_COLOR,
                                                                                     fontSize: 22,
                                                                                     fontWeight: FontWeight.w500,
                                                                                     overflow: TextOverflow.ellipsis,
                                                                                   ))),
                                                                             )
                                                                           ],
                                                                         ),
                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ],
                                                                ),
                                                              ),
                                                            ),
                                                        options: CarouselOptions(
                                                          aspectRatio: 16/10,
                                                          viewportFraction: 0.9,
                                                          initialPage: 0,
                                                          enableInfiniteScroll: auto,
                                                          reverse: false,
                                                          autoPlay: auto,
                                                          autoPlayInterval: Duration(seconds: 3),
                                                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                          autoPlayCurve: Curves.fastOutSlowIn,
                                                          enlargeCenterPage: true,
                                                       //   onPageChanged: callbackFunction,
                                                          scrollDirection: Axis.horizontal,
                                                        ), itemCount: test.length,
                                                    ):Container()

                                                  ],
                                                ),
                                              ),
                                            );
                                            }
                                            return Container(child: Image.asset("assets/no_property.png"),);
                                          }),
                                        ):Container(child: Center(
                                        child: Image.asset("assets/no_property.png"),
                                      ),),
                                    ),
                              )
                            ],
                          ),
                        ),
                      )),
                  Obx(() => SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              onChanged: (text) {
                                  setState(() {
                                  print(text);
                                  });
                                },
                               controller: mobileNumberInput1,
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.search,
                                  // color: constants.PRIMARY_COLOR,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: constants.FIELD_COLOR,
                                contentPadding: const EdgeInsets.all(12),
                                hintText:
                                "Search by location, area, pincode",
                                hintStyle: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Expanded(
                            child: (controller.isClientLoading.value)
                                ? Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SizedBox(
                                    child: GifView.asset(
                                      'assets/gifs/logo_red.gif',
                                      height: 50,
                                      width: 50,
                                      frameRate:
                                      30, // default is 15 FPS
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ],
                            )
                                :RefreshIndicator(
                              key: _refreshIndicatorKeyclient,
                              color: Colors.white,
                              backgroundColor: Colors.red,
                              strokeWidth: 4.0,
                              onRefresh: () async {
                                _refreshIndicatorKeyclient.currentState?.show();  setState(() {
                                  controller.getResaleClientList();
                                  test=controller.resalePropertyList();
                                });
                                return Future<void>.delayed(const Duration(seconds: 3));
                              },
                                  child: controller
                                      .resaleClientList.length>0?ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller
                                    .resaleClientList.length,
                              itemBuilder: ((context, index) {
                                  var property = controller
                                      .resaleClientList[index];
                                  List<ResaleClientListResponse> test=controller
                                      .resaleClientList[index].other_broker_property_data;
                                  if (property.projectName
                                      .toString()
                                      .toLowerCase()
                                      .contains(mobileNumberInput1.value.text
                                      .toLowerCase())||property.propRoom
                                      .toString()
                                      .toLowerCase()
                                      .contains(mobileNumberInput1.value.text
                                      .toLowerCase()) ) {
                                    return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 20),
                                    // height: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 12,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 10.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  property.projectName,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.add_business_rounded,
                                                color: Colors.black87,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  property.buildFloors.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.note,
                                                color: Colors.black87,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  property.propAbout,
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(thickness: 1,),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  property.propRoom,
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8,8,20,8),
                                                  child: Container(alignment:Alignment.topRight,child: Text(
                                                      "??? "+property.propPrice.toString(),
                                                      style: const TextStyle(
                                                        color: PRIMARY_COLOR,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.w500,
                                                        overflow: TextOverflow.ellipsis,
                                                      ))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 5,
                                              ),

                                              Text(
                                                property.propCarpetArea.toString(),
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),Text(" sqft",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),

                                       test.length>0?
                                       Divider(thickness: 1,):Container(),
                                        test.length>0?
                                        CarouselSlider.builder(
                                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                              Container(
                                                child: Card(
                                                  margin: EdgeInsets.zero,
                                                  color: Color(0xfff5f7f8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  elevation: 5,
                                                  child: Column(

                                                    children: [
                                                      Divider(thickness: 1,),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              test[itemIndex].projectName,
                                                              style: const TextStyle(
                                                                color: Colors.black54,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.add_business_rounded,
                                                              color: Colors.black54,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              test[itemIndex].buildFloors.toString(),
                                                              style: const TextStyle(
                                                                color: Colors.black54,
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w500,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.note,
                                                              color: Colors.black54,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                test[itemIndex].propAbout,
                                                                style: const TextStyle(
                                                                  color: Colors.black54,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.clip,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(thickness: 1,),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                        test[itemIndex].propRoom,
                                                                        style: const TextStyle(
                                                                          color: Colors.black54,
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.w500,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                        test[itemIndex].propCarpetArea.toString()+" sqt",
                                                                        style: const TextStyle(
                                                                          color: Colors.black54,
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.w500,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.fromLTRB(8,8,20,8),
                                                                  child: Align(alignment:Alignment.topRight,child: Text(
                                                                      "??? "+test[itemIndex].propPrice.toString(),
                                                                      style: const TextStyle(
                                                                        color: PRIMARY_COLOR,
                                                                        fontSize: 22,
                                                                        fontWeight: FontWeight.w500,
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ))),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          options: CarouselOptions(
                                            aspectRatio: 16/10,
                                            viewportFraction: 0.9,
                                            initialPage: 0,
                                            enableInfiniteScroll: auto,
                                            reverse: false,
                                            autoPlay: auto,
                                            autoPlayInterval: Duration(seconds: 3),
                                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            //   onPageChanged: callbackFunction,
                                            scrollDirection: Axis.horizontal,
                                          ), itemCount: test.length,
                                        ):Container()


                                      ],
                                    ),
                                  );
                                  }
                                  return Container(child: Image.asset("assets/no_property.png"),);
                              }),
                            ):Container(child: Center(
                                    child: Image.asset("assets/no_property.png"),
                                  ),),
                                ),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  shape: const StadiumBorder(),
                  onPressed: () {
                    // Navigator.pushNamed(context, resaleProperty);
                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext bc) {
                          return Wrap(children: const [Addpropertylist()]);
                        });
                  },
                  backgroundColor: constants.PRIMARY_COLOR,
                  child: const Icon(
                    Icons.add_business,
                    size: 24.0,
                  ))),
        ),
      ),
    );
  }
}
