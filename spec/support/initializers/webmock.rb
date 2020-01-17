VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir =  Pathname.new(__dir__).join('..', 'vcr_cassettes').expand_path
  config.hook_into :webmock # or :fakeweb
  config.configure_rspec_metadata!
  config.default_cassette_options = { allow_playback_repeats: true }

end

WebMock.disable_net_connect!(allow_localhost: true)
