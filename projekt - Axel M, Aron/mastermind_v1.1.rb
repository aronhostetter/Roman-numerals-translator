def pick_secret_number()
    numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    validity = false
    while validity == false 
        i = 0
        validity = true
        secret_num = gets.chomp
        if secret_num.length != 4
            puts "input must be of length 4 but was instead of length #{secret_num.length}"
            puts "please enter a new secret number"
            validity = false
        else 
            while i < secret_num.length && validity == true
                j = 0
                if !(numbers.include?(secret_num[i]))
                    puts "only integers can be used as input but #{secret_num[i]} was a part of #{secret_num}"
                    puts "please enter a new secret number"
                    validity = false
                else 
                    while j < i && validity == true
                        if secret_num[j] == secret_num[i]
                            puts "secret number must not have repeated digits but #{secret_num} was inputed"
                            puts "please enter a new secret number"
                            validity = false
                        else 
                            j += 1
                        end
                    end
                end
                i += 1
            end
        end
    end  
    return secret_num
end

# def remove_from_string(string, i)
#     if i != 0
#         string = string[0..i-1] + string[i+1..string.length-1]
#     else
#         string = string[1..string.length-1]
#     end
#     return string
# end

# kanske är bättre att kalla denna funktionen för score() eller något liknande, får se.
def respons(guess, secret_number)
    score = 0
    i = 0
    while i < guess.length
        if secret_number[i] == guess[i]
            # secret_number = remove_from_string(secret_number, i)
            # guess = remove_from_string(guess, i)
            score += 10
        elsif secret_number.include?(guess[i])
            j = 0
            while j < secret_number.length
                if secret_number[j] == guess[i]
                    # secret_number = remove_from_string(secret_number, j)
                    # guess = remove_from_string(guess, i)
                    score += 1
                end
                j += 1
            end
        end
        i += 1
    end
    return score
end


def validity_check(string)
    i = 0
    if string.length != 4
        return false
    end
    while i < string.length - 1
        if string[1..string.length - 1].include?(string[i])
            return false
        end
        i += 1
    end
    return true
end

def play_Mastermind()
    puts "Var vänlig och välj ett hemligt nummer"
    puts "Nummret måste bestå av fyra unika siffror"
    secret_num = pick_secret_number()
    old_guess = [1023, respons("1023", secret_num)]
    while old_guess[1] != 40
        p old_guess
        new_guess = old_guess[0] + 1

        while !(validity_check("#{new_guess}")) || (respons("#{new_guess}", "#{old_guess[0]}") != old_guess[1])
            new_guess += 1
        end
        
        old_guess[0] = new_guess
        old_guess[1] = respons("#{old_guess[0]}", secret_num)
    end
end

# play_Mastermind()

# p validity_check("1234")sti
string = "1234"
p string[1..string.length - 1]

# string = "12345"
# p string[0..0] + string[3..4]

 