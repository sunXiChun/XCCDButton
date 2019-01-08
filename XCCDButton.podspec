Pod::Spec.new do |s|
s.name             = 'XCCDButton'
s.version          = '0.0.1'
s.summary          = '简单的带有冷却时间的按钮'
s.description      = <<-DESC
简单的带有冷却时间的按钮
DESC

s.homepage         = 'https://github.com/sunXiChun/XCCDButton'
s.author           = { 'xi chun' => '996058968@qq.com' }
s.source           = { :git => 'https://github.com/sunXiChun/XCCDButton.git', :tag => s.version.to_s }
s.ios.deployment_target = '6.0'

s.source_files = 'XCCDButton/**/XCCDButton.{h,m}'
end
