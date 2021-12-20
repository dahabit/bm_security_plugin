#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint bm_security_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'bm_security_plugin'
  s.version          = '1.0.3'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://brickmakers.de'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Pascal Friedrich, BRICKMAKERS GmbH' => 'pascal.friedrich@brickmakers.de' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'IOSSecuritySuite'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end