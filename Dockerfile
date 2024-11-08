FROM sphinxdoc/sphinx:8.1.3 AS base
WORKDIR /docs
COPY ./docs ./
RUN pip3 install \
sphinx-rtd-theme \
myst-parser

FROM base AS builder
RUN make html

FROM base AS dev
EXPOSE 3000

FROM nginx:alpine3.19-perl AS production
COPY --from=builder /docs/build/html /usr/share/nginx/html
EXPOSE 80