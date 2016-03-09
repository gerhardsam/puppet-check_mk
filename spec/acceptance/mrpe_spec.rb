require 'spec_helper_acceptance'
require_relative './agent_version.rb'

describe 'check_mk::agent class' do
  context 'mrpe-check' do
    let(:pp) do
      <<-EOS
        class { 'check_mk::agent': }
        check_mk::agent::mrpe { 'mrpe-check':
          command => '/bin/true',
        }
      EOS
    end
    # Run it twice and test for idempotency
    it_behaves_like "a idempotent resource"

    describe package($package_name) do
      it { is_expected.to be_installed }
    end

    describe file($mrpe_config_file) do
      it { is_expected.to contain('mrpe-check /bin/true') }
    end
  end
end
