import 'package:doggie_chef/routes/route_value.dart';
import 'package:doggie_chef/src/core/utils/animated_button.dart';
import 'package:doggie_chef/src/core/utils/app_icon.dart';
import 'package:doggie_chef/src/core/utils/icon_provider.dart';
import 'package:doggie_chef/src/core/utils/size_utils.dart';
import 'package:doggie_chef/src/core/utils/text_with_border.dart';
import 'package:doggie_chef/src/feature/main/bloc/app_bloc.dart';
import 'package:doggie_chef/ui_kit/app_app_bar.dart';
import 'package:doggie_chef/ui_kit/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool isGood = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              const AppAppBar(
                title: "Food base",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    onPressed: () => setState(() => isGood = true),
                    width: getWidth(context, baseSize: 169),
                    style: ButtonColors.red,
                    text: "",
                    child: Row(
                      children: [
                        const TextWithBorder(
                          "bad",
                          borderColor: Color(0xFF6D0000),
                        ),
                        AppIcon(asset: IconProvider.cross.buildImageUrl()),
                      ],
                    ),
                  ),
                  AppButton(
                    onPressed: () => setState(() => isGood = true),
                    width: getWidth(context, baseSize: 169),
                    style: ButtonColors.green,
                    text: "",
                    child: Row(
                      children: [
                        const TextWithBorder(
                          "good",
                          borderColor: Color(0xFF406D00),
                        ),
                        AppIcon(asset: IconProvider.mark.buildImageUrl()),
                      ],
                    ),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: state.food.where((e) => e.isGood == isGood).length,
                separatorBuilder: (_, __) => const Gap(11),
                itemBuilder: (context, index) => AnimatedButton(
                  onPressed: () => context.push(
                    "${RouteValue.home.path}/${RouteValue.base.path}/${RouteValue.description.path}",
                    extra: index,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          IconProvider.button.buildImageUrl(),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 36),
                      child: Center(
                        child: TextWithBorder(
                          state.food
                              .where((e) => e.isGood == isGood)
                              .elementAt(index)
                              .name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
