part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class LoadAccounts extends AccountEvent {
  LoadAccounts();
}

class AddAccount extends AccountEvent {
  final Account account;
  
  AddAccount({required this.account});
}