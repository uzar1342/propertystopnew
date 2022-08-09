import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propertystop/models/response/propery_list_response.dart';
import 'package:propertystop/screens/broker/components/property_card.dart';
import 'package:propertystop/screens/broker/models/property.dart';
import 'package:propertystop/utils/constants.dart' as constants;

class BrokerPropertiesPage extends StatefulWidget {
  const BrokerPropertiesPage({Key? key}) : super(key: key);

  @override
  State<BrokerPropertiesPage> createState() => _BrokerPropertiesPageState();
}

class _BrokerPropertiesPageState extends State<BrokerPropertiesPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "My Properties",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
        ),
      ),
    );
  }
}
