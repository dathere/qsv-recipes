--qsv luau map name Titlecase.lua filename.csv | qsv table

BEGIN {
    -- Auto-index the CSV
    qsv_autoindex()
}!

-- Function to convert a string to Title Case
local function to_title_case(str)
    return (str:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
    end))
end

-- Apply Title Case transformation to the specified column for the current row
local column_value = col[1] --Modify the required column index that need titlecasing

-- Transform the column value to Title Case
local title_case_value = to_title_case(column_value)

-- Return the transformed value for the column
return title_case_value
