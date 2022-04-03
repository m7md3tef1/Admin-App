abstract class DataProductState{}
class InitialStateData extends DataProductState{}


class GetDataLoading extends DataProductState{}
class GetDataSuccess extends DataProductState{}

class GetDataFailed extends DataProductState{
  final String error;

  GetDataFailed(this.error);
}