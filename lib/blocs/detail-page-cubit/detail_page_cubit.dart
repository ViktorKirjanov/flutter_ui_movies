// import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part 'detail_page_state.dart';

enum DetailPageState { dismissed, completed }

class DetailPageCubit extends Cubit<DetailPageState> {
  DetailPageCubit() : super(DetailPageState.dismissed);

  void forward() {
    emit(DetailPageState.completed);
  }

  void reverse() {
    emit(DetailPageState.dismissed);
  }
}
