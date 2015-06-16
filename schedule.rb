require 'bundler'
Bundler.require :schedule

require 'logger'

def execute_command(command)
  logger = Logger.new(STDERR)
  logger.info command

  result = `#{command} 2>&1`
  logger.error "status = #$?" unless $? == 0
  return if result.empty?

  if $? == 0
    logger.info result
  else
    logger.error result
  end

  gmail = Gmail.connect!(ENV['GMAIL_ADDRESS'], ENV['GMAIL_PASSWORD'])
  gmail.deliver! do
    to      ENV['GMAIL_ADDRESS']
    subject "Schedule #{command}"
    body    result
  end
end

scheduler = Rufus::Scheduler.new
mutex = Mutex.new

scheduler.join
