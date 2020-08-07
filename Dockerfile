FROM opensuse/tumbleweed

MAINTAINER Eduardo Lopes <edumlopes@gmail.com>

########################################################################
# Installing repos
RUN zypper in -y curl
RUN curl https://packages.microsoft.com/keys/microsoft.asc > key
RUN rpm --import key
RUN zypper ar https://packages.microsoft.com/yumrepos/vscode vscode
RUN zypper ar https://packages.microsoft.com/yumrepos/microsoft-opensuse15-prod microsoft
RUN zypper ref
RUN zypper up -y
########################################################################
# install emacs_packages
ADD conf/emacs_packages.dat /root/
RUN cat /root/emacs_packages.dat | xargs zypper in -y

# install .net core packages
ADD conf/mono_packages.dat /root/
RUN cat /root/mono_packages.dat | xargs zypper in -y
########################################################################
# adjusting environment
RUN mkdir -p /home/dev/work
RUN useradd dev -u 1000 -d /home/dev
RUN chown -R dev /home/dev
########################################################################
# Installing Emacs
RUN cd /home/dev/ && git clone --depth=1 https://git.savannah.gnu.org/git/emacs.git
ADD scripts/compile_emacs.sh /home/dev/emacs/
RUN /home/dev/emacs/compile_emacs.sh
USER root
RUN cd /home/dev/emacs/build && make install -j8
RUN rm -rf emacs

USER dev
# ENTRYPOINT ["/root/.cabal/bin/pandoc"]
WORKDIR /source
# ENTRYPOINT ["ls"]
# CMD ["--help"]
