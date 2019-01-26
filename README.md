# DataDog Agent App

Deploy the DataDog Agent and API key as a standard Convox app.

## Quick Start

```bash
# check out the repo
$ git clone https://github.com/convox-examples/dd-agent.git
$ cd dd-agent

# create the app and secrets
$ convox apps create
$ convox env set DD_API_KEY=<your api key>
$ convox deploy
```

## Custom Metrics

In addition to collecting instance and container metrics, you can write custom metrics to the local Datadog agent with a statsd client over UDP. An example Ruby producer is:

```ruby
require "sinatra"
require "datadog/statsd"

agent  = `ip route list match 0/0 | awk '{print $3}'`.chomp
statsd = Datadog::Statsd.new(agent, 8125)

get "/health" do
  UDPSocket.new.send 'page.views:1|c', 0, agent, 8125
  statsd.increment('health')
  status 200
end
```
