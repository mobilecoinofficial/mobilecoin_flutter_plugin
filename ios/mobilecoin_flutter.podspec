#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mobilecoin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mobilecoin_flutter'
  s.version          = '0.2.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://mobilecoin.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'MobileCoin' => 'hello@mobilecoin.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'

  s.dependency 'MobileCoin/Core', '~> 6.0.0'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7' }
  s.swift_version = '5.0'
end

