import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.check,
    required this.iconBgColor,
    required this.onChanged,
    required this.index,
  });
  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBgColor;
  final Function onChanged;
  final int index;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
                primarySwatch: Colors.blue,
                unselectedWidgetColor: const Color(0xff5e616a)),
            child: Transform.scale(
              scale: 1,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                activeColor: const Color.fromARGB(255, 143, 59, 72),
                checkColor: Colors.white,
                value: widget.check,
                onChanged: (bool? value) {
                  widget.onChanged(widget.index);
                },
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 75,
              child: Card(
                color: const Color.fromARGB(255, 143, 59, 72),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 36,
                      height: 33,
                      decoration: BoxDecoration(
                          color: widget.iconBgColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        widget.iconData,
                        color: widget.iconColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          if (widget.check)
                            const Divider(
                              color: Colors.white,
                              thickness: 2,
                              height: 30,
                              indent: 0,
                              endIndent: 0,
                            ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: widget.check ? 10 : 0),
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.time,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
