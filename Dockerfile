FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y curl

USER jenkins

# Re-type the line below manually
RUN jenkins-plugin-cli --plugins unique-id
