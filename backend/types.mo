import HashMap "mo:base/HashMap";
import Time "mo:base/Time";
import Principal "mo:base/Principal";

module {
  // User Model
  public type User = {
    id : Principal; // jadi principal ini buat dapetin Internet Identity nya ICP
    // role: Role;
    username : Text;
    createdAt : Time.Time;
    updatedAt : Time.Time;
  };

  // Quiz Model
  public type Quiz = {
    id : Text;
    title : Text;
    description : Text;
    owner : Principal;
    /* jadi gak usah pake roles wak, karna scope role owner cm per satu data quiz, nanti bikin logikanya gini aj if User != Quiz.owner then Restrict Edit*/
    questions : [Question]; // Array of question
    maxScore : Nat;
    createdAt : Time.Time;
    updatedAt : Time.Time;
  };

  // Question Model
  public type Question = {
    id : Text;
    quizId : Text; // Link ke id quiz
    question : Text;
    choices : [Answer]; // Array of answers
    createdAt : Time.Time;
    updatedAt : Time.Time;
  };

  public type Answer = {
    id : Text;
    questionId : Text; // Link ke id question
    value : Text;
    isCorrect : Bool;
    createdAt : Time.Time;
    updatedAt : Time.Time;
  };

  // Score Model
  public type UserQuizScore = {
    id : Text;
    userId : Principal;
    quizId : Text; // link ke id quiz
    score : Nat;
    createdAt : Time.Time;
    updatedAt : Time.Time;
  };
};