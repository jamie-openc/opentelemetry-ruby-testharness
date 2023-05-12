require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/all'
require 'sinatra'
require 'json'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'test-harness'
  c.use 'OpenTelemetry::Instrumentation::Sinatra'
end

Tracer = OpenTelemetry.tracer_provider.tracer('test-tracer')

puts "Using: OTEL_EXPORTER_OTLP_ENDPOINT = '#{ENV['OTEL_EXPORTER_OTLP_ENDPOINT']}'"

set :bind, '0.0.0.0'

get '/stevie-says/:something' do
  sth = params['something']
  puts "Processing GET request"
  Tracer.in_span('stevie-says', attributes: {"devops" => "rule!"}) do |span|
    span.add_event(sth)
    puts "Added event - #{sth}\n"
  end
  JSON.generate({:message => "Stevie says #{sth}"})
end
