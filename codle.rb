require('set')

def codle(random_word)
    clue = ["", "", "", "", ""]
    index = 0
    max_guesses = 6
    good_characters = Set[]
    bad_characters = Set[]
    remaining_characters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
    current_guess = 1
    while (current_guess != max_guesses)
        clear_screen
        puts('')
        puts('')
        puts colored_center("CODLE - Corey's Ruby version of wordle", 31)
        puts('')
        puts('')
        puts colored_center("Current Guess: " + current_guess.to_s + "/5")
        puts colored_center("-----------------------------------------------")
        puts colored_center("Correct", 32)
        puts colored_center(clue.to_s, 32)
        puts colored_center("-----------------------------------------------")
        puts colored_center("Correct Letters", 33)
        puts colored_center(good_characters.to_a.to_s, 33)
        puts colored_center("-----------------------------------------------")
        puts colored_center("Incorrect Letters", 31)
        puts colored_center(bad_characters.to_a.to_s, 31)
        puts colored_center("-----------------------------------------------")
        puts colored_center("Remaining Characters")
        puts colored_center(remaining_characters.to_s.center(80))
        puts('')
        puts('')
        puts colored_center("Take a guess: ")
        guess = gets.chomp.upcase
        if (guess.length() != 5)
            puts colored_center("-----------------------------------------------")
            puts colored_center("*** Guess must include exactly 5 letters! ***")
            puts colored_center("-----------------------------------------------")
        else 
            guess.each_char do |char| 
                if (random_word.include?(char.upcase))
                    good_characters.add(char.upcase)
                    indexOfKeywordLetter = random_word.index(char)
                    indexOfGuess = guess.index(char)
                    if (indexOfGuess === indexOfKeywordLetter)
                        clue[indexOfKeywordLetter] = char.upcase
                    end
                    result = checkAnswerVsKeyword(guess, random_word)
                    if (result)
                        puts colored_center("-----------------------------------------------")
                        puts colored_center("!!! YOU WIN !!!", 32)
                        puts colored_center("Word: " + random_word)
                        puts colored_center("-----------------------------------------------")
                        return
                    end
                else 
                    bad_characters.add(char.upcase)
                end
                if (remaining_characters.include?(char))
                    remaining_characters.delete_at(remaining_characters.index(char))
                end
            end
            index = index + 1
            current_guess = current_guess + 1
        end
        
    end
    puts colored_center("-----------------------------------------------")
    puts colored_center("*** YOU LOSE ***", 31)
    puts colored_center("Word: " + random_word)
    puts colored_center("-----------------------------------------------")
end

def colored_center(text, color_code = 37)
    "\e[#{color_code}m#{text.center(80)}\e[0m"
end

def checkAnswerVsKeyword(guess, random_word)
    if (random_word === guess)
        return true
    else 
        return false
    end
end

def getCorrectLetterPosition(random_word, letter)
    return random_word.index(letter).to_i
end

def clear_screen
    system("clear") || system("cls")
end

def chooseRandomWord()
    words = [
        "PLANT", "QUEST", "BRAVE", "DITCH", "SCARF", "MOVIE", "WRECK", "TOKEN", "KNIFE", "QUOTE",
        "BLEND", "MAGIC", "HONEY", "CLIMB", "GRANT", "STORM", "NOBLE", "FRUIT", "CROWN", "GLASS",
        "RIVAL", "SLICE", "CHESS", "FLAIR", "SWAMP", "CHARM", "INDEX", "TABLE", "BISON", "VIVID",
        "CRISP", "WALTZ", "BAKER", "FABLE", "GHOST", "TRUCK", "SUSHI", "JELLY", "ZEBRA", "BRICK",
        "LAPSE", "MOUSE", "GIANT", "SMILE", "THIEF", "YEARN", "ROGUE", "DRIFT", "LIMIT", "SHELF",
        "RANCH", "MANGO", "FLUTE", "SKILL", "BUNNY", "REACT", "VOTER", "SHINE", "OLIVE", "QUIET",
        "FLASH", "FROST", "CHALK", "GRIND", "NERVE", "GLOVE", "LASER", "TWIST", "SNACK", "PIZZA",
        "NIGHT", "OCEAN", "SWING", "TRACE", "DIZZY", "HEART", "BRUSH", "WAGON", "TAPES", "JOINT",
        "WHALE", "VAULT", "LATCH", "CABLE", "RAZOR", "DRONE", "POUND", "METAL", "LUNAR", "FAITH",
        "SNOWY", "WIDEN", "BREAD", "ZONED", "KNEEL", "GRUMP", "FEAST", "QUICK", "BREAK", "COREY"
    ]
    return words[rand(1..100)]
end

def main()
    control = false
    while (control != true)
        random_word = chooseRandomWord()
        codle(random_word)
        puts('')
        puts colored_center("Play again [Press Enter]")
        puts colored_center("-- or --")
        puts colored_center("Quit [Q]")
        user_action = gets.chomp.to_s.upcase
        if (user_action === 'Q')
            return control = true
        end
    end
end


main()

