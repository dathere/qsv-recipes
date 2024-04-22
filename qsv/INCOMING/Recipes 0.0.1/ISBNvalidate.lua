--[[
Usage:
1. Before running the recipe, make sure to enter the column index which contains the ISBN numbers in the code.
2. Use the following qsv command to validate ISBN numbers and add the validation result as a new column named 'Validation' in the CSV:
   
    qsv luau map 'Validation' validate_isbn.luau filename.csv -o newfile.csv
    
   - Replace 'validate_isbn.luau' with the filename of this Lua script.
   - Replace 'filename.csv' with the name of your input CSV file.
   - The '-o' option is used to specify the output filename ('newfile.csv' in this example).

3. When you have the file and the recipe in different file locations
        
        qsv luau map 'Validation' file:<Path of this recipe> filename.csv -o newfile.csv
    
        When you need real-time preview of the csv file 

        qsv luau map 'Validation' validate_isbn.luau filename.csv | qsv table
Example:
Suppose the input CSV file 'books.csv' contains a column 'ISBN' which contains ISBN numbers. To validate these ISBN numbers and add the validation result as a new column named 'Validation' in the CSV, use the following command:
qsv luau map 'Validation' validate_isbn.luau books.csv -o books_with_validation.csv
]]
BEGIN {
    -- Auto-index the CSV
    qsv_autoindex() 
}!
local function extractISBN(isbn)
    -- Function to extract ISBN from a string containing additional text
    -- Example: "(ISBN10: 0440" -> "0440"
    return isbn:match("(%d+)")
end
-- Function to validate ISBN-10
local function validateISBN10(isbn)
    -- Remove hyphens and spaces from ISBN
    isbn = isbn:gsub("[%- ]", "")

    -- Check if ISBN is empty
    if isbn == "" then
        return "Empty"
    end

    -- Check if ISBN length is valid
    if #isbn ~= 10 then
        return "Invalid length"
    end

    -- Calculate the check digit
    local checkDigit = 0
    for i = 1, 9 do
        checkDigit = checkDigit + tonumber(isbn:sub(i, i)) * (11 - i)
    end

    checkDigit = (11 - (checkDigit % 11)) % 11

    -- Compare calculated check digit with the actual check digit
    if checkDigit == tonumber(isbn:sub(10, 10)) then
        return "Valid"
    else
        return "Invalid"
    end
end

-- Function to validate ISBN-13
local function validateISBN13(isbn)
    -- Remove hyphens and spaces from ISBN
    isbn = isbn:gsub("[%- ]", "")

    -- Check if ISBN is empty
    if isbn == "" then
        return "Empty"
    end

    -- Check if ISBN length is valid
    if #isbn ~= 13 then
        return "Invalid length"
    end

    -- Calculate the check digit
    local checkDigit = 0
    for i = 1, 12, 2 do
        checkDigit = checkDigit + tonumber(isbn:sub(i, i))
    end
    for i = 2, 12, 2 do
        checkDigit = checkDigit + tonumber(isbn:sub(i, i)) * 3
    end

    checkDigit = (10 - (checkDigit % 10)) % 10

    -- Compare calculated check digit with the actual check digit
    if checkDigit == tonumber(isbn:sub(13, 13)) then
        return "Valid"
    else
        return "Invalid"
    end
end

-- Validate ISBNs from input column "ISBN"
local isbn = col["isbn"]
isbn = extractISBN(isbn)
local validation = ""
if not isbn then
    validation = "Empty"
elseif #isbn == 10 then
    validation = validateISBN10(isbn)
elseif #isbn == 13 then
    validation = validateISBN13(isbn)
else
    validation = "Invalid length"
end
return validation
