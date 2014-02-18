require 'vagrant/reins/harness'
require 'vagrant/reins/error'
require 'tmpdir'
require 'pry'

PWD = File.expand_path File.dirname(__FILE__)

Reins = Vagrant::Reins

describe 'Harness' do
  before :all do
    @tmpdir = Dir.mktmpdir
  end

  after :all do
    FileUtils.remove_entry @tmpdir
  end

  context 'with no vagrantfile' do
    it '.new' do
      expect {Reins::Harness.new @tmpdir}.to raise_error Reins::VagrantEnvironmentError
    end
  end

  context 'with a vagrantfile' do

    context 'that is valid' do
      before :each do
        FileUtils.cp PWD + '/fixtures/Vagrantfile.good', @tmpdir + "/Vagrantfile"
      end

      it '.new' do
        harness = Reins::Harness.new @tmpdir
        harness.should_not be_nil
        harness.status.should be :preinit
      end

      it '#up' do
        harness = Reins::Harness.new @tmpdir
        harness.up.should be true
        harness.status.should be :running
        harness.command "vagrant destroy"
      end

    end

    context 'that is invalid' do
      before :each do
        FileUtils.cp PWD + '/fixtures/Vagrantfile.invalid', @tmpdir + "/Vagrantfile"
      end

      it '.new' do
        harness = Reins::Harness.new @tmpdir
        harness.should_not be_nil
        harness.status.should be :preinit
      end

      it '#up' do
        harness = Reins::Harness.new @tmpdir
        harness.up.should_not be true
        harness.status.should be :error
      end
    end

    context 'that is broken' do
      before :each do
        FileUtils.cp PWD + '/fixtures/Vagrantfile.broken', @tmpdir + "/Vagrantfile"
      end

      it '.new' do
        expect {Reins::Harness.new @tmpdir}.to raise
      end
    end

  end
end
