def decodeBits(bits)
  cleaned_bits = clean_ends(bits)
  unit_mapping = determine_unit_mapping(cleaned_bits)
  replace_bits_with_morse_code(cleaned_bits, unit_mapping)
end

def clean_ends(bits)
  bits = trim_front_space(bits)
  reversed = bits.reverse
  bits = trim_front_space(reversed)
  bits.reverse
end

def trim_front_space(bits)
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
  dots_and_dashes = cleaned_bits.split('0').delete_if { |bit| bit == '' }
  smallest_unit = dots_and_dashes.min.length
  pauses = cleaned_bits.split('1').delete_if { |bit| bit == '' }
  smallest_pause = pauses.any? ? pauses.min.length : nil

  # is the smallest transmission unit actually a dash?
  smallest_unit = smallest_pause if unit_longer_than_pause?(smallest_unit, smallest_pause)

  smallest_unit
end

def unit_longer_than_pause?(smallest_unit, smallest_pause)
  smallest_pause && smallest_unit > smallest_pause
end

def replace_bits_with_morse_code(transmission, unit_mapping)
  unit_mapping.each { |unit, morse_equivalent| transmission.gsub!(unit, morse_equivalent) }
  transmission
end
