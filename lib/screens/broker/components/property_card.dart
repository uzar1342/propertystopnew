import 'package:flutter/material.dart';
import 'package:propertystop/models/response/propery_list_response.dart';
import 'package:propertystop/screens/broker/property_details.dart';
import 'package:propertystop/screens/request_callback_bottomsheet.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/custom_dialog.dart';

class BrokerPropertyListCard extends StatelessWidget {
  const BrokerPropertyListCard({Key? key, required this.property})
      : super(key: key);

  final Datum property;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BrokerPropertyDetailPage(
            property: property,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ));

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => BrokerPropertyDetailPage(
        //       property: property,
        //     ),
        //   ),
        // );
      },
      child: Container(
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
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                property.propImg,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset('assets/no_image.png',
                      fit: BoxFit.cover,
                      height: 180,
                      width: MediaQuery.of(context).size.width);
                },
                fit: BoxFit.cover,
                height: 180,
                width: MediaQuery.of(context).size.width,
              ),
            ),
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
                  Expanded(
                    child: Text(
                      property.propType,
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
                  Icon(
                    property.buildStatusReady != ""
                        ? Icons.car_rental
                        : Icons.construction,
                    color: Colors.black87,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      property.buildStatusReady != ""
                          ? 'Ready To Move'
                          : 'Under Construction',
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
                    Icons.location_on,
                    color: Colors.black87,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      property.propAddress,
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
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final dialogAction = await Dialogs.yesNoAlertDialog(
                            "Confirmation",
                            "Are you sure you want to request for call back from our team?");
                        if (dialogAction == DialogAction.yes) {
                          // Navigator.of(context).pushNamed(
                          //   router.requestVisit,
                          // );
                          print("Here");
                          print(property.uniqueId);
                          showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext bc) {
                                return Wrap(children: [
                                  RequestCallbackBottomSheet(
                                    propertyId: property.uniqueId,
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
                          fontSize: 12,
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
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {

                      },
                      child: const Text(
                        "Download Brochure",
                        style: TextStyle(
                          color: constants.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: constants.PRIMARY_COLOR, width: 1),
                        padding: const EdgeInsets.all(12.0),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () async {},
                  //     child: const Text(
                  //       "Download Brochure",
                  //       style: TextStyle(
                  //         color: constants.PRIMARY_COLOR,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 12,
                  //       ),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Colors.white,
                  //       padding: const EdgeInsets.all(12),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         side: BorderSide.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 24,
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () async {},
                  //     child: const Text(
                  //       "Login",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       primary: constants.PRIMARY_COLOR,
                  //       padding: const EdgeInsets.all(12),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         side: BorderSide.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
