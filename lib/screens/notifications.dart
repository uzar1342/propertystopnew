import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}





class _NotificationPageState extends State<NotificationPage> {
  loadnotification()
  async {
    Response response;
    var dio = Dio();
    var formData = FormData.fromMap({
      'page': page.toString(),
    });
    response = await dio.post('https://propertystop.com/notification-list',data: formData);
    if(response.statusCode==200)
    {
      return response.data;
    }
    else
    {
      Fluttertoast.showToast(msg: "something went wrong");
      return response.data;
    }
  }
  String page="";
  late int paglen;
  int pagechck=1;
  List _posts = [];
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        elevation: 0,
        title: const Text(
          "Notification",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
      body: FutureBuilder<dynamic>(
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              
              final data = snapshot.data ;
              List as=data["data"];
              as.forEach((element) { _posts.add(element);});
              List n=data["page_array"];
              print(n);
              paglen=int.parse(n.length.toString());

              return Center(
                child: _posts.length>0?ListView.builder(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _posts.length,
                  itemBuilder: ((context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                        // height: 250,
                        decoration: BoxDecoration(
                          color:  Colors.white,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.redAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _posts[index]["not_title"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesome.book,
                                      color: Colors.black87,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            _posts[index]["not_message"],
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                            color:Color(0xfff0f0f0),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      color: Colors.black87,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _posts[index]["date"],
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    return Container();
                  }),
                ):Container(child: Image.asset("assets/no_property.png"),),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },

        // Future that needs to be resolved
        // inorder to display something on the Canvas
        future: loadnotification(),
      )
    );

  }
  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.atEdge) {
      if(pagechck<paglen)
      {
        pagechck=pagechck+1;
        setState(() {
          page=pagechck.toString();
        });
      }

      print("object");

    }
  }
}
