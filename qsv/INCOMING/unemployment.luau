BEGIN {
    csv_indexed = qsv_autoindex();
    unemployment_lookup_headers = qsv_register_lookup("unemployment2023", "https://data.dathere.com/dataset/e0bcff0e-e21f-42bf-829d-8cbe059cf954/resource/f56a104b-e943-4f49-8755-0891d3284669/download/2023data.csv", 10000)
}

local month_name = col["Month"]
for key, details in pairs(unemployment2023) do
    if details["Month"] == month_name then
        rate_result = details["Unemployment Rate"]
        break
    end
end
-- Return the geoid for the given city name
return {rate_result};