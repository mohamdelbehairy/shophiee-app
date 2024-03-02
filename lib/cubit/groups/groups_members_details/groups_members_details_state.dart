part of 'groups_members_details_cubit.dart';

@immutable
sealed class GroupsMembersDetailsState {}

final class GroupsMembersDetailsInitial extends GroupsMembersDetailsState {}

final class RemoveMemebrLoading extends GroupsMembersDetailsState {}

final class RemoveMemberSuccess extends GroupsMembersDetailsState {}

final class RemoveMemberFailure extends GroupsMembersDetailsState {
  final String errorMessage;

  RemoveMemberFailure({required this.errorMessage});
}
final class AddMemebrLoading extends GroupsMembersDetailsState {}

final class AddMemberSuccess extends GroupsMembersDetailsState {}

final class AddMemberFailure extends GroupsMembersDetailsState {
  final String errorMessage;

  AddMemberFailure({required this.errorMessage});
}
