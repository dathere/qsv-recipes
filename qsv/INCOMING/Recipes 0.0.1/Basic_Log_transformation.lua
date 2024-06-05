BEGIN {
    csv_indexed = qsv_autoindex();
}!

local value = tonumber(col["value"])
if value and value > 0 then
    transformed_value = math.log(value)
else
    transformed_value = "<ERROR>"
end

return {transformed_value}
