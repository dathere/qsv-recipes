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
    -- Auto-index the CSV
    qsv_autoindex()
}!

-- Function to convert ISBN-10 to ISBN-13
local function convert_isbn10_to_isbn13(isbn10)
    -- Remove any hyphens or spaces
    isbn10 = isbn10:gsub("[%- ]", "")

    -- Ensure ISBN-10 is 10 characters long
    if #isbn10 ~= 10 then
        return "<ERROR> Invalid ISBN-10 format"
    end

    -- Prepend "978" to the ISBN-10
    local isbn13_prefix = "978"

    -- Extract the first 9 digits of ISBN-10 (excluding the check digit)
    local isbn13_prefix_with_9_digits = isbn13_prefix .. isbn10:sub(1, 9)

    -- Calculate the check digit for ISBN-13
    local sum = 0
    for i = 1, #isbn13_prefix_with_9_digits do
        local digit = tonumber(isbn13_prefix_with_9_digits:sub(i, i))
        sum = sum + ((i % 2 == 0) and (digit * 3) or digit)
    end
    local check_digit = (10 - (sum % 10)) % 10

    -- Construct the ISBN-13 by appending the check digit
    local isbn13 = isbn13_prefix_with_9_digits .. tostring(check_digit)

    return isbn13
end

-- Convert ISBN-10 to ISBN-13
local isbn10 = col["isbn10"]
local isbn13 = convert_isbn10_to_isbn13(isbn10)

-- Return the converted ISBN-13
return isbn13
