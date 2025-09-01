RSpec.describe 'Debugging Example' do
  it 'has a bug to fix (will fail)' do
    expect(2 * 2).to eq(5) # This will fail
  end

  it 'raises a NoMethodError (will fail)' do
    arr = [1, 2, 3]
    expect { arr.not_a_method }.not_to raise_error # This will fail
  end

  it 'raises an ArgumentError (will fail)' do
    def add(a, b); a + b; end
    expect { add(1) }.not_to raise_error # This will fail
  end

  it 'raises a TypeError (will fail)' do
    expect { "hi" + 2 }.not_to raise_error # This will fail
  end

  it 'fails with wrong matcher (will fail)' do
    expect { expect(42).to be_empty }.not_to raise_error # This will fail
  end

  it 'fails with wrong value in include matcher (will fail)' do
    expect([:a, :b, :c]).to include(:d) # This will fail
  end

  it 'is a pending spec for students to fix' do
    pending('Fix this spec!')
    expect(10 / 2).to eq(3) # This will fail
  end

  xit 'is a skipped spec (students can unskip and debug)' do
    expect("hello".reverse).to eq("olleh!") # This will fail
  end
end
