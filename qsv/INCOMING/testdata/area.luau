BEGIN {
    csv_indexed = qsv_autoindex();
    us_states_lookup_headers = qsv_register_lookup("us_states", "dathere://us-states-example.csv", 1000000)
}!

local state_name = col["Name"]:match("^%s*(.-)%s*$")


for abbreviation, details in pairs(us_states) do
    if details["Name"] == state_name then
        -- Remove commas from the population string and convert it to a number
        area_result =   details["area (square miles)"]
        break
    end
end

-- Return the population for the given state name
return {area_result};