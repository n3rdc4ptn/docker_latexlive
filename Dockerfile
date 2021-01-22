FROM ubuntu:20.10

# Options for setup script
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="true"
ARG USERNAME=codespace
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
COPY library-scripts/*.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# Install Apt packages
RUN apt-get update

RUN DEBIAN_FRONTEND="noninteractive" apt-get install xz-utils -y

RUN DEBIAN_FRONTEND="noninteractive" apt-get install texlive texlive-lang-german texlive-latex-extra latexmk -y

USER codespace
RUN tlmgr init-usertree
RUN tlmgr install xkeyval

CMD ["/bin/bash"]