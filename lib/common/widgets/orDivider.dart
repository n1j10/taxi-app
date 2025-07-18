import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:katon_taxi25/constant/utils/colors.dart';
import 'package:katon_taxi25/constant/utils/textStyles.dart';
import 'package:sizer/sizer.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: grey)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text('or', style: AppTextStyles.small12.copyWith(color: grey)),
        ),
        Expanded(child: Divider(color: grey)),
      ],
    );
  }
}
