import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propertystop/screens/broker/models/client.dart';
import 'package:propertystop/utils/constants.dart' as constants;

class BrokerClientsPage extends StatefulWidget {
  const BrokerClientsPage({Key? key}) : super(key: key);

  @override
  State<BrokerClientsPage> createState() => _BrokerClientsPageState();
}

class _BrokerClientsPageState extends State<BrokerClientsPage> {
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
              "My Clients",
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
          ),
        ),
      ),
    );
  }
}
