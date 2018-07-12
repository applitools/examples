require 'eyes_selenium'

describe 'Testing HGTV' do

  before(:all) do |e|
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @eyes = Applitools::Selenium::Eyes.new
    @eyes.api_key = ENV['APPLITOOLS_API_KEY']
    @locator = 'video'
    @js_locator = "document.querySelector('#{@locator}')"
  end
  
  after(:all) do
    @eyes.abort_if_not_closed
    @driver.quit
  end
  
  it 'HGTV Video Validation' do |example|
    #jquery js methods https://www.w3schools.com/tags/ref_av_dom.asp
    
    @eyes.open(driver: @driver, app_name: "HGTV", test_name: example.description, viewport_size: { width: 1350, height: 800 })
    
    @driver.get "https://www.hgtv.com/shows/good-bones/good-bones-season-3-web-exclusive-video/#video-1"
    
    #check for ad and then pause and skip to test video
    is_ad = @driver.find_element(:tag_name, "#{@locator}").attribute("src").include? "snifreewheelpmd-a.akamaihd.net" rescue false
    
    if is_ad
      #wait for ad to start playing
      @wait.until { @driver.execute_script("var vid = #{@js_locator}; return vid.currentTime;") != nil rescue false }
      @driver.execute_script("#{@js_locator}.pause();")
      ad_length = @driver.execute_script("var vid = #{@js_locator}; return vid.duration;")
      @driver.execute_script("var vid = #{@js_locator}; vid.currentTime = #{ad_length};")
    end

    #get playback rate for assertion
    playback_rate = @driver.execute_script("var vid = #{@js_locator}; return vid.defaultPlaybackRate;")
    #get video length
    video_length = @driver.execute_script("var vid = #{@js_locator}; return vid.duration;")
    
    #wait for video to start playing
    sleep 3
    @driver.execute_script("#{@js_locator}.pause();")
    puts "Setting to first frame."
    @driver.execute_script("var vid = #{@js_locator}; vid.currentTime = 0;")
    @eyes.check_region(:tag_name, "#{@locator}", tag: "video First Frame")
    puts "Setting to middle frame."
    @driver.execute_script("var vid = #{@js_locator}; vid.currentTime = #{video_length / 2};")
    @eyes.check_region(:tag_name, "#{@locator}", tag: "video Middle Frame")
    puts "Setting to last frame."
    @driver.execute_script("var vid = #{@js_locator}; vid.currentTime = #{video_length};")
    @eyes.check_region(:tag_name, "#{@locator}", tag: "video Last Frame")
    
    #Check your assertions
    results = @eyes.close(false)
    expect(results.passed?).to eq true
    expect(playback_rate).to eq 1
  end
end