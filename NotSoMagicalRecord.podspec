Pod::Spec.new do |s|
  s.default_subspec = 'Core'
  s.name     = 'NotSoMagicalRecord'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'Super Awesome Easy Fetching for Core Data 1!!!11!!!!1!.'
  s.homepage = 'http://github.com/bugix/NotSoMagicalRecord'
  s.author   = { 'Saul Mora' => 'saul@magicalpanda.com', 'Tony Arnold' => 'tony@thecocoabots.com' }
  s.source   = { :git => 'https://github.com/bugix/NotSoMagicalRecord.git', :tag => "v#{s.version}" }
  s.description  = 'Handy fetching helpers to make Core Data a little easier to use.'
  s.requires_arc = true
  s.ios.deployment_target = '10.0'

  s.subspec 'Core' do |sp|
    sp.framework    = 'CoreData'
    sp.header_dir   = 'NotSoMagicalRecord'
    sp.source_files = 'NotSoMagicalRecord/**/*.{h,m}'
    sp.prefix_header_contents = <<-EOS
    #import <CoreData/CoreData.h>
    #import <NotSoMagicalRecord/NotSoMagicalRecord.h>
    EOS
  end

end
