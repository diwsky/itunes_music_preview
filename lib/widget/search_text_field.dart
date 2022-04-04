import 'package:flutter/material.dart';
import 'package:itunes_music_preview/style/app_color.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:itunes_music_preview/style/app_text_style.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class SearchTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String placeholder;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  const SearchTextField(
      {this.textEditingController,
      required this.placeholder,
      this.onSearch,
      this.onChanged,
      this.suffixIcon,
      this.textInputAction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimen.paddingMedium),
      child: TextFormField(
        style: AppTextStyle.regular(),
        controller: textEditingController,
        onChanged: onChanged,
        onFieldSubmitted: onSearch,
        textInputAction: textInputAction ?? TextInputAction.search,
        decoration: InputDecoration(
            isDense: true,
            hintText: placeholder,
            hintStyle: AppTextStyle.light(color: Colors.black26),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColor.greyLight,
            errorStyle: AppTextStyle.light(color: AppColor.red),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
              borderSide: const BorderSide(color: Colors.red),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.paddingMedium),
              child: suffixIcon ??
                  const Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: AppDimen.iconSizeMax,
              maxWidth: AppDimen.iconSizeMax,
            )),
      ),
    );
  }
}
