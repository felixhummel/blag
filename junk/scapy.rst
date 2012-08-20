Scapy
=====
Monitor requests locally::

    sniff(iface='lo', filter='port 80', prn=lambda p: p.summary())

HTTP only (requires `HTTP extension <http://blog.sbarbeau.fr/2011/06/http-support-in-scapy.html>`__)::

    def show_http(p):
        if HTTPrequest in p or HTTPresponse in p:
            return p.summary()

    sniff(iface='lo', filter='port 80', prn=show_http)

