
Pod::Spec.new do |spec|

  spec.name         = "YoutubeLinkExtractor"
  spec.version      = "1.0.0"
  spec.summary      = "This framework can directly extract Youtube video link."
  spec.description  = "YoutubeLinkExtractor will return a link that can play Youtube videos with optimized settings for video and audio."
  spec.homepage     = "https://www.CongLeSolutionX.tech"

  spec.license      = "MIT"

  spec.author             = { "CongLeSolutionX" => "longchike@gmail.com" }
  spec.social_media_url   = "https://www.facebook.com/CongLeProgrammer"
  spec.social_media_url   = "https://www.instagram.com/conglesolutionx"
  spec.social_media_url   = "https://twitter.com/cong_le"
  spec.social_media_url   = "https://www.linkedin.com/in/conglesolutionx/"

  spec.platform     = :ios, "10.0"
  spec.source       = { :path => '.' }
  spec.source_files = "YoutubeLinkExtractor"
  spec.framework  = "YoutubeDirectLinkExtractor"
  spec.swift_version = "5.0"

end
