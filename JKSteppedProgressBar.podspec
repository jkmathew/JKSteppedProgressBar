#
# Be sure to run `pod lib lint JKSteppedProgressBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'JKSteppedProgressBar'
    s.version          = '0.3.0'
    s.summary          = 'JKSteppedProgressBar is an iOS UI component that indicates step by step progress'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    JKSteppedProgressBar is an iOS UI component written in Swift to show step by step progress
                         DESC

    s.homepage         = 'https://github.com/Johnykutty/JKSteppedProgressBar'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Johnykutty Mathew' => 'johnykutty.mathew@gmail.com' }
    s.source           = { :git => 'https://github.com/jkmathew/JKSteppedProgressBar.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = 'JKSteppedProgressBar/Classes/*.swift'

    # s.resource_bundles = {
    #   'JKSteppedProgressBar' => ['JKSteppedProgressBar/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
end
