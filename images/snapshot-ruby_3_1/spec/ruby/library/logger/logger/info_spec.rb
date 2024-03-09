require_relative '../../../spec_helper'
require_relative '../fixtures/common'

describe "Logger#info?" do
  before :each do
    @path = tmp("test_log.log")
    @log_file = File.open(@path, "w+")
    @logger = Logger.new(@path)
  end

  after :each do
    @logger.close
    @log_file.close unless @log_file.closed?
    rm_r @path
  end

  it "returns true if severity level allows info messages" do
    @logger.level = Logger::INFO
    @logger.should.info?
  end

  it "returns false if severity level does not allow info messages" do
    @logger.level = Logger::FATAL
    @logger.should_not.info?
  end
end

describe "Logger#info" do
  before :each do
    @path = tmp("test_log.log")
    @log_file = File.open(@path, "w+")
    @logger = Logger.new(@path)
  end

  after :each do
    @logger.close
    @log_file.close unless @log_file.closed?
    rm_r @path
  end

  it "logs a INFO message" do
    @logger.info("test")
    @log_file.rewind
    LoggerSpecs.strip_date(@log_file.readlines.first).should == "INFO -- : test\n"
  end

  it "accepts an application name with a block" do
    @logger.info("MyApp") { "Test message" }
    @log_file.rewind
    LoggerSpecs.strip_date(@log_file.readlines.first).should == "INFO -- MyApp: Test message\n"
  end

end
