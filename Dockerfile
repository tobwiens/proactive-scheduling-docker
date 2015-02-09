# Run on top of java 7
FROM dockerfile/java:oracle-java7
MAINTAINER Tobias Wiens <tobwiens@gmail.com>

# Environment variables
ENV PROACTIVE_ZIP ProActiveWorkflowsScheduling-linux-x64-6.1.0.zip
ENV PROACTIVE_PATH_TO_ZIP http://www.activeeon.com/public_content/releases/ProActive/6.1.0

# Download the proactive scheduler
WORKDIR /data
RUN ["/bin/bash", "-c", "wget $PROACTIVE_PATH_TO_ZIP/$PROACTIVE_ZIP"]

# Create a one line python script which unzips a file
#RUN alias unzip-stream="python -c \"import #zipfile,sys,StringIO;zipfile.ZipFile(StringIO.StringIO(sys.stdin.read())).extractall(sys.argv[1] if len(sys.argv) == 2 else '.')\""

#

# Unzip scheduler and remove zip file
RUN ["/bin/bash", "-c", "unzip $PROACTIVE_ZIP"]
# RUN ["/bin/bash", "-c", "rm $PROACTIVE_ZIP"] # It is saved inside the layers anyway

CMD /data/ProActiveWorkflowsScheduling-linux-x64-6.1.0/bin/proactive-server 
