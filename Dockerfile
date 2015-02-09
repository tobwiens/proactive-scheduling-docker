# Run on top of java 7
FROM dockerfile/java:oracle-java7
MAINTAINER Tobias Wiens <tobwiens@gmail.com>

# Environment variables
ENV PROACTIVE_ZIP ProActiveWorkflowsScheduling-linux-x64-6.1.0.zip
ENV PROACTIVE_URL_TO_ZIP http://www.activeeon.com/public_content/releases/ProActive/6.1.0

# Update sources and install python
RUN apt-get update && sudo apt-get install python -y

WORKDIR /data

# Create a one line python script which unzips a file
RUN alias unzip-stream="python -c \"import zipfile,sys,StringIO;zipfile.ZipFile(StringIO.StringIO(sys.stdin.read())).extractall(sys.argv[1] if len(sys.argv) == 2 else '.')\""

# Unzip inside memory
RUN ["/bin/bash", "-c", "wget -q -O- $PROACTIVE_URL_TO_ZIP/$PROACTIVE_ZIP | unzip-stream ."]

CMD /data/ProActiveWorkflowsScheduling-linux-x64-6.1.0/bin/proactive-server 
