#
# Be sure to run `pod lib lint GoogleBooksApiClient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GoogleBooksApiClient'
  s.version          = '0.0.2'
  s.summary          = 'Google Books API Client Library for Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The Google Books API Client Library for Swift
                       DESC

  s.homepage         = 'https://github.com/google-books/swift-api-client'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gomi_ningen' => 'gomi2ngen@gmail.com' }
  s.source           = { :git => 'https://github.com/google-books/swift-api-client.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gomi_ningen'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GoogleBooksApiClient/**/*'
  
  # s.resource_bundles = {
  #   'GoogleBooksApiClient' => ['GoogleBooksApiClient/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
