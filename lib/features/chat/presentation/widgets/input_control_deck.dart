import 'package:flutter/material.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/presentation/widgets/atomic/atom_button.dart';
import '../../../../core/presentation/widgets/atomic/atom_input.dart';
import '../../../../core/presentation/widgets/effects/frosted_glass.dart';

class InputControlDeck extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSendMessage;
  final VoidCallback onShowStatus;
  final bool isLoading;

  const InputControlDeck({
    super.key,
    required this.textController,
    required this.onSendMessage,
    required this.onShowStatus,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedGlass(
      blur: DesignTokens.blurHeavy,
      color: DesignTokens.black30a,
      border: const Border(
        top: BorderSide(color: DesignTokens.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        child: Column(
          children: [
            // 状态按钮行
            Row(
              children: [
                AtomButton(
                  variant: AtomButtonVariant.icon,
                  icon: Icons.add_circle_outline,
                  onPressed: () {},
                  tooltip: 'Add attachment',
                ),
                AtomButton(
                  variant: AtomButtonVariant.icon,
                  icon: Icons.image_outlined,
                  onPressed: () {},
                  tooltip: 'Add image',
                ),
                AtomButton(
                  variant: AtomButtonVariant.icon,
                  icon: Icons.favorite_border,
                  onPressed: onShowStatus,
                  tooltip: 'Show Status',
                ),
                const Spacer(),
                AtomButton(
                  variant: AtomButtonVariant.icon,
                  icon: Icons.more_horiz,
                  onPressed: () {},
                  tooltip: 'More options',
                ),
              ],
            ),
            
            const SizedBox(height: DesignTokens.spacingSm),
            
            // 输入行
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: AtomInput(
                    controller: textController,
                    hintText: 'Send a message...',
                    maxLines: 5,
                    minLines: 1,
                    onSubmitted: (_) => onSendMessage(),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                AtomButton(
                  variant: AtomButtonVariant.primary,
                  size: AtomButtonSize.large,
                  icon: Icons.send,
                  onPressed: onSendMessage,
                  isLoading: isLoading,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
