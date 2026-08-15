FROM ubuntu:26.04 AS source

ADD --checksum=sha256:44394b47803246f5466e9a4202e6a8b8e40e228045715ed28c7af9cdb6845c11 \
    https://github.com/bottlesdevs/wine/releases/download/protosoda-11.0-1/ProtoSoda-11.0-1.tar.gz \
    /tmp/protosoda.tar.gz

RUN mkdir -p /out/ProtoSoda && \
    tar -xzf /tmp/protosoda.tar.gz -C /out/ProtoSoda --strip-components=1 && \
    test -x /out/ProtoSoda/proton && \
    test -f /out/ProtoSoda/compatibilitytool.vdf

FROM ghcr.io/containerpak/wine:main

COPY --from=source /out/ProtoSoda /usr/share/steam/compatibilitytools.d/ProtoSoda-11.0-1
COPY --chmod=0755 protosoda /usr/bin/protosoda
