# frozen_string_literal: true

RSpec.describe MicroCms do
  describe '#self.configure' do
    it 'yields the class back' do
      expect { |block| described_class.configure(&block) }.to yield_with_args described_class
    end
  end
end
