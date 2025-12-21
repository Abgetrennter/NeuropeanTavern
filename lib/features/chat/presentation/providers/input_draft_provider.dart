import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputDraftState {
  final String text;

  InputDraftState({this.text = ''});

  InputDraftState copyWith({String? text}) {
    return InputDraftState(text: text ?? this.text);
  }
}

class InputDraftNotifier extends StateNotifier<InputDraftState> {
  InputDraftNotifier() : super(InputDraftState());

  void updateText(String newText) {
    state = state.copyWith(text: newText);
  }

  void clear() {
    state = state.copyWith(text: '');
  }

  // 模拟从 UI 状态栏接收指令
  void appendCommand(String command) {
    final current = state.text;
    final separator = current.isNotEmpty && !current.endsWith(' ') ? ' ' : '';
    state = state.copyWith(text: '$current$separator$command');
  }
}

final inputDraftProvider = StateNotifierProvider<InputDraftNotifier, InputDraftState>((ref) {
  return InputDraftNotifier();
});