### Roman to arabic ###

#   Namn:           fault_check
#   Beskrivning:	Kollar igenom inputsträngen och validerar den utifrån tre punkter. Den kollar så att input är av rätt klass, att det inte finns fler än tre lika tal efter varann och dessutom att bokstäverna i input finns med i det romerska talsystemet.
#   Argument 1:     Array - Inputsträngen för main funktionen.
#   Return:         Array - Inputsträngen om den är giltig, annars felmeddelanden.
#   
#   Exempel:
#   1:              "XXII" #=> "XXII"
#   2:              "CXLIII" #=> "CXLIII"
#   3:              "CXLIIII" #=> Syntax Error --> "Du kan inte ha fler än tre lika bokstäver i rad. Vänligen ändra på bokstav nummer: #{i+1},#{i+2},#{i+3} eller #{i+4}."
#   4:              "IYZ" #=> Syntax Error --> " kan inte ha fler än tre lika bokstäver i rad"
#   5:              ["C","X","L","I","I","I"] #=> Syntax Error --> "Inputen måste vara en string men var en #{string.class}"
#                   
#   By:				Axel Manns & Aron Hostetter
#   Date:			2022-04-26

def fault_check(string)
    if string.class != String
        raise "Inputen måste vara en string men var en #{string.class}"
    elsif string == "I"
        puts "E DU GO ELLE?!?!?!??!"
        puts "DU BEHÖVER LA INTE ÖVERSÄTTA DEEEET????"
    end

    roman_numerals = ["M","D","C","L","X","V","I"] 
    i = 0
    while i < string.length
        if string[i] ==  string[i+1] && string[i] == string[i+2] && string[i] == string[i+3]
            raise "Du kan inte ha fler än tre lika bokstäver i rad. Vänligen ändra på bokstav nummer: #{i+1},#{i+2},#{i+3} eller #{i+4}."
        elsif !(roman_numerals.include?(string[i]))
            raise "Enbart romerska tal får inputas. #{string[i]} i strängen #{string} är inget romerskt tal"
        end
    i += 1
    end
end

def roman_str_to_arabic_array(string)
    roman_numerals = [["M", 1000], ["D", 500], ["C", 100], ["L", 50], ["X", 10], ["V", 5], ["I", 1]]
    arabic = []
    i = 0
    while i < string.length
        j = 0
        while string[i] != roman_numerals[j][0] && j < roman_numerals.length
            j += 1
        end
        arabic.append(roman_numerals[j][1])
        i += 1
    end
    return arabic
end

#   Namn:           shorten
#   Beskrivning:	adderar alla identiska element som är brevid varandra i input arrayen. Låter tal som iix interpreteras som 10 - 2 istället för 1 + 10 - 1.
#   Argument 1:     Array - En array med integers.
#   Return:         Array - Förkortade arrayen med integers.
#   
#   Exempel:
#   1:              [10, 30, 2] #=> [10, 30, 2]
#   2:              [10, 10, 2] #=> [20, 2]
#   3:              [2, 2, 2, 2, 2, 10] #=> [10, 10]
#   4:              [30, 90, 40, 90, 90] #=> [30, 90, 40, 180]
#                   
#   By:				Axel Manns & Aron Hostetter
#   Date:			2022-04-26

def shorten(array)
    i = 0
    j = 0
    temp_sum = 0
    out_array = []
    while i < array.length
        if array.length > i + j && array[i + j] == array[i]
            temp_sum += array[i + j]
            j += 1
        else 
            i += j
            out_array.append(temp_sum)
            temp_sum = 0
            j = 0
        end
    end
    return out_array
end

#   Namn:           roman_to_arabic
#   Beskrivning:	Programmet konverterar romerska räknesättets tecken till arabiska siffror enligt reglern. Programmet kan inte konvertera tal högre än 3999 då det är gränsen för det romerska talsystemet.
#   Argument 1:     String - En sträng av romerska siffror i form av bokstäver.
#   Return:         Integer - Talet som matades in, men konverterat till siffror enligt det arabiska talsystemet.
#   
#   Exempel:
#   1:              "XVI" #=> 16
#   2:              "XVi" #=> 16
#   3:              "IIx" #=> 8
#   4:              "VIII" #=> 8
#   5:              "IIIIV" #=> Syntax Error --> "Du kan inte ha fler än tre lika bokstäver i rad"
#   5:              "IIIIV" #=> Syntax Error --> "Du kan inte ha fler än tre lika bokstäver i rad"
#   5:              "IIIIV" #=> Syntax Error --> "Du kan inte ha fler än tre lika bokstäver i rad"
#                   
#   By:				Axel Manns & Aron Hostetter
#   Date:			2022-04-26

def roman_to_arabic(string)
    string = string.upcase.chomp
    fault_check(string)
    array = shorten(roman_str_to_arabic_array(string))
    sum = 0 
    i = 0
    while i < array.length
        if  i != array.length - 1 && array[i] < array[i+1]
            sum -= array[i]
        else 
            sum += array[i]
        end
        i += 1
    end
    if sum > 3999
        raise "Du försökte konvertera #{string}. De romerska talen kan inte ha högre värde än 3999. Vänligen minska summan #{sum} till mindre än 3999"
    else
        return sum
    end
end

### Arabic to roman ###

def input_validation(string)
    # p string
    if string.to_f != string.to_i || string.to_i <= 0
        raise "inputen måste vara ett positivt heltal större än 0, #{string} uppfyller inte villkoren."
    elsif string.to_i > 3999
        raise "Du försökte konvertera #{string}. De romerska talen kan inte ha högre värde än 3999."
    elsif string == "1"
        puts "E DU GO ELLE?!?!?!??!"
        puts "DU BEHÖVER LA INTE ÖVERSÄTTA DEEEET????"
    end
end

def closest_numeral(num, num_length)
    roman_numerals = [["M", 1000], ["D", 500], ["C", 100], ["L", 50], ["X", 10], ["V", 5], ["I", 1]]
    i = 0
    if num == 0
        return ""
    end
    while (roman_numerals[i][1] - num).abs > 2 * 10**(num_length)
        i += 1
    end
    if num - roman_numerals[i][1] < 0
        return arabic_to_roman("#{num - roman_numerals[i][1]}") + roman_numerals[i][0]
    else
        return roman_numerals[i][0] + arabic_to_roman("#{num - roman_numerals[i][1]}")
    end
end

def arabic_to_roman(string)
    string = string.chomp
    i = 0
    output_str = ""
    while i < string.length
        output_str += closest_numeral(string[i].to_i * 10**(string.length - 1 - i), (string.length - 1 - i))
        i += 1
    end
    return output_str
end 

### Choosing translator ###

def main()
    puts "Hej!, kul att du vill använda vår översättare!"
    puts "Du kommer nu få två val:"
    validity = false
    felmeddelande = ""
    i = 0
    while validity == false && i <= 10
        validity = true
        puts "Skriv #{"1"} om du vill översätta från det romerska siffersystemet till det arabiska"
        puts "Skriv #{"2"} om du vill översätta från det arabiska siffersystemet till det romerska"
        decision = gets.chomp
        if decision == "1"
            puts "Var vänlig och skriv det tal du vill översätta (med siffror från det romerska talsystemet):"
            puts roman_to_arabic(gets)
        elsif decision == "2"
            puts "Var vänlig och skriv det tal du vill översätta (med siffror från det arabiska talsystemet):"
            string = gets.chomp
            input_validation(string)
            puts arabic_to_roman(string)
        elsif i == 10
            puts "E DU GO ELLE?!?!?!??!"
            puts "VILL DU ÄNNA ÖVERSÄTTA ELLER IIINTEEE????"
        else
            validity = false
            puts "Var #{felmeddelande}vänlig och skriv antingen 1 eller 2"
        end
        felmeddelande += "väldigt "
        ### VI VALDE ATT MEDVETET GÖRA SÅ ATT "VÄLDIGT" ÖKAR FÖR VARJE GÅNG ANVÄNDAREN INTE SKRIVER 1 ELLER 2 ###
        i += 1
    end
end

main()