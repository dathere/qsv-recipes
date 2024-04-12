BEGIN {
    -- Auto-index the CSV
    qsv_autoindex()
}!

-- Get the current date
local current_date = os.date("*t")

-- Extract the birthdate components
local birthdate = col[1]
local birth_day, birth_month, birth_year = string.match(birthdate, "(%d+)-(%d+)-(%d+)")

-- Convert birthdate components to numbers
birth_day = tonumber(birth_day)
birth_month = tonumber(birth_month)
birth_year = tonumber(birth_year)

-- Calculate the age
local age = current_date.year - birth_year

-- Adjust age based on birth month and day
if current_date.month < birth_month or (current_date.month == birth_month and current_date.day < birth_day) then
    age = age - 1
end

-- Return the calculated age
return age
