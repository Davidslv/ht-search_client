shared_examples_for 'a stay search' do

  using Ht::SearchClient::Test

  before do
    described_class
      .stub_request(options)
      .with_results(properties: results)
  end

  context 'when the dates are present' do
    it 'returns the matching property ids in the correct order' do
      subject.perform

      expect(subject.results).to eql results
    end
  end

  context 'when one of the dates params is missing' do
    before { options.delete(:from) }

    it 'should raise error' do
      expect { subject.perform }.to raise_error(KeyError)
    end
  end
end
