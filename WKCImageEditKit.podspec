Pod::Spec.new do |s|
s.name         = "WKCImageEditKit"
s.version      = "1.1.5"
s.summary      = "Image Edit Tools"
s.homepage     = "https://github.com/WKCLoveYang/WKCImageEditKit.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WKCLoveYang" => "wkcloveyang@gmail.com" }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/WKCLoveYang/WKCImageEditKit.git", :tag => "1.1.5" }

s.frameworks = "Foundation", "UIKit"
s.requires_arc = true
s.source_files  = "WKCImageEditKit/**/*.{h,m}"
s.public_header_files = "WKCImageEditKit/**/*.h"
end
