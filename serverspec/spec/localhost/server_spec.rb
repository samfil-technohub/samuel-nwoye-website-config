require 'spec_helper'

describe package('git') do
  it { is_expected.to be_installed }
end

describe package('serverspec') do
  it { is_expected.to be_installed.by('gem') }
end

describe 'Go' do
  it { expect(file '/usr/local/go/bin/go').to exist & be_executable }
end

describe 'Nginx' do
  it 'is expected to be installed, running and enabled' do
    expect(package 'nginx').to be_installed
    expect(service 'nginx').to be_running & be_enabled
  end
end

describe 'GoApp' do
  it 'is expected to be running, enabled and listening on 80' do
    expect(service 'goapp').to be_running & be_enabled
    expect(port 80).to be_listening 'tcp'
  end
end

describe 'NodeExporter' do
  it 'is expected to be installed, running, enabled and listening on 9100' do
    expect(file '/usr/local/bin/node_exporter').to exist & be_executable
    expect(service 'node_exporter').to be_running & be_enabled
    expect(port 9100).to be_listening 'tcp'
  end
end
