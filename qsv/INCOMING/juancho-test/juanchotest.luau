BEGIN {
    city_array = {};
    state_array = {};
    qsv_cmd_output = {};
    qsv_writefile("test.txt", "_NEWFILE!");

    -- Use the 'qsv_register_lookup' helper to scan sampledata.csv values.
    sample_data_lookup_headers_table = qsv_register_lookup("sample_data",
        "sampledata.csv",6000)

    qsv_log("debug", "sample_data_lookup_headers:", sample_data_lookup_headers_table);
    qsv_log("info", "sample_data lookup table", sample_data);
    qsv_log("info", 'City & State from Entry 1: {sample_data["1"]["city"]["state"]}');
}!

-- MAIN script loop starts here

-- Obtain the GEOID value using the qsv_cmd() helper. This will return a table.
qsv_cmd_output[_IDX] = qsv_cmd("geocode suggestnow 'Miami, FL' --formatstr '{us_state_fips_code}{us_county_fips_code}'");

local geoid = 'test';
return {geoid};

-- MAIN script loop ends here
END {
    --return 'GEOID values obtained.'
    for index, value in qsv_cmd_output do
        print(qsv_cmd_output[index]);
    end
}!