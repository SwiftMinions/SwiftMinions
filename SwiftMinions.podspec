#
# Be sure to run `pod lib lint Aletheia.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftMinions'
  s.version          = '0.0.2'
  s.summary          = 'SwiftMinions'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Helper function is always useful for any project, such as frame size, string, date convertion.

  This framework is used for my porject for quick and safy develope. My goal of this project will includes network,

  cache, log and some basic UI component.

  DESC
   
  s.homepage         = 'https://github.com/SwiftMinions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chen Stephen' => 'tasb00429@gmail.com' }
  s.source           = { :git => 'https://github.com/SwiftMinions/SwiftMinions.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.cocoapods_version = '>= 1.4.0'
  s.default_subspec = 'Core'
  s.swift_version = '5.1'
  
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

  # s.resource_bundles = {
  #   'Aletheia' => ['Aletheia/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.subspec 'Core' do |ss|
    ss.source_files  = 'Sources/SwiftMinions/UIKit'
    ss.framework = 'Foundation'
  end

  # s.subspec "Network" do |ss|
  #   ss.source_files = 'Aletheia/Sources/Networking'
  #   ss.dependency "Aletheia/Core"
  #   ss.dependency 'Alamofire', '4.8.0'
  #   ss.dependency 'Kingfisher', '4.10.0'
  # end




end
