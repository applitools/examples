# require "httparty"
# require 'fileutils'

# url = "https://applitools.com/images/videos/step2.mp4"
# file_name = "#{Dir.pwd}/#{url.split("/").last}"
#
# FileUtils.rm_f file_name if File.exists? file_name
#
# File.open(video_file, "wb") { |f| f.write HTTParty.get(url).body }
#
# Dir.mkdir "frames" unless Dir.exists? "frames"
#
# %x(ffmpeg -i #{file_name} -vf \"select=eq(pict_type\\,I)" -vsync vfr frames/out-%03d.jpg -hide_banner)
# %x(java -jar ../ImageTester.jar -k 9RkMajXrzS1Zu110oTWQps102CHiPRPmeyND99E9iL0G7yAc110 -a Video Frames -ap Steps Example -f frames)
#
# FileUtils.rm_r "frames" if Dir.exists? "frames"


require "httparty"
require 'fileutils'

class VideoApplitoolsTester
  
  attr_accessor :image_tester_binary, :video_url, :app_name, :test_name, :api_key, :filename, :frame_dir
  
  def initialize(image_tester_binary, video_url, app_name, test_name)
    self.image_tester_binary = image_tester_binary
    self.video_url           = video_url
    self.app_name            = app_name
    self.test_name           = test_name
    self.api_key             = ENV['APPLITOOLS_KEY']
    self.filename            = "#{video_url.split("/").last}"
    self.frame_dir           = "#{Dir.pwd}/TEST-#{filename.upcase}"
    prepare_test
  end
  
  def prepare_test
    remove_video_file
    remove_frames_dir
    create_frames_dir
  end
  
  def remove_video_file
    FileUtils.rm_f filename if File.exists? filename
  end
  
  def remove_frames_dir
    FileUtils.rm_r frame_dir if Dir.exists? frame_dir
  end
  
  def create_frames_dir
    Dir.mkdir frame_dir unless Dir.exists? frame_dir
  end
  
  def download_video
    File.open(filename, "wb") { |f| f.write HTTParty.get(video_url).body }
  end
  
  def convert_video_to_frames
    #http://www.bugcodemaster.com/article/extract-images-frame-frame-video-file-using-ffmpeg
    %x(ffmpeg -i #{filename} -vf \"select=eq(pict_type\\,I)" -vsync vfr #{frame_dir}/out-%03d.jpg -hide_banner)
  end
  
  def upload_to_applitools
    %x(java -jar #{image_tester_binary} -k #{api_key} -a #{app_name} -ap #{test_name} -f #{frame_dir})
  end
  
  def run_test
    download_video
    convert_video_to_frames
    upload_to_applitools
  end
end

my_test = VideoApplitoolsTester.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
my_test.run_test