#
#  Be sure to run `pod spec lint CJHTruncTokenLabel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "CJHTruncTokenLabel"
  spec.version      = "0.0.1"
  spec.summary      = "CJHTruncTokenLabel 实现UILabel收缩、展开操作，可以自定文本样式"
  spec.description  = <<-DESC
                       CJHTruncTokenLabel 实现UILabel收缩、展开操作，可以自定文本样式，直接使用。
                      DESC

  spec.homepage     = "https://github.com/mz0266/CJHTruncTokenLabel"
  spec.license      = { :type => "MIT", :file => "https://github.com/mz0266/CJHTruncTokenLabel/LICENSE" }
  spec.author             = { "cuijunhong" => "547977702@qq.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/mz0266/CJHTruncTokenLabel.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
  spec.resources = "CJHTruncTokenLabel/Assets/**/*.{png,jpg}"

end
