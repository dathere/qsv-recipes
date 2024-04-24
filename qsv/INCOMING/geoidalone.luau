BEGIN {
    csv_indexed = qsv_autoindex();
    geoid_lookup_headers = qsv_register_lookup("race", "dathere://Places_race.csv", 1000000)
}!
local state_geoid = col["geoid"]
local white_result: string = race[state_geoid]["white_alone"]
local black_result: string = race[state_geoid]["black_alone"]
local american_indian_and_alaska_native_result: string = race[state_geoid]["american_indian_and_alaska_native"]
local asian_result: string = race[state_geoid]["asian_alone"]
local native_hawaiian_and_pacific_islander_result: string = race[state_geoid]["native_hawaiian_and_pacific_islander"]
local latino_result: string = race[state_geoid]["latino_alone"]
-- Return the white alone data for the given state geoid
return {white_result, black_result, american_indian_and_alaska_native_result, asian_result, native_hawaiian_and_pacific_islander_result, latino_result};



