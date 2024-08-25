import 'package:flutter/material.dart';
import 'package:smartchef/core/constants/appcolors.dart';

class FilteringRectangle extends StatelessWidget {
  final String? filtername;
  final VoidCallback? onpressed;
  final bool check;

  FilteringRectangle({
    super.key,
    required this.filtername,
    required this.onpressed,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.lightOrange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(filtername!),
            IconButton(
              onPressed: onpressed, // Fix: call the onpressed function here
              icon: check
                  ? Icon(
                      Icons.expand_less_sharp,
                      size: 30,
                    )
                  : Icon(Icons.expand_more, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
