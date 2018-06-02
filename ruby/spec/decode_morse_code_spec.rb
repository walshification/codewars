require 'decode_morse_code'

describe '#decodeMorse' do
  it 'decodes a letter' do
    expect(decodeMorse('...')).to eq('S')
  end

  it 'decodes a phrase' do
    expect(decodeMorse('... --- ...')).to eq('SOS')
  end

  it 'decodes sentences' do
    transmission = '- .... .   --.- ..- .. -.-. -.-   -... .-. --- .-- -.   ..-. --- -..-   '\
                   '.--- ..- -- .--. ...   --- ...- . .-.   - .... .   .-.. .- --.. -.--'\
                   '   -.. --- --.'
    decoded_message = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG'
    expect(decodeMorse(transmission)).to eq(decoded_message)
  end
end
