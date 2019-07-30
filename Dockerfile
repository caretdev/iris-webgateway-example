FROM httpd:2.4

ARG version=2019.2.0.107.0 
ARG platform=lnxubuntux64
ADD WebGateway-${version}-${platform}.tar.gz /tmp/

RUN cd /tmp/WebGateway-${version}-${platform} && \
    mkdir -p /opt/webgateway/bin  && \
    mkdir -p /opt/webgateway/apache  && \
    mkdir -p /opt/webgateway/docs  && \
    cp -p ${platform}/bin/*CSP* /opt/webgateway/bin && \
    cp -p ${platform}/bin/*csp* /opt/webgateway/bin && \
    cp -p ${platform}/bin/shared/cvtcfg /opt/webgateway/bin && \
    cp -p ${platform}/bin/shared/irisconnect.so /opt/webgateway/bin && \
    cp -p ${platform}/bin/shared/libssl.so /opt/webgateway/bin && \
    cp -p ${platform}/bin/shared/libcrypto.so /opt/webgateway/bin && \
    cp -p ${platform}/bin/libz.so /opt/webgateway/bin && \
    cp -p install/apache/mod_csp.c /opt/webgateway/apache && \
    cp -p install/buildver /opt/webgateway/ && \
    tar -C /opt/webgateway/ -xvf /tmp/WebGateway-${version}-${platform}/install/CSP-IRIS-common.tar && \
    rm -rf /tmp/WebGateway-${version}-${platform} && \
    echo LoadModule csp_module_sa /opt/webgateway/bin/CSPa24.so >> ${HTTPD_PREFIX}/conf/httpd.conf && \
    echo CSPFileTypes csp cls zen cxw >> ${HTTPD_PREFIX}/conf/httpd.conf && \
    echo Include /opt/webgateway/apache/webgateway.conf >> ${HTTPD_PREFIX}/conf/httpd.conf 

COPY webgateway.conf /opt/webgateway/apache/
COPY webgateway-entrypoint.sh /opt/webgateway/bin

ENTRYPOINT [ "/opt/webgateway/bin/webgateway-entrypoint.sh" ]