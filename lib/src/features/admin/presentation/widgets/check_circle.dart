part of 'package:point_marketing/src/features/admin/presentation/admin_page.dart';

class _CheckCircle extends StatefulWidget {
  const _CheckCircle({super.key});

  @override
  State<_CheckCircle> createState() => _CheckCircleState();
}

class _CheckCircleState extends State<_CheckCircle> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: isChecked
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              ],
            )
          : Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
    );
  }
}
