import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/controllers/my_site_visit_viewmodel.dart';

class MySiteVisits extends StatefulWidget {
  const MySiteVisits({Key? key}) : super(key: key);

  @override
  State<MySiteVisits> createState() => _MySiteVisitsState();
}

class _MySiteVisitsState extends State<MySiteVisits> {
  var controller = MySiteVisitsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My site visits")),
      body: Obx(() => (controller.isLoading.value)
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: (CircularProgressIndicator())),
        ],
      )
          : SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: controller.siteVisits.length>0?ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.siteVisits.length,
          itemBuilder: ((context, index) {
            var w=MediaQuery.of(context).size.width;
            var h=MediaQuery.of(context).size.height;
            Color primaryColor = const Color(0xff1f7396);
            return
              Container(
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
                              controller.siteVisits.value[index].projectName,
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
                            Icons.calendar_month,
                            color: Colors.black87,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              controller.siteVisits.value[index].enquiryDate,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black87,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              controller.siteVisits.value[index].visitDate,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.black87,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              controller.siteVisits.value[index].visitDate,
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

                  ],
                ),
              );
//               Card(
//                 child: Column(
//                   children: [
//                     Text(controller.siteVisits[index].projectName),
//                     Text(controller.siteVisits[index].visitDate),
//                     Text(controller.siteVisits[index].visitTime),
//                   ],
//                 ),
//               );
          }),
        ):Container(child: Center(child: Image.asset("assets/no_property.png"),),),
      )),
    );
  }
}
