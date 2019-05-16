Pod::Spec.new do |s|
s.name         = "WKCImageEditKit"
s.version      = "1.0.0"
s.summary      = "Image Edit Tools"
s.homepage     = "https://github.com/WKCLoveYang/WKCImageEditKit.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WKCLoveYang" => "wkcloveyang@gmail.com" }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/WKCLoveYang/WKCImageEditKit.git", :tag => "1.0.0" }
s.source_files  = "WKCImageEditKit/**/*.{h,m}"
s.public_header_files = "WKCImageEditKit/**/*.h"
s.frameworks = "Foundation", "UIKit"
s.requires_arc = true
end

s.subspec 'Adjustment' do |sub|
sub.source_files  = 'WKCImageEditKit/Adjustment/*.{h,m}'
end

s.subspec 'Cut' do |sub|
sub.source_files  = 'WKCImageEditKit/Cut/*.{h,m}'
end

s.subspec 'Draw' do |sub|
sub.source_files  = 'WKCImageEditKit/Draw/*.{h,m}'
end

s.subspec 'Filter' do |sub|
sub.source_files  = 'WKCImageEditKit/Filter/*.{h,m}'
end

s.subspec 'Flip' do |sub|
sub.source_files  = 'WKCImageEditKit/Flip/*.{h,m}'
end

s.subspec 'Resize' do |sub|
sub.source_files  = 'WKCImageEditKit/Resize/*.{h,m}'
end

s.subspec 'Sticker' do |sub|
sub.source_files  = 'WKCImageEditKit/Sticker/*.{h,m}'
end

s.subspec 'Text' do |sub|
sub.source_files  = 'WKCImageEditKit/Text/*.{h,m}'
end

s.subspec 'ToneCurve' do |sub|
sub.source_files  = 'WKCImageEditKit/ToneCurve/*.{h,m}'
end
