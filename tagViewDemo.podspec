Pod::Spec.new do |s|
  s.name         = "tagViewDemo"
  s.version      = "0.0.2"
  s.ios.deployment_target = '8.0'
  s.summary      = "tagViewDemo."
  s.description  = "详细描述,要长一点,比s.summary这个长长长长长长长长长长"
  s.homepage     = "https://github.com/haohaocai/tagViewDemo"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "karl" => "253440030@qq.com" }
  s.source      = { :git => "https://github.com/haohaocai/tagViewDemo.git", :tag => s.version }
  s.source_files  = "TagView/**/*.{h,m,swift}"

end
