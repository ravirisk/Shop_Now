
import 'package:flutter/material.dart';
import 'package:shop_now/utils/app_color.dart';


class EmptyCartWidget extends StatelessWidget {
   const EmptyCartWidget({super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 0, bottom: 0),
          child:  Icon(Icons.signal_wifi_connected_no_internet_4_rounded, color: AppColors.kBlue, size: 100,),
        ),
      ],
    );
  }
}

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 0),
          child:  Icon(Icons.signal_wifi_connected_no_internet_4_rounded, color: AppColors.kBlue, size: 50,),
        ),
      ],
    );
  }
}

