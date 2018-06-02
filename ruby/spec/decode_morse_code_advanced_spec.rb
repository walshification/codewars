require 'decode_morse_code_advanced'
require 'decode_morse_code'

describe('#decodeBits') do
  it 'decodes the alphabet' do
    transmission = '111000101010100010000000'\
                   '11101110101110001010111000101000111010111010001110101110000000'\
                   '111010101000101110100011101110111000101110111000111010000000'\
                   '10101110100011101110111000111010101110000000'\
                   '10111011101110001010111000111011100010111011101000101010000000'\
                   '11101110111000101010111000100010111010000000'\
                   '111000101010100010000000'\
                   '101110101000101110001110111010100011101011101110000000'\
                   '111010100011101110111000111011101'
    decoded_message = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG'
    expect(decodeMorse(decodeBits(transmission))).to eq(decoded_message)
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

describe '#determine_unit_mapping' do
  it 'determines the length of a dot when there is just a dot' do
    mapping = determine_unit_mapping('11')
    expect(mapping['11']).to eq('.')
  end

  it 'determines the length of a dash from a dot' do
    mapping = determine_unit_mapping('11')
    expect(mapping['111111']).to eq('-')
  end

  it 'determines the length of a code_space from a dot if there is no space' do
    mapping = determine_unit_mapping('11')
    expect(mapping['00']).to eq('')
  end

  it 'assumes a single transmission is a dot' do
    mapping = determine_unit_mapping('1111111111')
    expect(mapping['1111111111']).to eq('.')
  end

  it 'determines the length of a code_space by the smallest pause' do
    mapping = determine_unit_mapping('11111100111111')
    expect(mapping['00']).to eq('')
  end

  it 'realizes the length of a pause is the same as the code_space' do
    mapping = determine_unit_mapping('11111100111111')
    expect(mapping['11']).to eq('.')
  end

  it 'determines the char_space based on the code_space' do
    mapping = determine_unit_mapping('11111100111111')
    expect(mapping['000000']).to eq(' ')
  end

  it 'determines the word_space based on the code_space' do
    mapping = determine_unit_mapping('11111100111111')
    expect(mapping['00000000000000']).to eq('   ')
  end
end
