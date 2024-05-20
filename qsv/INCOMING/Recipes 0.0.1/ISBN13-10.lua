--[[
Usage:
1. Before running the recipe, make sure to enter the column index which contains the ISBN-10 numbers in the code.
2. Use the following qsv command to convert ISBN-10 numbers to ISBN-13 format and add them as a new column named 'ISBN-13' in the CSV:
   
    qsv luau map 'ISBN-13' isbn_conversion.luau filename.csv -o newfile.csv
    
   - Replace 'isbn_conversion.luau' with the filename of this Lua script.
   - Replace 'filename.csv' with the name of your input CSV file.
   - The '-o' option is used to specify the output filename ('newfile.csv' in this example).

3. When you have the file and the recipe in different file locations
        
        qsv luau map 'ISBN-13' file:<Path of this recipe> filename.csv -o newfile.csv
    
        When you need real-time preview of the csv file 

        qsv luau map 'ISBN-13' isbn_conversion.luau filename.csv | qsv table
Example:
Suppose the input CSV file 'books.csv' contains a column 'ISBN-10' which contains ISBN-10 numbers. To convert these ISBN-10 numbers to ISBN-13 format and add them as a new column named 'ISBN-13' in the CSV, use the following command:
qsv luau map 'ISBN-13' isbn_conversion.luau books.csv -o books_with_isbn13.csv
]]

BEGIN {
    qsv_autoindex()
}!

-- Function to calculate the check digit for ISBN-10
function calculate_check_digit(isbn)
    local sum = 0
    for i = 1, 9 do
        sum = sum + tonumber(isbn:sub(i, i)) * (11 - i)
    end
    local remainder = sum % 11
    local check_digit = (11 - remainder) % 11
    return (check_digit == 10) and "X" or tostring(check_digit)
end

-- Function to convert ISBN-13 to ISBN-10
function isbn13_to_isbn10(isbn13)
    if not isbn13 or isbn13 == "" then
        return ""  -- Return empty string if ISBN-13 is missing
    end
    -- Remove the prefix (978 or 979) and the last digit (check digit)
    local isbn10_prefix = isbn13:sub(4, 12)
    -- Calculate the check digit for ISBN-10
    local check_digit = calculate_check_digit(isbn10_prefix)
    -- Return the ISBN-10 code
    return isbn10_prefix .. check_digit
end

-- Calculate ISBN-10 from ISBN-13 and add to a new column
local isbn13 = col["isbn"]
local isbn10 = isbn13_to_isbn10(isbn13)
return isbn10
