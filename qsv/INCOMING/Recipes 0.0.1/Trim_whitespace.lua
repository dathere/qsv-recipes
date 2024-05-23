-- qsv usage syntax 
-- qsv luau map --remap Newcolumn Trim.lua filename.csv | qsv table
-- qsv luau map --remap Newcolumn Trim.lua filename.csv -o output_filename.csv
-- Trim whitespaces from multiple columns 
-- qsv luau map --remap col1,col2,col3 Trim.lua filename.csv | qsv table

BEGIN {
    -- Auto-index the CSV
    qsv_autoindex()
}!

-- Function to trim leading and trailing whitespaces
local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Iterate over each column in the row
for _, value in pairs(col) do
    -- Trim leading and trailing whitespaces from each value
    col[_] = trim(value)
end

-- Return the row with trimmed values
return col
