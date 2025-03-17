import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shopbloc_event.dart';
part 'shopbloc_state.dart';

class ShopblocBloc extends Bloc<ShopblocEvent, ShopblocState> {
  ShopblocBloc() : super(ShopblocInitial()) {
    on<ShopblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
