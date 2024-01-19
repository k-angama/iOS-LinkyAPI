
Pod::Spec.new do |s|
  s.name             = 'LinkyAPI'
  s.version          = '1.0.3'
  s.swift_version    = "5.0"
  s.summary          = 'API for Linky smart meters.'

  s.description      = <<-DESC
The LinkyAPI Swift Library is a Swift package that provides a convenient way to access Linky's electricity consumption and production data through Enedis API. This library simplifies the process of obtaining user authorization, fetching consumption data.
DESC

  s.homepage         = 'https://github.com/k-angama/iOS-LinkyAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kangama' => 'karim.angama@gmail.com' }
  s.source           = { :git => 'https://github.com/k-angama/iOS-LinkyAPI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/k_angama'

  s.ios.deployment_target = '16.4'

  s.source_files = 'Sources/LinkyAPI/**/*.{swift}'
  s.exclude_files = 'Tests/LinkyAPITests/**/*.{swift}'
  
  s.frameworks = 'UIKit'
  
end
