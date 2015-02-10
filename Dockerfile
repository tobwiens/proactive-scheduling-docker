# Run on top of java 7
FROM dockerfile/java:oracle-java7
MAINTAINER Tobias Wiens <tobwiens@gmail.com>

# Environment variables
ENV PROACTIVE_ZIP ProActiveWorkflowsScheduling-linux-x64-6.1.0.zip
ENV PROACTIVE_URL_TO_ZIP http://www.activeeon.com/public_content/releases/ProActive/6.1.0

# Update sources and install python
RUN apt-get update && sudo apt-get install python -y

WORKDIR /data

# Unzip inside memory
RUN ["/bin/bash", "-c", "wget -q -O- $PROACTIVE_URL_TO_ZIP/$PROACTIVE_ZIP | python -c \"import zipfile,sys,StringIO;zipfile.ZipFile(StringIO.StringIO(sys.stdin.read())).extractall(sys.argv[1] if len(sys.argv) == 2 else '.')\" "]

# Add bin to PATH for easier execution via CMD
ENV PATH /data/ProActiveWorkflowsScheduling-linux-x64-6.1.0/bin:$PATH

# Standard command
#CMD ["/bin/bash", "-c", "/data/ProActiveWorkflowsScheduling-linux-x64-6.1.0/bin/proactive-node -Dproactive.useIPaddress=true"]
ENTRYPOINT ["proactive-node" ,"-Dproactive.useIPaddress=true"]
