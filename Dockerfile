FROM ubuntu:20.10

# Install Apt packages
RUN apt-get update

RUN DEBIAN_FRONTEND="noninteractive" apt-get install texlive texlive-lang-german texlive-latex-extra -y

CMD ["/bin/bash"]