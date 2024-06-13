BEGIN {
    -- Auto-index the CSV
    qsv_autoindex()
}!

-- Define a table of common HTML/XML entities and their replacements
local entities = {
    ["&amp;"] = "&",
    ["&lt;"] = "<",
    ["&gt;"] = ">",
    ["&quot;"] = "\"",
    ["&apos;"] = "'"
}

-- Function to replace entities in a string
local function decode_entities(str)
    for entity, char in pairs(entities) do
        str = str:gsub(entity, char)
    end
    return str
end

-- Decode entities in the Content column
local content = col["Content"]
local decoded_content = decode_entities(content)

-- Return the decoded content
return {decoded_content}
