Pod::Spec.new do |s|

  s.name         = "FSUtils"
  s.version      = "0.8.0"
  s.summary      = "FSUtils is a set of commont tools used among different internal projects."
  s.description  = <<-DESC
FSUtils is a set of common tools used among different internal projects. We wrote it so that we didn't have to copy paste code between projects.'
                   DESC
  s.homepage     = "https://github.com/fyrastudio/FSUtils"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jan Lubeck" => "jan@fyrastudio.com" }
  s.social_media_url   = "http://twitter.com/christerfrancis"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/fyrastudio/FSUtils.git", :tag => "#{s.version}" }
  s.source_files  = "FSUtils", "FSUtils/**/*.{h,m}"
  s.exclude_files = "FSUtils/Exclude"
  s.framework  = "UIKit"
  s.requires_arc = true
  s.dependency "MBProgressHUD", "~> 1.1.0"

end
