/*
 * Help Desk proxy auto-configuration file
 *
 * $id: proxy.pac,v 1.0.0 2009/01/09 08:14:56 mteixeir Exp $
 * Copyright (C) 2009
 *
 * Last Modified: 2009/09/29 09:10:12
 *
 * This is a Firefox proxy auto configuration file.
 * Help Desk uses it to configure associtates's browsers to use specific
 * proxies based on the tools they need.
 *
 * Stored: hdn.corp.redhat.com:/data/web/proxyAutoConfiguration/proxy.pac
 * Served: http://hdn.corp.redhat.com/proxy.pac
 * References:
 *  http://en.wikipedia.org/wiki/Proxy_auto-config
 *  http://en.wikipedia.org/wiki/Web_Proxy_Autodiscovery_Protocol
 *  http://www.findproxyforurl.com/
 *
 * Author: Mauricio Teixeira <mteixeira@redhat.com>
*/

function FindProxyForURL(url, host) {
  if (shExpMatch(url,"*.hua.hrsmart.com/*")) {
    return "PROXY squid.corp.redhat.com:3128; DIRECT";
  }
  if (shExpMatch(url,"*internal-redhat.icims.com/*")) {
    return "PROXY squid.corp.redhat.com:3128; DIRECT";
  }
  if (shExpMatch(url,"*.adaptiveplanning.com/*")) {
    return "PROXY squid.corp.redhat.com:3128; DIRECT";
  }
  if (shExpMatch(url,"*.fxall.com/*")) {
    return "PROXY squid.corp.redhat.com:3128; DIRECT";
  }
  //https://home.corp.redhat.com/node/41725
  if (shExpMatch(url,"*lwn.net/*")) {
    return "PROXY squid.rdu.redhat.com:3128; DIRECT";
  }
  return "DIRECT";
}
