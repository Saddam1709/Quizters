import Quizzes "quizzes";
import Questions "questions";
import IdGenerator "id_generator";
import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Types "types";

actor App {
  // Initialize the ID generator
  let idGenerator = IdGenerator.IdGenerator();

  // Initialize the QuizzesManager and QuestionsManager
  let quizzesManager = Quizzes.QuizzesManager(idGenerator);
  let questionsManager = Questions.QuestionsManager(idGenerator);

  // Create a new quiz
  public shared ({ caller }) func createQuiz(title : Text, description : Text, maxScore : Nat) : async Text {
    return await quizzesManager.createQuiz(title, description, caller, maxScore);
  };

  // Add a question to a quiz
  public shared ({ caller }) func addQuestion(quizId : Text, question : Text) : async Text {
    return await quizzesManager.addQuestion(quizId, question);
  };

  // Add an answer to a question
  public shared ({ caller }) func addAnswer(questionId : Text, value : Text, isCorrect : Bool) : async Text {
    return await questionsManager.addAnswer(questionId, value, isCorrect);
  };

  // Get a quiz by its ID
  public shared query func getQuiz(quizId : Text) : async ?Types.Quiz {
    return quizzesManager.getQuiz(quizId);
  };

  // Get all quizzes
  public shared query func getAllQuizzes() : async [Types.Quiz] {
    return quizzesManager.getAllQuizzes();
  };
};