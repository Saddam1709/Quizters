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
import Debug "mo:base/Debug";

module {
  public class QuestionsManager(idGenerator : IdGenerator.IdGenerator) {
    private var questions = HashMap.HashMap<Text, Types.Question>(0, Text.equal, Text.hash); // Use Text for IDs

    // Add an answer to a question
    public func addAnswer(questionId: Text, value: Text, isCorrect: Bool): async Text {
      Debug.print("Checking questionId: " # questionId);
      Debug.print("Current stored questions: " # debug_show(Iter.toArray(questions.entries())));

      switch (questions.get(questionId)) {
        case (?question) {
          let answerId: Text = await idGenerator.randomId(); // Generate unique ID
          let newAnswer: Types.Answer = {
            id = answerId;
            questionId = questionId;
            value = value;
            isCorrect = isCorrect;
            createdAt = Time.now();
            updatedAt = Time.now();
          };

          let updatedQuestion: Types.Question = {
            id = question.id;
            quizId = question.quizId;
            question = question.question;
            choices = Array.append(question.choices, [newAnswer]); // Append new answer
            createdAt = question.createdAt;
            updatedAt = Time.now();
          };

          Debug.print("Adding answer: " # debug_show(newAnswer));
          Debug.print("Updated question: " # debug_show(updatedQuestion));

          questions.put(questionId, updatedQuestion);
          return answerId;
        };
        case null {
          Debug.print("❌ Question ID not found: " # questionId);
          return "❌ Question ID not found: " # questionId;
        };
      };
    };

    // Get a question by its ID
    public func getQuestion(questionId : Text) : ?Types.Question {
      return questions.get(questionId);
    };

    // Get all questions for a specific quiz
    public func getQuizQuestions(quizId : Text) : [Types.Question] {
      return Iter.toArray(
        Iter.filter(
          questions.vals(),
          func(q : Types.Question) : Bool {
            return q.quizId == quizId;
          },
        )
      );
    };
  };
};
