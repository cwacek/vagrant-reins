require 'vagrant/reins/harness'
require 'vagrant/reins/error'

describe 'Harness' do
  before :all do
    @tmpdir = Dir.mktmpdir
  end

  after :all do
    FileUtils.remove_entry @tmpdir
  end

  context 'with no vagrantfile' do
    it 'should throw an exception' do
      expect {Harness.new}.to raise_error VagrantEnvironmentError
    end
  end

  context 'with a vagrantfile' do
    before :all do
      FileUtils.cp 'fixtures/Vagrantfile', @tmpdir
    end

    it 'should create a harness' do
      harness = Harness.new @tmpdir
      harness.should exist
    end

  end


end
