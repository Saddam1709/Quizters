import Time "mo:base/Time";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Nat32 "mo:base/Nat32";
import Types "types";
import IdGenerator "id_generator";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Error "mo:base/Error";
import Iter "mo:base/Iter";

module {
  public class QuizzesManager(idGenerator : IdGenerator.IdGenerator) {
    private var quizzes = HashMap.HashMap<Text, Types.Quiz>(0, Text.equal, Text.hash); // Use Text for IDs

    // Create a new quiz
    public func createQuiz(title : Text, description : Text, owner : Principal, maxScore : Nat) : async Text {
      let quizId = await idGenerator.randomId(); // Generate a unique quiz ID
      let quiz : Types.Quiz = {
        id = quizId;
        title = title;
        description = description;
        owner = owner;
        questions = []; // Initialize with an empty array of questions
        maxScore = maxScore;
        createdAt = Time.now();
        updatedAt = Time.now();
      };
      quizzes.put(quizId, quiz);
      return quizId;
    };

    // Add a question to a quiz
    public func addQuestion(quizId : Text, question : Text) : async Text {
      switch (quizzes.get(quizId)) {
        case (?quiz) {
          let questionId = await idGenerator.randomId(); // Generate a unique question ID
          let q : Types.Question = {
            id = questionId;
            quizId = quizId;
            question = question;
            choices = []; // Initialize with an empty array of answers
            createdAt = Time.now();
            updatedAt = Time.now();
          };

          let updatedQuiz : Types.Quiz = {
            id = quiz.id;
            title = quiz.title;
            description = quiz.description;
            owner = quiz.owner;
            questions = Array.append(quiz.questions, [q]); // Add the new question
            maxScore = quiz.maxScore;
            createdAt = quiz.createdAt;
            updatedAt = Time.now();
          };
          quizzes.put(quizId, updatedQuiz);
          return questionId;
        };
        case null { return "Error" };
      };
    };

    // Get a quiz by its ID
    public func getQuiz(quizId : Text) : ?Types.Quiz {
      return quizzes.get(quizId);
    };

    // Get all quizzes
    public func getAllQuizzes() : [Types.Quiz] {
      return Iter.toArray(quizzes.vals());
    };
  };
};