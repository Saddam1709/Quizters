import Time "mo:base/Time";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Nat32 "mo:base/Nat32";
import Iter "mo:base/Iter";
import Types "types";

module {
  public class UserManager() {
    private var users = HashMap.HashMap<Principal, Types.User>(0, Principal.equal, Principal.hash);
    private var nextUserId : Nat = 1;

    // Create a new user
    public func createUser(id : Principal, username : Text) : Principal {
      let user : Types.User = {
        id = id; // Use Principal for id
        username = username; // Add username field
        createdAt = Time.now();
        updatedAt = Time.now();
      };
      users.put(id, user);
      return id;
    };

    // Get a user by their Principal (id)
    public func getUser(id : Principal) : ?Types.User {
      return users.get(id);
    };

    // Get all users
    public func getAllUsers() : [Types.User] {
      return Iter.toArray(users.vals());
    };
  };
};