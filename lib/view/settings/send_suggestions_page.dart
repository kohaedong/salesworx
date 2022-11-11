import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salesworxm/styles/app_colors.dart';
import 'package:salesworxm/styles/app_size.dart';
import 'package:salesworxm/styles/app_style.dart';
import 'package:salesworxm/styles/app_text_style.dart';
import 'package:salesworxm/util/hiden_keybord.dart';
import 'package:salesworxm/view/common/app_bar.dart';
import 'package:salesworxm/view/common/app_toast.dart';
import 'package:salesworxm/view/common/base_layout.dart';
import 'package:salesworxm/view/settings/provider/settings_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SendSuggestionPage extends StatefulWidget {
  const SendSuggestionPage({Key? key}) : super(key: key);
  static const String routeName = '/sendSuggestion';

  @override
  _SendSuggestionPageState createState() => _SendSuggestionPageState();
}

class _SendSuggestionPageState extends State<SendSuggestionPage> {
  ScrollController _textFieldScrollController = ScrollController();
  ScrollController _pageScrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textFieldScrollController.dispose();
    _pageScrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  Widget buildDiscription() {
    return Padding(
        padding: AppSize.fontSizePageTopWidgetPadding,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AppStyles.text(
              '${tr('send_suggestions_discription')}', AppTextStyle.default_14),
        ));
  }

  Widget buildSuggetionCenterPadding() {
    return Padding(
      padding: AppSize.sendSuggestionsCenterPadding,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppStyles.text(
                '${tr('write_some_suggestions')}', AppTextStyle.w500_16),
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldBox() {
    return Container(
        height: AppSize.suggestionsBoxHeight,
        width: AppSize.boxWidth,
        child: TextFormField(
          controller: _textEditingController,
          scrollController: _textFieldScrollController,
          onTap: () {
            Future.delayed(Duration(milliseconds: 200), () {
              final maxScrollValue =
                  _pageScrollController.position.maxScrollExtent;
              _pageScrollController.jumpTo(maxScrollValue);
            });
          },
          onChanged: (text) {
            final p = context.read<SettingsProvider>();
            p.setSuggestion(text);
          },
          autofocus: false,
          inputFormatters: [LengthLimitingTextInputFormatter(200)],
          autocorrect: false,
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          decoration: InputDecoration(
              fillColor: AppColors.whiteText,
              hintText: '${tr('suggestion_hint')}',
              hintStyle: AppTextStyle.hint_16,
              border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(
                      color: AppColors.unReadyButtonBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(AppSize.radius5)),
              focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(color: AppColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(AppSize.radius5))),
        ));
  }

  Widget buildSubmmitButton() {
    return Container(
        height: AppSize.buttonHeight,
        child: Consumer<SettingsProvider>(builder: (context, provider, _) {
          return TextButton(
              style: provider.suggetionText == null
                  ? AppStyles.getButtonStyle(AppColors.unReadyButton,
                  AppColors.unReadyText, AppTextStyle.default_18, 0)
                  : AppStyles.getButtonStyle(AppColors.primary,
                  AppColors.whiteText, AppTextStyle.default_18, 0),
              onPressed: () async {
                Platform.isIOS
                    ? hideKeyboard(context)
                    : hideKeyboardForAndroid(context);
                final isSended = await provider.sendSuggestion();
                if (isSended) {
                  AppToast().show(context, '${tr('send_success')}');
                  _textEditingController.clear();
                }
              },
              child: Container(
                width: AppSize.buildWidth(context, 1),
                height: AppSize.buttonHeight,
                child: Center(child: Text('${tr('submmit')}')),
              ));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        hasForm: true,
        isWithBottomSafeArea: false,
        isResizeToAvoidBottomInset: true,
        appBar: MainAppBar(
          context,
          titleText:
          AppStyles.text('${tr('send_suggestion')}', AppTextStyle.w500_20),
          icon: Icon(Icons.close_rounded),
        ),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              controller: _pageScrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      buildDiscription(),
                      buildSuggetionCenterPadding(),
                      buildTextFieldBox(),
                      Spacer(),
                      buildSubmmitButton()
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
