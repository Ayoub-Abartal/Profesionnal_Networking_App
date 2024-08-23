import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

/// Returns a comment section to be used in the bottom of the broadcast screen
class AddCommentSection extends StatelessWidget {
  const AddCommentSection({Key? key, required this.focus}) : super(key: key);
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      child: SizedBox(
        width: aWidth(100, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: aWidth(70, context),
              child: MetinTextField(
                focusNode: focus,
                inputTextStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
                hintText: "Your message",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.circlePlus,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            MetinIconButton(
                height: aHeight(2.3, context),
                backgroundColor: Colors.transparent,
                iconColor: Colors.white,
                icon: FontAwesomeIcons.paperPlane)
          ],
        ),
      ),
    );
  }
}
