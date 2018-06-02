def decodeBits(bits)
  cleaned_bits = clean_ends(bits)
  unit_mapping = determine_unit_mapping(cleaned_bits)
  replace_bits_with_morse_code(cleaned_bits, unit_mapping)
end

def clean_ends(bits)
  bits = trim_space(bits)
  reversed = bits.reverse
  bits = trim_space(reversed)
  bits.reverse
end

def trim_space(bits)
  idx = 0
  until bits[idx] == '1'
    idx += 1
  end
  bits.slice!(0, idx)
  bits
end

def determine_unit_mapping(cleaned_bits)
  smallest_unit = determine_smallest_unit(cleaned_bits)
  {
    ('1' * (smallest_unit * 3)) => '-',
    ('1' * smallest_unit) => '.',
    ('0' * (smallest_unit * 7)) => '   ',
    ('0' * (smallest_unit * 3)) => ' ',
    ('0' * smallest_unit) => ''
  }
end

def determine_smallest_unit(cleaned_bits)
  idx = 0
  smallest_unit = 9000 # arbitrarily big value
  until idx == cleaned_bits.length
    bit = slice_bit(cleaned_bits, idx)
    smallest_unit = bit.length if smallest_unit > bit.length
    idx += bit.length
  end
  smallest_unit
end

def slice_bit(bits, idx)
  start_index = idx
  slice_length = 1
  # if we start with a '0', go until we hit a '1', and vice-versa
  while bits[start_index] == bits[start_index + slice_length]
    slice_length += 1
  end
  bits.slice(start_index, slice_length)
end

def replace_bits_with_morse_code(transmission, unit_mapping)
  unit_mapping.each { |unit, morse_equivalent| transmission.gsub!(unit, morse_equivalent) }
  transmission
end
