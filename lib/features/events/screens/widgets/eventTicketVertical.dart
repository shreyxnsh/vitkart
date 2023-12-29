import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/events/screens/ticket.dart';

class EventTicketVertical extends StatelessWidget {
  const EventTicketVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const TicketScreen());
      },
      child: Container(
        width: double.infinity,
        height: 115,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFF172F52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x21000000),
              blurRadius: 49,
              offset: Offset(-13, 21),
              spreadRadius: -31,
            )
          ],
        ),
        child: Column(
          children: [
            
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left Content
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID 212345",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Garba Event",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "07 Jan 2024",
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              Text(
                                "Auditorium",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Oval Borders and Dotted Line
                      

                      // Right Content
                      Row(
                        children: [
                          SizedBox(
                              child: Image.asset(
                                "assets/icons/events/verticaldotted.png",
                                
                             
                                height: 115,
                                fit: BoxFit.fitHeight,
                              ),
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Center(
                              child: SizedBox(
                                child: Image.asset(
                                  "assets/icons/events/dummyqr.png",
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                
 
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF121933)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5.0;
    const double dashSpace = 5.0;
    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
