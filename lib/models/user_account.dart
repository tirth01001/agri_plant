
enum Profile {
  name,
  mobile,
  emailaddress,
  address,
  dp,
}


class UserAccount {

  final String uid;
  final Map<Profile,dynamic> profile;
  final List<dynamic> bookmarkedProductIDs;
  final List<dynamic> cartProductIds;
  final List<dynamic> userAddress;

  UserAccount(this.uid,this.profile,this.bookmarkedProductIDs,this.cartProductIds,this.userAddress);

  UserAccount.emptyClass({
    this.bookmarkedProductIDs=const[],
    this.cartProductIds=const[],
    this.profile=const{},
    this.uid="",
    this.userAddress=const[],
  });

  bool get isModelEmpty => (uid.isNotEmpty && profile.isEmpty) ?
    false : true;

  bool isProductInCart(String productID) {
    int a = cartProductIds.indexWhere((ele) => ele==productID);
    return a != -1;
  }

}