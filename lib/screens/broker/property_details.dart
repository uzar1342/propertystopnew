import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:propertystop/controllers/property_detail_viewmodel.dart';
import 'package:propertystop/models/response/propery_list_response.dart';
import 'package:propertystop/screens/broker/models/property.dart';
import 'package:propertystop/screens/property_photos.dart';
import 'package:propertystop/screens/realestate_webview.dart';
import 'package:propertystop/screens/request_callback_bottomsheet.dart';
import 'package:propertystop/screens/request_visit_bottomsheet.dart';
import 'package:propertystop/screens/youtube_videos.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/custom_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../vidioplayer.dart';

class BrokerPropertyDetailPage extends StatefulWidget {
  BrokerPropertyDetailPage({Key? key, required this.property})
      : super(key: key);

  final Datum property;

  // Property property1 = dummy_properties[0];

  @override
  State<BrokerPropertyDetailPage> createState() =>
      _BrokerPropertyDetailPageState();
}

class _BrokerPropertyDetailPageState extends State<BrokerPropertyDetailPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final controller = PropertyDetailViewModel();

  @override
  void initState() {
    super.initState();
    controller.getPropertyDetail(widget.property.uniqueId);
    print(controller.propDetails.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          title: Obx(() => Text(
                (controller.isLoading.value)
                    ? ("")
                    : controller.propertyDetail.value!.propData[0].projectName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              )),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(bottom: 100),
            child: Obx(() => (controller.isLoading.value)
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        (Center(
                          child: CircularProgressIndicator(),
                        )),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            // child: CarouselSlider(
                            //   items: List.generate(
                            //     widget.property.images.length,
                            //     (index) => ClipRRect(
                            //       borderRadius: BorderRadius.circular(5),
                            //       child: Image.asset(
                            //         widget.property.images[index],
                            //         fit: BoxFit.cover,
                            //         height: MediaQuery.of(context).size.height *
                            //             0.3, // 35%
                            //         width: MediaQuery.of(context).size.width,
                            //       ),
                            //     ),
                            //   ),
                            //   options: CarouselOptions(
                            //     aspectRatio: 2.0,
                            //     autoPlay: true,
                            //     enlargeCenterPage: true,
                            //     pageSnapping: true,
                            //   ),
                            // ),
                            child: Image.network(
                              controller
                                  .propertyDetail.value!.propData[0].thumbnail,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height *
                                  0.3, // 35%
                              width: MediaQuery.of(context).size.width,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset('assets/no_image.png',
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height *
                                        0.3, // 35%
                                    width: MediaQuery.of(context).size.width);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Property Name
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      controller.propertyDetail.value!
                                          .propData[0].projectName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: constants.PRIMARY_COLOR,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    widget.property.buildStatusReady != ""
                                        ? 'Ready To Move'
                                        : 'Under Construction',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.black87,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    controller.propertyDetail.value!.propData[0]
                                        .propAddress,
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
                            const SizedBox(
                              height: 12,
                            ),
                            if (Uri.tryParse(widget.property.downloadBrochure
                                        .toString())
                                    ?.hasAbsolutePath ??
                                false)
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.black, width: 1),
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                onPressed: () {
                                  Get.to(() => RealEstateWebView(
                                        pageUrl: widget
                                            .property.downloadBrochure
                                            .toString(),
                                        title: 'Brochure',
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.download,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Download Brochure",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        () => PropertyPhotos(
                                            imageUrls: controller
                                                .propertyDetail.value!.images),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: constants.PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Photos",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => VideoPlayerScreen());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: constants.PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Videos",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Amenities
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Amenities",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ...controller.propertyDetail.value!.amenity.map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(right: 12),
                                      // decoration: const BoxDecoration(
                                      //   color: constants.PRIMARY_COLOR,
                                      //   // borderRadius: BorderRadius.circular(5),
                                      //   shape: BoxShape.circle,
                                      // ),
                                      child: Image.network(e.amenityImage),
                                    ),
                                    Text(
                                      e.amen,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Features
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Features",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ...controller.propertyDetail.value!.features.map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: const BoxDecoration(
                                        color: constants.PRIMARY_COLOR,
                                        // borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      e["feature"],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Property Details
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Property Details",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ...List.generate(
                                controller.propDetails.value.length, (index) {
                              PropertyDetails dets =
                                  controller.propDetails.value[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.3),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          dets.title,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          dets.value,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Nearby Places
                      // Container(
                      //   color: Colors.white,
                      //   padding: const EdgeInsets.all(24),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       const Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //           "What's Nearby",
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 10,
                      //       ),
                      //       ...List.generate(widget.property1.propPlaces.length,
                      //           (index) {
                      //         PropertyDetailPlaces nearby =
                      //             widget.property1.propPlaces[index];
                      //         return Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               vertical: 5, horizontal: 0),
                      //           child: Container(
                      //             padding: const EdgeInsets.only(bottom: 8),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   nearby.place,
                      //                   style: const TextStyle(
                      //                     color: constants.PRIMARY_COLOR,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 5,
                      //                 ),
                      //                 Text(
                      //                   nearby.desc,
                      //                   style: const TextStyle(
                      //                     color: Color.fromRGBO(0, 0, 0, 0.6),
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       })
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // Rooms (Pending to implement)
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Rooms Available",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // ...List.generate(widget.property1.propPlaces.length,
                            //     (index) {
                            //   PropertyDetailPlaces nearby =
                            //       widget.property1.propPlaces[index];
                            //   return Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 5, horizontal: 0),
                            //     child: Container(
                            //       padding: const EdgeInsets.only(bottom: 8),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             nearby.place,
                            //             style: const TextStyle(
                            //               color: constants.PRIMARY_COLOR,
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           const SizedBox(
                            //             height: 5,
                            //           ),
                            //           Text(
                            //             nearby.desc,
                            //             style: const TextStyle(
                            //               color: Color.fromRGBO(0, 0, 0, 0.6),
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   );
                            // })
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Floor Plans
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Floor Plans",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            CarouselSlider(
                              carouselController: _controller,
                              items: List.generate(
                                controller.propertyDetail.value!.floors.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    print(controller.propertyDetail.value!
                                        .floors[index].url);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        controller.propertyDetail.value!
                                            .floors[index].url,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3, // 35%
                                        width:
                                            MediaQuery.of(context).size.width,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                              'assets/no_image.png',
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3, // 35%
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              options: CarouselOptions(
                                aspectRatio: 2.0,
                                // autoPlay: true,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                padEnds: true,
                                pageSnapping: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller.propertyDetail.value!.images
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(_current == entry.key
                                              ? 0.9
                                              : 0.4),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Location
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Location",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () async {
                                String googleMapsUri =
                                    "comgogglemaps://?center=${controller.propertyDetail.value!.propData[0].propLatitude},${controller.propertyDetail.value!.propData[0].propLongitude}";
                                String appleMapsUri =
                                    "https://maps.apple.com/?q=${controller.propertyDetail.value!.propData[0].propLatitude},${controller.propertyDetail.value!.propData[0].propLongitude}";

                                if (await canLaunchUrlString(googleMapsUri)) {
                                  await launchUrlString(googleMapsUri);
                                } else if (await canLaunchUrlString(
                                    appleMapsUri)) {
                                  await launchUrlString(appleMapsUri);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Cannot open maps!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0,
                                  );
                                  return;
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  "assets/static_map.jpeg",
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height *
                                      0.2, // 35%
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Property Description
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  controller.propertyDetail.value!.propData[0]
                                      .propAbout,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Builder Information
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Builder Information",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Lodha Builders",
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "No.of Projects",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "12+",
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Started",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "2002",
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  )),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          margin: const EdgeInsets.symmetric(vertical: 25),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final dialogAction = await Dialogs.yesNoAlertDialog(
                      "Confirmation",
                      "Are you sure you want to request for in-person site visit?");
                  if (dialogAction == DialogAction.yes) {
                    // Navigator.of(context).pushNamed(
                    //   router.requestVisit,
                    // );
                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext bc) {
                          return Wrap(children: [
                            RequestVisitBottomSheet(
                              propertyId: widget.property.uniqueId.toString(),
                            )
                          ]);
                        });
                  }
                },
                child: const Text(
                  "Request Site Visit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: constants.PRIMARY_COLOR,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final dialogAction = await Dialogs.yesNoAlertDialog(
                      "Confirmation",
                      "Are you sure you want to request for call back from our team?");
                  if (dialogAction == DialogAction.yes) {
                    // Navigator.of(context).pushNamed(
                    //   router.requestVisit,
                    // );
                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext bc) {
                          return Wrap(children: [
                            RequestCallbackBottomSheet(
                              propertyId: widget.property.uniqueId,
                            )
                          ]);
                        });
                  }
                },
                child: const Text(
                  "Request Call Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: constants.PRIMARY_COLOR,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
