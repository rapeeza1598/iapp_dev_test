import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<LoadAccounts>(_onLoadAccount);
    on<AddAccount>(_onAddAccount);
  }

  void _onLoadAccount(LoadAccounts event, Emitter<AccountState> emit) {
    emit(AccountLoading());
  }

  void _onAddAccount(AddAccount event, Emitter<AccountState> emit) {
    emit(AccountLoaded(accounts: [event.account]));
  }
}

class GetAccountEvent extends AccountEvent {
}

class AccountLoaded extends AccountState {
  final List<Account> accounts;
  AccountLoaded({required this.accounts});
}
