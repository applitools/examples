require 'eyes_selenium'

describe 'Testing Applitools' do

  before(:all) do |e|
    @driver = Selenium::WebDriver.for :firefox #have to use FIREFOX...
    @eyes = Applitools::Selenium::Eyes.new
    @eyes.api_key = ENV['APPLITOOLS_API_KEY']
    @page_url = "https://applitools.com/"
    @driver.get @page_url
    #Collect all video paths on a page.
    @videos = @driver.find_elements(:tag_name, "video").map { |v| v.attribute('innerHTML').strip.match(/images\/videos.*\" /)[0].strip.tr('"','') }
    @video_loc = "document.querySelector('video')"
  end

  after(:all) do
    @eyes.abort_if_not_closed
    @driver.quit
  end
  
  it 'Visual Validate Videos' do |example|
    @eyes.open(driver: @driver, app_name: "Applitools Example Videos", test_name: example.description, viewport_size: { width: 1350, height: 800 })
    @videos.each do |video|
      puts "Navigating to: #{@page_url}#{video}"
      @driver.get "#{@page_url}#{video}"
      
      #pause video and get details
      @driver.execute_script("document.querySelector('video').pause();")
      video_length = @driver.execute_script("var vid = #{@video_loc}; return vid.duration;")
      playback_rate = @driver.execute_script("var vid = #{@video_loc}; return vid.defaultPlaybackRate;")
      auto_play_bool = @driver.execute_script("var vid = #{@video_loc}; return vid.autoplay;")
            
      puts "Set #{video} to first frame."
      @driver.execute_script("var vid = #{@video_loc}; vid.currentTime = 0;")
      @eyes.check_region(:css, 'video', tag: "#{video} First Frame")
      puts "Set #{video} to middle frame."
      @driver.execute_script("var vid = #{@video_loc}; vid.currentTime = #{video_length / 2};")
      @eyes.check_region(:css, 'video', tag: "#{video} Middle Frame")
      puts "Set #{video} to last frame."
      @driver.execute_script("var vid = #{@video_loc}; vid.currentTime = #{video_length};")
      @eyes.check_region(:css, 'video', tag: "#{video} Last Frame")
      
      expect(playback_rate).to eq 1
      expect(auto_play_bool).to eq true
    end
    results = @eyes.close(false)
    expect(results.passed?).to eq true
  end
end