BEGIN {
    qsv_autoindex()
}!
function stem_word(word)
    local endings = {"ing", "ly", "ed", "s"}
    for _, ending in ipairs(endings) do
        if word:sub(-#ending) == ending then
            return word:sub(1, -#ending-1)
        end
    end
    return word
end

-- Stem each word in the 'text' column
return stem_word(col["text"])
