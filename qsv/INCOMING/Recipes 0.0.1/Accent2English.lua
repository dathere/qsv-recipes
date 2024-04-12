BEGIN {
    csv_indexed = qsv_autoindex();
}!

local function remove_diacritics(s)
    local normalized_string = s:gsub(
        "[àáâãäåæāăą]", "a"
    ):gsub(
        "[ÀÁÂÃÄÅÆĀĂĄ]", "A"
    ):gsub(
        "[èéêëēĕėęě]", "e"
    ):gsub(
        "[ÈÉÊËĒĔĖĘĚ]", "E"
    ):gsub(
        "[ìíîïĩīĭįı]", "i"
    ):gsub(
        "[ÌÍÎÏĨĪĬĮİ]", "I"
    ):gsub(
        "[òóôõöøōŏő]", "o"
    ):gsub(
        "[ÒÓÔÕÖØŌŎŐ]", "O"
    ):gsub(
        "[ùúûüũūŭůűų]", "u"
    ):gsub(
        "[ÙÚÛÜŨŪŬŮŰŲ]", "U"
    ):gsub(
        "[ýÿŷ]", "y"
    ):gsub(
        "[ÝŸŶ]", "Y"
    ):gsub(
        "[ñ]", "n"
    ):gsub(
        "[Ñ]", "N"
    ):gsub(
        "[çćč]", "c"
    ):gsub(
        "[ÇĆČ]", "C"
    ):gsub(
        "[ß]", "ss"
    ):gsub(
        "[œ]", "oe"
    ):gsub(
        "[Œ]", "OE"
    ):gsub(
        "[æ]", "ae"
    ):gsub(
        "[Æ]", "AE"
    ):gsub(
        "[ð]", "d"
    ):gsub(
        "[Ð]", "D"
    ):gsub(
        "[ďđ]", "d"
    ):gsub(
        "[ĎĐ]", "D"
    ):gsub(
        "[ł]", "l"
    ):gsub(
        "[Ł]", "L"
    ):gsub(
        "[ß]", "ss"
    ):gsub(
        "[Þþ]", "th"
    ):gsub(
        "[\\-]", " "
    )
    
    return normalized_string
end

new_name = remove_diacritics(col.Name)

return {new_name}
