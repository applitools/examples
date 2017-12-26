require "httparty"
require 'fileutils'
require 'eyes_images'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class VideoApplitoolsTester
  
  attr_accessor :video_path, :app_name, :test_name, :api_key, :filename, :frame_dir, :eyes
  
  def initialize(video_path, app_name, test_name)
    self.video_path          = video_path
    self.app_name            = app_name
    self.test_name           = test_name
    self.api_key             = ENV['APPLITOOLS_API_KEY']
    self.filename            = "#{video_path.split("/").last}"
    self.frame_dir           = "#{Dir.pwd}/TEST-#{filename.upcase}"
    self.eyes                = Applitools::Images::Eyes.new
    eyes.api_key             = ENV['APPLITOOLS_API_KEY']
    #eyes.log_handler        = Logger.new(STDOUT)
    prepare_test
  end
  
  def prepare_test
    remove_video_file if uri? video_path
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
  
  def uri?(url)
    uri = URI.parse(url)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
  
  def download_video
    puts "\nDownloading: #{video_path}\n"
    File.open(filename, "wb") { |f| f.write HTTParty.get(video_path).body }
  end
  
  def convert_video_to_frames
    #http://www.bugcodemaster.com/article/extract-images-frame-frame-video-file-using-ffmpeg
    %x(ffmpeg -i #{filename} -vf \"select=eq(pict_type\\,I)" -vsync vfr #{frame_dir}/out-%03d.png -hide_banner)
  end
  
  def upload_to_applitools
    eyes.test(app_name: app_name, test_name: test_name) do
      files = Dir.glob("#{frame_dir}/*.png")
      puts "\nMy Images: #{files}\n"
      files.each { |file| eyes.check_image(image_path: file, tag: File.basename(file)) }
    end
  end
  
  def run_test
    if uri? video_path
      download_video
      convert_video_to_frames
      upload_to_applitools
    elsif File.exists? video_path
      convert_video_to_frames
      upload_to_applitools
    else
      puts "Incorrect Video URL or File Path: #{video_path}"
      abort
    end
  end
end

if [ARGV[0], ARGV[1], ARGV[2]].include? nil
  puts "Run Example: ruby video_to_image.rb 'https://applitools.com/images/videos/step2.mp4' 'Video Frames' 'Steps Example'"
  puts "Or..."
  puts "Run Example: ruby video_to_image.rb '/path/to/video.mp4' 'Video Frames' 'Steps Example'\n"
else
  my_test = VideoApplitoolsTester.new(ARGV[0], ARGV[1], ARGV[2])
  my_test.run_test
end