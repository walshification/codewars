require 'decode_morse_code_advanced'
require 'decode_morse_code'

describe('Example from description') do
  it 'decodes HEY JUDE' do
    transmission = '1100110011001100000011000000111111001100111111001111110000000000000011001111110011111100111111000000110011001111110000001111110011001100000011'
    expect(decodeMorse(decodeBits(transmission))).to eq('HEY JUDE')
  end
end

describe '#clean_ends' do
  it 'does not alter a transmission with no extra pauses in the beginning or end' do
    transmission = '111111'
    expect(clean_ends(transmission)).to eq(transmission)
  end

  it 'removes extra pauses from the front' do
    transmission = '0111111'
    expect(clean_ends(transmission)).to eq('111111')
  end

  it 'removes extra long pauses from the front' do
    transmission = '0000000111111'
    expect(clean_ends(transmission)).to eq('111111')
  end

  it 'removes extra pauses from the back' do
    transmission = '1111110'
    expect(clean_ends(transmission)).to eq('111111')
  end

  it 'removes extra long pauses from the back' do
    transmission = '1111110000000'
    expect(clean_ends(transmission)).to eq('111111')
  end

  it 'removes pauses from the front and back' do
    transmission = '00001111110000000'
    expect(clean_ends(transmission)).to eq('111111')
  end
end

describe '#determine_units' do
  it 'determines the length of a dot when there is just a dot' do
    dot, dash, code_space, char_space, word_space = determine_units('11')
    expect(dot).to eq('11')
  end

  it 'determines the length of a dash from a dot' do
    dot, dash, code_space, char_space, word_space = determine_units('11')
    expect(dash).to eq('111111')
  end

  it 'determines the length of a code_space from a dot if there is no space' do
    dot, dash, code_space, char_space, word_space = determine_units('11')
    expect(code_space).to eq('00')
  end

  it 'assumes a single transmission is a dot' do
    dot, dash, code_space, char_space, word_space = determine_units('1111111111')
    expect(dot).to eq('1111111111')
  end

  it 'determines the length of a code_space by the smallest pause' do
    dot, dash, code_space, char_space, word_space = determine_units('11111100111111')
    expect(code_space).to eq('00')
  end

  it 'realizes the length of a pause is the same as the code_space' do
    dot, dash, code_space, char_space, word_space = determine_units('11111100111111')
    expect(dot).to eq('11')
  end

  it 'determines the char_space based on the code_space' do
    dot, dash, code_space, char_space, word_space = determine_units('11111100111111')
    expect(char_space).to eq('000000')
  end

  it 'determines the word_space based on the code_space' do
    dot, dash, code_space, char_space, word_space = determine_units('11111100111111')
    expect(word_space).to eq('00000000000000')
  end
end
