require 'eyes_selenium'

describe 'Testing Applitools' do

  before(:all) do |e|
    @driver = Selenium::WebDriver.for :chrome
    @eyes = Applitools::Selenium::Eyes.new
    @eyes.api_key = ENV['APPLITOOLS_API_KEY']
    @driver.get 'https://applitools.com/images/videos/step2.mp4'
    @video_loc = "document.querySelector('video')"
  end

  after(:all) do
    @eyes.abort_if_not_closed
    @driver.quit
  end
  
  before(:each) do
    @driver.execute_script("document.querySelector('video').pause();")
    @video_length = @driver.execute_script("var vid = #{@video_loc}; return vid.duration;")
    @playback_rate = @driver.execute_script("var vid = #{@video_loc}; return vid.defaultPlaybackRate;")
    @auto_play_bool = @driver.execute_script("var vid = #{@video_loc}; return vid.autoplay;")
  end

  it 'Validate Video' do
    @eyes.open(driver: @driver, app_name: "Applitools Step Video", test_name: "Validate Video", viewport_size: { width: 1350, height: 800 })
    #set to first frame
    @driver.execute_script("var vid = #{@video_loc}; return vid.currentTime = 0;")
    @eyes.check_region(:css, 'video', tag: 'First Frame')
    #middle frame
    @driver.execute_script("var vid = #{@video_loc}; return vid.currentTime = #{@video_length / 2};")
    @eyes.check_region(:css, 'video', tag: 'Middle Frame')
    #last frame
    @driver.execute_script("var vid = #{@video_loc}; return vid.currentTime = #{@video_length};")
    @eyes.check_region(:css, 'video', tag: 'Last Frame')
    
    results = @eyes.close(false)
    expect(@playback_rate).to eq 1
    expect(@auto_play_bool).to eq true
    expect(results.passed?).to eq true
  end
end