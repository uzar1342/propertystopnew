import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propertystop/models/response/propery_list_response.dart';
import 'package:propertystop/screens/broker/components/property_card.dart';
import 'package:propertystop/screens/broker/models/client.dart';
import 'package:propertystop/screens/broker/models/property.dart';
import 'package:propertystop/utils/constants.dart' as constants;

class ResalePage extends StatefulWidget {
  const ResalePage({Key? key}) : super(key: key);

  @override
  State<ResalePage> createState() => _ResalePageState();
}

class _ResalePageState extends State<ResalePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
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
                  Tab(text: "Buy"),
                  Tab(text: "Sell"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                SafeArea(
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
                            // controller: mobileNumberInput,
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
                              hintText: "Search by location, area, pincode",
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
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: dummy_properties.length,
                            itemBuilder: ((context, index) {
                              Property property = dummy_properties[index];
                              return BrokerPropertyListCard(
                                property: Datum(
                                    id: 14,
                                    projectName: "projectName",
                                    propType: "propType",
                                    propAddress: "propAddress",
                                    propCity: "propCity",
                                    propState: "propState",
                                    propCountry: "propCountry",
                                    buildFloors: 13,
                                    buildWings: 4,
                                    builderName: "builderName",
                                    possesssionDate: "possesssionDate",
                                    buildStatusReady: "buildStatusReady",
                                    uniqueId: "uniqueId",
                                    propImg: "propImg",
                                    propRooms: "propRooms",
                                    downloadCls: "downloadCls",
                                    downloadBrochure: "downloadBrochure",
                                    downloadParameter: "downloadParameter"),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SafeArea(
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
                            // controller: mobileNumberInput,
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
                              hintText: "Search by client name",
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
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: dummy_clients.length,
                            itemBuilder: ((context, index) {
                              Client client = dummy_clients[index];
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(18.0),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 12,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  client.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton: _tabController.index == 0
                ? FloatingActionButton(
                    shape: const StadiumBorder(),
                    onPressed: () {},
                    backgroundColor: constants.PRIMARY_COLOR,
                    child: const Icon(
                      Icons.add_business,
                      size: 24.0,
                    ))
                : FloatingActionButton(
                    shape: const StadiumBorder(),
                    onPressed: () {},
                    backgroundColor: constants.PRIMARY_COLOR,
                    child: const Icon(
                      Icons.group_add_rounded,
                      size: 24.0,
                    )),
          ),
        ),
      ),
    );
  }
}
