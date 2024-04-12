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
