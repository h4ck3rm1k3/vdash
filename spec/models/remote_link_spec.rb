require 'spec_helper'

describe RemoteLink do
  describe 'validations' do
    it 'raises an exception if called with an invalid url' do
      expect {
        RemoteLink.new('/etc/passwd')
      }.to raise_error
    end
  end

  context 'when dealing with a valid url' do
    before { RemoteLink.any_instance.stub(:complain_if_bad_url) }

    let(:remote_link) { RemoteLink.new(File.join(Rails.root, "spec/fixtures/remote_link.html")) }

    describe '#title' do
      it 'returns the title of the web page' do
        remote_link.title.should == 'This is my title'
      end
    end

    describe '#first_paragraph' do
      it 'returns the first paragraph of the web page' do
        remote_link.first_paragraph.should == 'This is my paragraph.'
      end
    end

    describe '#as_json' do
      it 'returns the title and first_paragraph as json' do
        remote_link.as_json.should == {
          title:           "This is my title",
          first_paragraph: "This is my paragraph."
        }
      end
    end
  end
end
