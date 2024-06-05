-- Porter Stemmer algorithm

function porter_stem(word)
    local function is_consonant(word, i)
        local ch = word:sub(i, i)
        if ch == 'a' or ch == 'e' or ch == 'i' or ch == 'o' or ch == 'u' then
            return false
        end
        if ch == 'y' then
            if i == 1 then return true end
            return not is_consonant(word, i - 1)
        end
        return true
    end

    local function measure(word)
        local n = 0
        local i = 1
        local length = #word
        while i <= length do
            if not is_consonant(word, i) then break end
            i = i + 1
        end
        i = i + 1
        while i <= length do
            while i <= length and is_consonant(word, i) do i = i + 1 end
            i = i + 1
            while i <= length and not is_consonant(word, i) do i = i + 1 end
            if i <= length then n = n + 1 end
            i = i + 1
        end
        return n
    end

    local function contains_vowel(word)
        for i = 1, #word do
            if not is_consonant(word, i) then
                return true
            end
        end
        return false
    end

    local function ends_with(word, s)
        return word:sub(-#s) == s
    end

    local function set_to(word, s)
        return word:sub(1, #word - #s) .. s
    end

    local function step1a(word)
        if ends_with(word, "sses") then
            return word:sub(1, -3)
        elseif ends_with(word, "ies") then
            return word:sub(1, -3) .. "i"
        elseif word:sub(-1) == "s" and not ends_with(word, "ss") then
            return word:sub(1, -2)
        end
        return word
    end

    local function step1b(word)
        local did_change = false
        if ends_with(word, "eed") then
            if measure(word:sub(1, -4)) > 0 then
                word = word:sub(1, -2)
                did_change = true
            end
        elseif (ends_with(word, "ed") and contains_vowel(word:sub(1, -3))) then
            word = word:sub(1, -3)
            did_change = true
        elseif (ends_with(word, "ing") and contains_vowel(word:sub(1, -4))) then
            word = word:sub(1, -4)
            did_change = true
        end

        if did_change then
            if ends_with(word, "at") or ends_with(word, "bl") or ends_with(word, "iz") then
                word = word .. "e"
            elseif word:sub(-1) == word:sub(-2, -2) and word:sub(-1) ~= "l" and word:sub(-1) ~= "s" and word:sub(-1) ~= "z" then
                word = word:sub(1, -2)
            elseif measure(word) == 1 and ends_with(word, "cvc") then
                word = word .. "e"
            end
        end

        return word
    end

    local function step1c(word)
        if ends_with(word, "y") and contains_vowel(word:sub(1, -2)) then
            return word:sub(1, -2) .. "i"
        end
        return word
    end

    local function step2(word)
        local suffixes = {
            ["ational"] = "ate", ["tional"] = "tion", ["enci"] = "ence",
            ["anci"] = "ance", ["izer"] = "ize", ["abli"] = "able",
            ["alli"] = "al", ["entli"] = "ent", ["eli"] = "e",
            ["ousli"] = "ous", ["ization"] = "ize", ["ation"] = "ate",
            ["ator"] = "ate", ["alism"] = "al", ["iveness"] = "ive",
            ["fulness"] = "ful", ["ousness"] = "ous", ["aliti"] = "al",
            ["iviti"] = "ive", ["biliti"] = "ble"
        }
        for suffix, replacement in pairs(suffixes) do
            if ends_with(word, suffix) and measure(word:sub(1, -#suffix-1)) > 0 then
                return set_to(word, replacement)
            end
        end
        return word
    end

    local function step3(word)
        local suffixes = {
            ["icate"] = "ic", ["ative"] = "", ["alize"] = "al",
            ["iciti"] = "ic", ["ical"] = "ic", ["ful"] = "",
            ["ness"] = ""
        }
        for suffix, replacement in pairs(suffixes) do
            if ends_with(word, suffix) and measure(word:sub(1, -#suffix-1)) > 0 then
                return set_to(word, replacement)
            end
        end
        return word
    end

    local function step4(word)
        local suffixes = {
            "al", "ance", "ence", "er", "ic", "able", "ible",
            "ant", "ement", "ment", "ent", "ion", "ou", "ism",
            "ate", "iti", "ous", "ive", "ize"
        }
        for _, suffix in ipairs(suffixes) do
            if ends_with(word, suffix) and measure(word:sub(1, -#suffix-1)) > 1 then
                if suffix == "ion" then
                    local stem = word:sub(1, -#suffix-1)
                    if stem:sub(-1) == "s" or stem:sub(-1) == "t" then
                        return stem
                    end
                else
                    return word:sub(1, -#suffix-1)
                end
            end
        end
        return word
    end

    local function step5a(word)
        if ends_with(word, "e") then
            local stem = word:sub(1, -2)
            if measure(stem) > 1 or (measure(stem) == 1 and not ends_with(stem, "cvc")) then
                return stem
            end
        end
        return word
    end

    local function step5b(word)
        if measure(word) > 1 and word:sub(-1) == word:sub(-2, -2) and word:sub(-1) == "l" then
            return word:sub(1, -2)
        end
        return word
    end

  
    word = step1a(word)
    word = step1b(word)
    word = step1c(word)
    word = step2(word)
    word = step3(word)
    word = step4(word)
    word = step5a(word)
    word = step5b(word)

    return word
end


local stemmed_word = porter_stem(col["text"])
return stemmed_word
