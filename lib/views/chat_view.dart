import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Sambhav Jain',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                            ),
                            Text('Typing...',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // filterSheet(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 20,
                    physics: ScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          crossAxisAlignment: index % 2 == 0
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? const Color(0xffF7FBFF)
                                        : const Color(0xff424F63),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Text(
                                    'Done, I just finished it!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: index % 2 == 0
                                          ? const Color(0xff213241)
                                          : const Color(0xffF7FBFF),
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xffF7FBFF)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Type here...',
                      style: TextStyle(
                        color: Color(0xff8593A8),
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.image,
                          color: Color(0xff8593A8),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.mood,
                          color: Color(0xff8593A8),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
