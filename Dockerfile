FROM python:2.7.12-onbuild

WORKDIR /usr/src/app/

CMD ["/usr/local/bin/mkdocs", "build"]