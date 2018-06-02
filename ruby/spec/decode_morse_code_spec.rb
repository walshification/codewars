require 'decode_morse_code'

describe '#decode_morse' do
  it 'decodes a letter' do
    expect(decode_morse('...')).to eq('S')
  end

  it 'decodes a phrase' do
    expect(decode_morse('... --- ...')).to eq('SOS')
  end

  it 'decodes sentences' do
    transmission = '- .... .   --.- ..- .. -.-. -.-   -... .-. --- .-- -.   ..-. --- -..-   '\
                   '.--- ..- -- .--. ...   --- ...- . .-.   - .... .   .-.. .- --.. -.--'\
                   '   -.. --- --.'
    decoded_message = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG'
    expect(decode_morse(transmission)).to eq(decoded_message)
  end
end
