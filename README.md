# A simple Dockerized version of Prometheus jmx_exporter

Do you...
- Need to derive Prometheus metrics from JMX MBeans exposed by an application?
- Want to do so without depending on installing a whole entire JDK on your host?

If the answer to both of these questions is "yes", you're in the right place! :)

## Basic usage
1. Grab a container.[^1]
2. Run it while mounting a valid JMX Exporter configuration[^2] at `/opt/app/jmx-exporter.yml`. By default, resulting Prometheus metrics will be exposed at port 5556, but on your host, you can expose this as a different port if you so choose.

[^1]: Pre-built containers are not yet available, so you'll need to build the container yourself using the `Dockerfile` in this repo for the time being.
[^2]: There are a wide variety of options available for configuring JMX Exporter; you are encouraged to visit the [JMX Exporter homepage](https://prometheus.github.io/jmx_exporter/), open the dropdown for the version corresponding to that packaged by this container, further open the dropdown for the *Standalone* exporter, and explore the various options available.