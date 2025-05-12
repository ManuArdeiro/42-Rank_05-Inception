FROM gcr.io/cadvisor/cadvisor:latest

LABEL maintainer="jolopez- <jolopez-@student.42madrid.com>"

# Expose cAdvisor port
EXPOSE 8080

# Run cAdvisor
ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr"]