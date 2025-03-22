import Time "mo:base/Time";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";

module {
  public class IdGenerator() {

    private func whoami_internal(caller : Principal) : Principal {
      caller;
    };

    // Generate a globally unique ID
    public func randomId() : async Text {

      var timeNow = Time.now() / 1_000_000_000;

      return "qztrs" # "-" # Int.toText(timeNow);
    };
  };
};