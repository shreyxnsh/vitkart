import 'package:flutter/material.dart';
import 'package:t_store/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:t_store/utils/constants/colors.dart';

import '../../../../common/widgets/curved_edges/curved_edges_widget.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          
          children: [
          TPrimaryHeaderContainer(child: Container()
          )
        ]
        ),
      ),
    );
  }
}
