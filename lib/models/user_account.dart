
enum Profile {
  name,
  mobile,
  address,
  dp,
}


class UserAccount {

  final String uid;
  final Map<Profile,dynamic> profile;
  final List<dynamic> bookmarkedProductIDs;
  final List<dynamic> cartProductIds;

  UserAccount(this.uid,this.profile,this.bookmarkedProductIDs,this.cartProductIds);

  UserAccount.emptyClass({
    this.bookmarkedProductIDs=const[],
    this.cartProductIds=const[],
    this.profile=const{},
    this.uid=""
  });

  bool get isModelEmpty => (uid.isNotEmpty && profile.isEmpty) ?
    false : true;

  bool isProductInCart(String productID) {
    int a = cartProductIds.indexWhere((ele) => ele==productID);
    return a != -1;
  }

}