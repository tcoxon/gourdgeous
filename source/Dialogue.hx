package;

class Answer {
    public var text: String;
    public var score: Int;
    public var response: String;

    public function new(text: String, score: Int, response: String) {
        this.text = text;
        this.score = score;
        this.response = response;
    }
}

class Question {
    public var text: String;
    public var simpleText: String;
    public var answers: Array<Answer>;

    public function new(text: String, simpleText: String, answers: Array<Answer>) {
        this.text = text;
        this.simpleText = simpleText;
        this.answers = answers;
    }
}

class Dialogue {

    public static inline var BEST_ENDING = 
        "Hey, why don't we go back to your porch and you pop your candle inside me?";
    public static inline var MIDDLE_ENDING =
        "Thanks for meeting me. I had a nice time, but I didn't feel the 'click'.";
    public static inline var WORST_ENDING =
        "I don't think we're compatible. At all. Sorry.";
    public static inline var OUT_OF_TIME_ENDING =
        "Well, I've got lots to do this evening, so I had better get going. Nice meeting you.";
    
    public static var QUESTIONS: Array<Question> = [
        new Question(
            "Nice to meet you!\nMy friend said you were pretty cool, but not what your name is.\nWhat shall I call you?",
            "What is your name?",
            [
                new Answer(
                    "Player1", 20,
                    "That's a nice name."
                ),
                new Answer(
                    "Jack O'lantern", -10,
                    "Is that a made-up name?"
                ),
                new Answer(
                    "Cucurbita", -10,
                    "I don't get it. Why would you give my name instead? Is that a joke?"
                ),
                new Answer(
                    "Player", -50,
                    "Oh, you're one of those people."
                ),
            ]),
        new Question(
            "Oh! You brought me a gift... How thoughtful!\nWhat is it?",
            "What is the gift?",
            [
                new Answer(
                    "Pumpkin pie", -20,
                    "What's wrong with you?\nThat's really insensitive!"
                ),
                new Answer(
                    "Dead mouse", 10,
                    "Delicious! Thank you very much!"
                ),
                new Answer(
                    "Flowers", -10,
                    "I don't get it. Are they edible?"
                ),
                new Answer(
                    "Chocolate", -10,
                    "No thanks, chocolate is poisonous to me."
                )
            ]),
        new Question(
            "So... I don't know anything about you. What do you like doing?",
            "What do you like doing?",
            [
                new Answer(
                    "Video games", -20,
                    "That's sad. Why don't you just watch TV like a normal person?\nGet a life!"
                ),
                new Answer(
                    "Collecting dust", 10,
                    "Me too! After Halloween, of course!"
                ),
                new Answer(
                    "Farming", -10,
                    "I bet you say that to all the pumpkins, huh."
                ),
                new Answer(
                    "Eating pumpkin", 20,
                    "Hehe... Maybe later..."
                ),
            ]),
    ];

}
