--[[
Usage:
1. Before running the recipe, make sure to enter the column index which contains the birthdate in the code.
2. Use the following qsv command to calculate the age and add it as a new column named 'Age' in the CSV:
   
    qsv luau map 'Age' age.luau filename.csv -o newfile.csv
    
   - Replace 'age.luau' wisth the filename of this Lua script.
   - Replace 'filename.csv' with the name of your input CSV file.
   - The '-o' option is used to specify the output filename ('newfile.csv' in this example).

3. When you have the file and the recipe in different file locations
        
        qsv luau map 'Age' file:<Path of this recipe> filename.csv -o newfile.csv
    
        When you need real-time preview of the csv file 

        qsv luau map 'Age' age.luau filename.csv | qsv table
Example:
Suppose the input CSV file 'people.csv' contains a column 'Birthdate' which contains birthdates in the format 'dd-mm-yyyy'. To calculate the age based on these birthdates and add it as a new column named 'Age' in the CSV, use the following command:
qsv luau map 'Age' age.luau people.csv -o people_with_age.csv
]]


BEGIN {
    -- Auto-index the CSV
    qsv_autoindex()
}!

-- Get the current date
local current_date = os.date("*t")

-- Extract the birthdate components
local birthdate = col[1] --replace the index with the age column
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
