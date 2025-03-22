import Time "mo:base/Time";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Nat32 "mo:base/Nat32";
import Types "types";

module {
  public class ScoreManager() {
    private var scores = HashMap.HashMap<Nat, Types.UserQuizScore>(0, Nat.equal, func(n : Nat) : Nat32 { Nat32.fromNat(n) });
    private var nextScoreId : Nat = 1;

    // Submit a new score
    public func submitScore(userId : Principal, quizId : Nat, score : Nat) : Nat {
      let scoreId = nextScoreId;
      nextScoreId += 1;
      let s : Types.UserQuizScore = {
        id = scoreId;
        userId = userId; // Use Principal for userId
        quizId = quizId;
        score = score;
        createdAt = Time.now();
        updatedAt = Time.now();
      };
      scores.put(scoreId, s);
      return scoreId;
    };

    // Get a user's score for a specific quiz
    public func getUserScore(userId : Principal, quizId : Nat) : ?Types.UserQuizScore {
      for ((_, s) in scores.entries()) {
        if (s.userId == userId and s.quizId == quizId) {
          return ?s;
        };
      };
      return null;
    };

    // Get all scores
    public func getAllScores() : [Types.UserQuizScore] {
      return Iter.toArray(scores.vals());
    };
  };
};