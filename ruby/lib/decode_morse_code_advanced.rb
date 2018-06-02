def decodeBits(bits)
  cleaned_bits = clean_ends(bits)
  dot, dash, code_space, char_space, word_space = determine_units(cleaned_bits)

  cleaned_bits = replace_bits_with_morse(cleaned_bits, word_space, '   ')
  cleaned_bits = replace_bits_with_morse(cleaned_bits, char_space, ' ')
  cleaned_bits = replace_bits_with_morse(cleaned_bits, dash, '-')
  cleaned_bits = replace_bits_with_morse(cleaned_bits, dot, '.')
  code_phrase = replace_bits_with_morse(cleaned_bits, code_space, '')

  code_phrase
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

def determine_units(cleaned_bits)
  smallest_unit = determine_smallest_unit(cleaned_bits)

  dot = '1' * smallest_unit
  dash = dot * 3
  code_space = '0' * smallest_unit
  char_space = code_space * 3
  word_space = code_space * 7
  return dot, dash, code_space, char_space, word_space
end

def determine_smallest_unit(cleaned_bits)
  dots_and_dashes = cleaned_bits.split('0').delete_if { |bit| bit == '' }
  smallest_unit = dots_and_dashes.min.length
  pauses = cleaned_bits.split('1').delete_if { |bit| bit == '' }
  smallest_pause = pauses.any? ? pauses.min.length : nil

  if smallest_unit_longer_than_smallest_pause?(smallest_unit, smallest_pause)
    # given we're in this block, the smallest transmission is a dash
    smallest_unit = smallest_pause
  end
  smallest_unit
end

def smallest_unit_longer_than_smallest_pause?(smallest_unit, smallest_pause)
  smallest_pause && smallest_unit > smallest_pause
end

def replace_bits_with_morse(bit_string, unit, morse_code)
  bit_string.gsub(unit, morse_code)
end
