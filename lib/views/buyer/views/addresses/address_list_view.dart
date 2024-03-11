import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import 'add_address_view.dart';

class AddressListView extends StatefulWidget {
  const AddressListView({Key? key}) : super(key: key);

  @override
  State<AddressListView> createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  @override
  void initState() {
    customerAddControl.getAddressFromServer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        toolbarHeight: 30.sp,
        title: Text(
          "ADDRESS BOOK",
          style: TextStyle(fontSize: 16.sp, color: Color(0xFF213C63), fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,size: 18.sp,),
          color: Colors.orangeAccent,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(
                    NewAddressView(
                      isUpdate: false,
                    ),
                    transition: Transition.rightToLeft);
              },
              icon: Icon(
                Icons.add,
                color: Colors.orangeAccent,
                size: 18.sp,
              ))
        ],
      ),
      body: Obx(
        () => customerAddControl.addressList.value.length != 0
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: customerAddControl.addressList.value.length,
                padding: EdgeInsets.symmetric(horizontal: 18.sp),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0.sp),
                    child: AddressCard(
                      data: customerAddControl.addressList[index],
                    ),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text("No address added!")),
                  TextButton(
                    onPressed: () {
                      Get.to(
                          NewAddressView(
                            isUpdate: false,
                          ),
                          transition: Transition.rightToLeft);
                    },
                    child: Text(
                      "Add a Address",
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final dynamic data;
  final bool? isFromPreview;
  const AddressCard({
    Key? key,
    this.data,
    this.isFromPreview = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(width: 2.sp, color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${data['address']['address_line_1'].toString()}",
                        maxLines: 3, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.80))),
                    SizedBox(
                      height: 4,
                    ),
                    Text("${data['address']['address_line_2'].toString()}",
                        maxLines: 2, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.80))),
                    SizedBox(
                      height: 4,
                    ),
                    Text("${data['address']['landmark'].toString()}",
                        maxLines: 1, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.80))),
                    SizedBox(
                      height: 4,
                    ),
                    Text("${data['address']['city'].toString()}, ${data['address']['state'].toString()}",
                        maxLines: 1, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.80))),
                    Text("${data['address']['pin_code'].toString()}",
                        maxLines: 3, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.80))),
                  ],
                ),
              ),
              if (data['is_default'] == 1)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                  decoration: BoxDecoration(color: Colors.orangeAccent.withOpacity(0.4), borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "DEFAULT",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, letterSpacing: 0.2, color: Colors.black.withOpacity(0.85)),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.1),padding: EdgeInsets.symmetric(vertical: 10.sp,horizontal: 15.sp)),
                onPressed: () {
                  Get.to(NewAddressView(isUpdate: true, isDefault: data['is_default'], oldData: data['address'], addressId: data['id']), transition: Transition.cupertino);
                },
                child: Text(
                  "EDIT",
                  style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.2, fontSize: 14.sp, color: Colors.black.withOpacity(0.85)),
                ),
              ),
              SizedBox(
                width: 10.sp,
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.1),padding: EdgeInsets.symmetric(vertical: 10.sp,horizontal: 15.sp)),
                onPressed: () {
                  // addressControl.deleteAddressServer(context, data['id'].toString());
                  customerAddControl.deleteAddress(context, data['id']);
                },
                child: Text(
                  "DELETE",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.85), letterSpacing: 0.2, fontSize: 14.sp),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
