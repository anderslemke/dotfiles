#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ULID to UUID
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "ULID" }
# @raycast.packageName Debug Utils

# Documentation:
# @raycast.description Converts ULID to UUID
# @raycast.author anderslemke
# @raycast.authorURL https://raycast.com/anderslemke
def ulid_to_uuid(ulid)
  # Crockford's Base32 alphabet
  alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
  base32_map = Hash[alphabet.chars.each_with_index.to_a]
  
  # Convert ULID to base 10
  base10 = ulid.chars.reverse.each_with_index.reduce(0) do |acc, (char, idx)|
    acc + base32_map[char] * (32**idx)
  end
  
  # Convert to hex and pad with zeroes
  hex_string = base10.to_s(16).rjust(32, '0')

  # Inject hyphens to match UUID's 8-4-4-4-12 format
  # 018ADA6D-160C-7152-3BCA-51166BE8A5F1
  [
    hex_string[0..7],
    hex_string[8..11],
    hex_string[12..15], # 4 characters
    hex_string[16..19],
    hex_string[20..31]  # 12 characters
  ].join('-').upcase
end

ulid = ARGV[0]
uuid_result = ulid_to_uuid(ulid)

# Copy the result to the clipboard
IO.popen('pbcopy', 'w') { |clipboard| clipboard.write(uuid_result) }
puts "#{uuid_result} copied to clipboard!"
