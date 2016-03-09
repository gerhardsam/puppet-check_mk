require 'spec_helper_acceptance'
require_relative './agent_version.rb'

describe 'check_mk::agent class' do
  context 'default parameters' do
    let(:pp) do
      <<-EOS
        class { 'check_mk::agent': }
      EOS
    end
    # Run it twice and test for idempotency
    it_behaves_like "a idempotent resource"

    describe package($package_name) do
      it { is_expected.to be_installed }
    end

    describe service($service_name) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(6556) do
      it { should be_listening }
    end

    describe file($mrpe_config_file) do
      it { is_expected.not_to be_file }
    end
  end

  context 'custom port' do
    let(:pp) do
      <<-EOS
        class { 'check_mk::agent':
          port => '6666',
        }
      EOS
    end
    # Run it twice and test for idempotency
    it_behaves_like "a idempotent resource"

    describe service($service_name) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(6666) do
      it { should be_listening }
    end
  end

  context 'mrpe-checks' do
    let(:pp) do
      <<-EOS
        class { 'check_mk::agent':
          mrpe_checks => {
            'check1' => {
              command => '/bin/true'
            },
            'check2' => {
              command => '/bin/false'
            },
          }
        }
      EOS
    end
    # Run it twice and test for idempotency
    it_behaves_like "a idempotent resource"

    describe file($mrpe_config_file) do
      it { is_expected.to contain('check1 /bin/true') }
      it { is_expected.to contain('check2 /bin/false') }
    end
  end
end
