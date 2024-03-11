import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transport_controller.dart';

class TransportView extends StatefulWidget {
  const TransportView({Key? key}) : super(key: key);

  @override
  State<TransportView> createState() => _TransportViewState();
}

class _TransportViewState extends State<TransportView> {
  final transportController = Get.put(TransportController());

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    double c_width = mediaWidth / 2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF1FAFF),
                  Color(0xFFFFF7EE),
                ],
              )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 36, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 25,
                        backgroundImage:
                            NetworkImage('https://picsum.photos/200'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text('Location',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                            const Text("Lorem ipsum dolor sit ame.",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    textAlign: TextAlign.start,
                    // controller: searchCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Search Products',
                        hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: Colors.black45,
                        )
                        // fillColor: colorSearchBg,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Transport List',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6C9674)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5 * 140,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 130, maxWidth: 125),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        'https://picsum.photos/200'))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text('Thakur Transport',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.2,
                                              fontSize: 16)),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.phone,
                                            size: 20, color: Colors.black54),
                                        Text(
                                          ' +91- 8587458965',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black54,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4.0),
                                    child: SizedBox(
                                      width: c_width,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 4.0),
                                            child: Icon(
                                                Icons.location_on_outlined,
                                                size: 20,
                                                color: Colors.black54),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'simply dummy text of the printing and typesetting .',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
