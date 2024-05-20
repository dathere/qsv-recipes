--[[
Usage:
1. Before running the recipe, make sure to enter the column index which contains the names with diacritic characters in the code.
2. Use the following qsv command to replace diacritic characters with English characters and add them as a new column named 'Names' in the CSV:
   
    qsv luau map 'Names' diacritic_to_english.luau filename.csv -o newfile.csv
    
   - Replace 'diacritic_to_english.luau' with the filename of this Lua script.
   - Replace 'filename.csv' with the name of your input CSV file.
   - The '-o' option is used to specify the output filename ('newfile.csv' in this example).

3. When you have the file and the recipe in different file locations
        
        qsv luau map 'Names' file:<Path of this recipe> filename.csv -o newfile.csv
    
        When you need real-time preview of the csv file 

        qsv luau map 'Names' diacritic_to_english.luau filename.csv | qsv table
Example:
Suppose the input CSV file 'people.csv' contains a column 'Name' which contains names with diacritic characters. To replace these diacritic characters with English characters and add them as a new column named 'Names' in the CSV, use the following command:
qsv luau map 'Names' diacritic_to_english.luau people.csv -o people_with_english_names.csv
]]
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
