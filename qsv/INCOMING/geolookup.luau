BEGIN {

csv_indexed = qsv_autoindex();
geoid_lookup_headers = qsv_register_lookup("places_geoid", "dathere://places_geoid.csv", 10000)


}!

local city_name = col["NAME"]
for geoid, details in pairs(places_geoid) do
    if details["NAME"] == city_name then
        geoid_result = geoid
        break
    end
end
-- Return the geoid for the given city name
return {geoid_result};