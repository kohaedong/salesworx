import 'package:salesworxm/enums/update_and_notice_check_type.dart';
import 'package:salesworxm/view/common/app_dialog.dart';
import 'package:salesworxm/view/common/dialog_contents.dart';
import 'package:salesworxm/view/commonLogin/update_and_notice_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salesworxm/service/cache_service.dart';
import 'package:salesworxm/styles/app_colors.dart';
import 'package:salesworxm/styles/app_size.dart';
import 'package:salesworxm/styles/app_style.dart';
import 'package:salesworxm/styles/app_text_style.dart';
import 'package:salesworxm/view/common/app_bar.dart';
import 'package:salesworxm/view/common/base_layout.dart';
import 'package:salesworxm/view/commonLogin/common_login_page.dart';
import 'package:salesworxm/view/settings/notice_setting_page.dart';
import 'package:salesworxm/view/settings/provider/settings_provider.dart';
import 'package:salesworxm/view/settings/send_suggestions_page.dart';
import 'package:provider/provider.dart';
import 'package:salesworxm/model/update/check_update_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String routeName = '/settings';

  Widget _buildNameRow(BuildContext context, SettingsResult data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStyles.text('${data.user!.userName}', AppTextStyle.w500_16),
                Padding(padding: EdgeInsets.only(top: AppSize.listFontSpacing)),
                AppStyles.text('${data.user!.userAccount!.toLowerCase()}',
                    AppTextStyle.default_16)
              ],
            ),
            Container(
              width: AppSize.secondButtonWidth,
              child: TextButton(
                  onPressed: () async {
                    var result = await AppDialog.showPopup(
                        context,
                        buildTowButtonDialogContents(
                            context,
                            AppSize.singlePopupHeight,
                            Container(
                                height: AppSize.singlePopupHeight -
                                    AppSize.buttonHeight,
                                alignment: Alignment.center,
                                child: AppStyles.text(
                                    //빌드옵션 앱 NAME
                                    'SalesWorX ${tr('is_ready_to_logout')}',
                                    AppTextStyle.default_16)),
                            successButtonText: '${tr('ok')}',
                            successTextColor: AppColors.primary,
                            faildButtonText: '${tr('cancel')}'));
                    if (result != null) {
                      print('not null');
                      CacheService.deleteUserInfoWhenSignOut();
                      final p = context.read<SettingsProvider>();
                      await p.signOut();
                      print('singout');
                      Navigator.pushNamedAndRemoveUntil(
                          context, CommonLoginPage.routeName, (route) => false);
                    }
                  },
                  style: AppStyles.getButtonStyle(
                      AppColors.primary,
                      AppColors.whiteText,
                      AppTextStyle.default_14,
                      AppSize.radius4),
                  child: Text(
                    '${tr('signout')}',
                  )),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: AppSize.defaultListItemSpacing))
      ],
    );
  }

  Widget _buildItemRow(BuildContext context, String text) {
    return Row(
      children: [AppStyles.text('$text', AppTextStyle.w500_16), Spacer()],
    );
  }

  Widget _buildVersionRow(BuildContext context, CheckUpdateModel versionInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppStyles.text('${tr('version_info')}', AppTextStyle.w500_16),
        Padding(padding: EdgeInsets.only(left: AppSize.versionInfoSpacing1)),
        AppStyles.text('${versionInfo.currentVersion}', AppTextStyle.hint_16),
        Padding(padding: EdgeInsets.only(left: AppSize.versionInfoSpacing2)),
        versionInfo.result == 'OK'
            ? Container(
            width: AppSize.secondButtonWidth,
            child: TextButton(
                onPressed: () {
                  CheckUpdateAndNoticeService.check(
                      context, CheckType.UPDATE_ONLY, false);
                },
                style: AppStyles.getButtonStyle(
                    AppColors.primary,
                    AppColors.whiteText,
                    AppTextStyle.default_14,
                    AppSize.radius4),
                child: Text(
                  '${tr('do_update')}',
                )))
            : AppStyles.text(
            '${tr('is_latest_version')}', AppTextStyle.default_14),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.read<SettingsProvider>();
    return BaseLayout(
        hasForm: true,
        appBar: MainAppBar(context,
            titleText:
                AppStyles.text('${tr('settings')}', AppTextStyle.w500_20)),
        child: FutureBuilder<SettingsResult>(
            future: p.init(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done &&
                  snapshot.data!.isSuccessful) {
                return Column(
                  children: [
                    Padding(
                        padding: AppSize.settingPageTopWidgetPadding,
                        child: _buildNameRow(context, snapshot.data!)),
                    Divider(
                        color: AppColors.textGrey,
                        height: AppSize.dividerHeight),
                    InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, SendSuggestionPage.routeName),
                        child: Padding(
                            padding: AppSize.listPadding,
                            child: _buildItemRow(
                                context, '${tr('send_suggestion')}'))),
                    Divider(
                        color: AppColors.textGrey,
                        height: AppSize.dividerHeight),
                    Padding(
                        padding: snapshot.data!.updateInfo!.result != 'NG'
                            ? AppSize.versionRowPadding
                            : AppSize.listPadding,
                        child: _buildVersionRow(
                            context, snapshot.data!.updateInfo!)),
                    Divider(
                        color: AppColors.textGrey,
                        height: AppSize.dividerHeight),
                  ],
                );
              }
              return Container();
            }));
  }
}
