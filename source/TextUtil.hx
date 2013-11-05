using StringTools;

class TextUtil {

    public static function chars(str: String): Array<String> {
        var result = [];
        for (i in 0...str.length) {
            result.push(str.charAt(i));
        }
        return result;
    }

    public static function splitWords(text:String): Array<String> {
        var words: Array<String> = [];
        var current = "";
        for (i in 0...text.length) {
            var c = text.charAt(i);

            if (c.isSpace(0) && current.trim() != "") {
                words.push(current);
                current = "";
            }

            if (c == "\n")
                words.push("\n");
            else
                current += c;
        }
        if (current.trim() != "")
            words.push(current);
        return words;
    }

    public static function wrapWords(text: String, cols: Int): Array<String> {
        var words: Array<String> = splitWords(text),
            lines: Array<String> = [],
            current: String = "";
        
        var i = 0;
        while (i < words.length) {
            var word: String = words[i];

            if (word == "\n") {
                // New line
                lines.push(current);
                current = "";
            } else if (current.length + word.length <= cols) {
                // word fits on the line
                current += word;
            } else if (current.length < cols-1 && word.length > cols) {
                // word doesn't fit on the line, and won't fit on the next
                // either, so break it up
                var spaceLeft: Int = cols - current.length;
                current += word.substr(0, spaceLeft-1);
                current += "-";

                words[i] = word.substr(spaceLeft-1, word.length-spaceLeft+1);
                --i;
            } else {
                lines.push(current);
                if (word.charAt(0) == "\n" || word.charAt(0) == " ")
                    word = word.substr(1, word.length-1);
                
                if (word.length > cols) {
                    // word won't fit ont he new line, so break it up
                    current = word.substr(0, cols-1);
                    current += "-";

                    words[i] = word.substr(cols-1, word.length-cols+1);
                    --i;
                } else {
                    current = word;
                }
            }
            ++i;
        }

        if (current != "")
            lines.push(current);

        return lines;
    }

}
