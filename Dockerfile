# Run on top of java 7
FROM dockerfile/java:oracle-java7
MAINTAINER Tobias Wiens <tobwiens@gmail.com>
# Checkout repository
WORKDIR /data
RUN wget http://www.activeeon.com/public_content/releases/ProActive/6.1.0/ProActiveWorkflowsScheduling-windows-x64-6.1.0.zip

WORKDIR /data/programming
# The union file system (docker) seems to make all files writeable even if they are set to only be readable.
# Therefore a few test cases will be modified, meaning the assertions will be removed

# Build sources
RUN ./gradlew build
# Start minimal proactive node - standard is port 1099
ENTRYPOINT /data/programming/bin/startNode.sh dockerNode
