# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicroCms::ApplicationHelper, type: :helper do
  describe '#micro_cms_asset_tags' do
    describe 'returns a script and css tag containing data from the micro_cms gem' do
      subject { helper.micro_cms_asset_tags }

      it { is_expected.to match(/<script>.*micro_cms.*<style>/m) }
    end
  end
end
