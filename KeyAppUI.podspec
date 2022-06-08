Pod::Spec.new do |s|
  s.name             = 'KeyAppUI'
  s.version          = '0.1.0'
  s.summary          = 'Custom UI components, colors, fonts.'
  s.homepage         = 'https://github.com/p2p-org/KeyAppUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Ivan Babich' => 'ivan.babich@p2p.org' }
  s.source           = { :git => 'https://github.com/p2p-org/KeyAppUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/KeyAppUI/**/*'
end
