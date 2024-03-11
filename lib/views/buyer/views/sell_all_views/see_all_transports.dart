import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class SeeAllTransports extends StatefulWidget {
  final List? data;
  const SeeAllTransports({Key? key, this.data}) : super(key: key);

  @override
  State<SeeAllTransports> createState() => _SeeAllTransportsState();
}

class _SeeAllTransportsState extends State<SeeAllTransports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar("Our Transporters"),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: widget.data!.length,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                return ListTile(
                  minLeadingWidth: 65,
                  leading: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network("https://picsum.photos/200")),
                  title: Text(widget.data![index]['name'].toString().toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.2, fontSize: 16)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${widget.data![index]['phone'].toString()}',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black54, overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                      Text(
                        '${widget.data![index]['city'].toString()} • ${widget.data![index]['state'].toString()}',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black54, overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: TextButton(
                      style: TextButton.styleFrom(backgroundColor: widget.data![index]['phone'] != null ? Colors.orange.withOpacity(0.3) : Colors.grey.shade300),
                      onPressed: () async {
                        if (widget.data![index]['phone'] != null) {
                          bool? res = await FlutterPhoneDirectCaller.callNumber(widget.data![index]['phone'].toString());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Contact Number not provided by the transporter.")));
                        }
                      },
                      child: Text(
                        "Make a call",
                        style: TextStyle(
                            color: widget.data![index]['phone'] != null ? Colors.black.withOpacity(0.85) : Colors.black54, fontWeight: FontWeight.w600, fontSize: 12),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
