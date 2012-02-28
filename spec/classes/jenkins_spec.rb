require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'jenkins' do

  let(:title) { 'jenkins' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test standard installation' do
    it { should contain_package('jenkins').with_ensure('present') }
    it { should contain_service('jenkins').with_ensure('running') }
    it { should contain_service('jenkins').with_enable('true') }
    it { should contain_file('jenkins.conf').with_ensure('present') }
  end

  describe 'Test standard installation with monitoring and firewalling' do
    let(:params) { {:monitor => true , :firewall => true, :port => '42' } }

    it { should contain_package('jenkins').with_ensure('present') }
    it { should contain_service('jenkins').with_ensure('running') }
    it { should contain_service('jenkins').with_enable('true') }
    it { should contain_file('jenkins.conf').with_ensure('present') }
    it 'should monitor the process' do
      content = catalogue.resource('monitor::process', 'jenkins_process').send(:parameters)[:enable]
      content.should == true
    end
    it 'should place a firewall rule' do
      content = catalogue.resource('firewall', 'jenkins_tcp_42').send(:parameters)[:enable]
      content.should == true
    end
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true, :monitor => true , :firewall => true, :port => '42'} }

    it 'should remove Package[jenkins]' do should contain_package('jenkins').with_ensure('absent') end 
    it 'should stop Service[jenkins]' do should contain_service('jenkins').with_ensure('stopped') end
    it 'should not enable at boot Service[jenkins]' do should contain_service('jenkins').with_enable('false') end
    it 'should remove jenkins configuration file' do should contain_file('jenkins.conf').with_ensure('absent') end
    it 'should not monitor the process' do
      content = catalogue.resource('monitor::process', 'jenkins_process').send(:parameters)[:enable]
      content.should == false
    end
    it 'should remove a firewall rule' do
      content = catalogue.resource('firewall', 'jenkins_tcp_42').send(:parameters)[:enable]
      content.should == false
    end
  end

  describe 'Test decommissioning - disable' do
    let(:params) { {:disable => true, :monitor => true , :firewall => true, :port => '42'} }

    it { should contain_package('jenkins').with_ensure('present') }
    it 'should stop Service[jenkins]' do should contain_service('jenkins').with_ensure('stopped') end
    it 'should not enable at boot Service[jenkins]' do should contain_service('jenkins').with_enable('false') end
    it { should contain_file('jenkins.conf').with_ensure('present') }
    it 'should not monitor the process' do
      content = catalogue.resource('monitor::process', 'jenkins_process').send(:parameters)[:enable]
      content.should == false
    end
    it 'should remove a firewall rule' do
      content = catalogue.resource('firewall', 'jenkins_tcp_42').send(:parameters)[:enable]
      content.should == false
    end
  end

  describe 'Test decommissioning - disableboot' do
    let(:params) { {:disableboot => true, :monitor => true , :firewall => true, :port => '42'} }
  
    it { should contain_package('jenkins').with_ensure('present') }
    it { should_not contain_service('jenkins').with_ensure('present') }
    it { should_not contain_service('jenkins').with_ensure('absent') }
    it 'should not enable at boot Service[jenkins]' do should contain_service('jenkins').with_enable('false') end
    it { should contain_file('jenkins.conf').with_ensure('present') }
    it 'should not monitor the process locally' do
      content = catalogue.resource('monitor::process', 'jenkins_process').send(:parameters)[:enable]
      content.should == false
    end
    it 'should keep a firewall rule' do
      content = catalogue.resource('firewall', 'jenkins_tcp_42').send(:parameters)[:enable]
      content.should == true
    end
  end 

  describe 'Test puppi installation' do
    let(:params) { {:install => 'puppi' } }

    it { should_not contain_package('jenkins').with_ensure('present') }
    it { should_not contain_service('jenkins').with_ensure('running') }
    it { should_not contain_service('jenkins').with_enable('true') }
    it { should_not contain_file('jenkins.conf').with_ensure('present') }
    it 'should generate a puppi deploy project' do
      content = catalogue.resource('puppi::project::war', 'jenkins').send(:parameters)[:enable]
      content.should == true
    end
  end

  describe 'Test source installation' do
    let(:params) { {:install => 'source' , :install_source => 'http://example42.com/jenkins.war' } }

    it { should_not contain_package('jenkins').with_ensure('present') }
    it { should_not contain_service('jenkins').with_ensure('running') }
    it { should_not contain_service('jenkins').with_enable('true') }
    it { should_not contain_file('jenkins.conf').with_ensure('present') }
    it 'should generate a netinstall define' do
      content = catalogue.resource('puppi::netinstall', 'jenkins').send(:parameters)[:url]
      content.should == 'http://example42.com/jenkins.war'
    end
  end

  describe 'Test customizations - template' do
    let(:params) { {:template => "jenkins/spec.erb" , :options => { 'opt_a' => 'value_a' } } }

    it 'should generate a valid template' do
      content = catalogue.resource('file', 'jenkins.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
    it 'should generate a template that uses custom options' do
      content = catalogue.resource('file', 'jenkins.conf').send(:parameters)[:content]
      content.should match "value_a"
    end

  end

  describe 'Test customizations - source' do
    let(:params) { {:source => "puppet://modules/jenkins/spec" , :source_dir => "puppet://modules/jenkins/dir/spec" , :source_dir_purge => true } }

    it 'should request a valid source ' do
      content = catalogue.resource('file', 'jenkins.conf').send(:parameters)[:source]
      content.should == "puppet://modules/jenkins/spec"
    end
    it 'should request a valid source dir' do
      content = catalogue.resource('file', 'jenkins.dir').send(:parameters)[:source]
      content.should == "puppet://modules/jenkins/dir/spec"
    end
    it 'should purge source dir if source_dir_purge is true' do
      content = catalogue.resource('file', 'jenkins.dir').send(:parameters)[:purge]
      content.should == true
    end
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "jenkins::spec" } }
    it 'should automatically include a custom class' do
      content = catalogue.resource('file', 'jenkins.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
  end

  describe 'Test Puppi Integration' do
    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }

    it 'should generate a puppi::ze define' do
      content = catalogue.resource('puppi::ze', 'jenkins').send(:parameters)[:helper]
      content.should == "myhelper"
    end
  end

  describe 'Test Monitoring Tools Integration' do
    let(:params) { {:monitor => true, :monitor_tool => "puppi" } }

    it 'should generate monitor defines' do
      content = catalogue.resource('monitor::process', 'jenkins_process').send(:parameters)[:tool]
      content.should == "puppi"
    end
  end

end
