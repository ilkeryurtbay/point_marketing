part of 'package:point_marketing/src/features/admin/presentation/admin_page.dart';

class _AppBarBackButton extends StatelessWidget {
  const _AppBarBackButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: context.mainThemeColor,
      ),
    );
  }
}
