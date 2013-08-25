require 'formula'

class Ansible < Formula
  homepage 'http://ansible.github.com/'
  head 'https://github.com/ansible/ansible.git', :using => :git
  url 'https://github.com/ansible/ansible/archive/v1.2.3.tar.gz'
  sha1 '61efdd65c59dfd9fdda99afc6595968d947e7946'

  depends_on 'python'
  depends_on 'paramiko' => :python
  depends_on 'jinja2' => :python
#  depends_on 'pyyaml' => :python

  def install
    inreplace 'lib/ansible/constants.py' do |s|
      s.gsub! '/usr/share/ansible', '/usr/local/share/ansible/'
    end

    system "/usr/local/bin/python", "setup.py", "build"

    bin.install Dir['build/scripts-2.7/*']
    (lib+'python2.7/site-packages/ansible').mkpath
    (lib+'python2.7/site-packages/ansible').install Dir['build/lib/ansible/*']

    (share+'ansible').mkpath
    (share+'ansible').install Dir['library/*']
  end
end
