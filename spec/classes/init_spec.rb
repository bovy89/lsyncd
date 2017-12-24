require 'spec_helper'


describe 'lsyncd', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      describe 'with default values for all parameters' do
        it { is_expected.to create_class('lsyncd') }
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_file('/etc/lsyncd.conf') }
        it { is_expected.to contain_file('/etc/sysconfig/lsyncd') }

        it { is_expected.to contain_service('lsyncd').with(
          :enable => true,
          :ensure => 'running',
        )}

        it { is_expected.to contain_package('lsyncd').with(
          :ensure => 'present'
        )}
      end
    end
  end
end
