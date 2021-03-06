#!MANAGED-CONFIG {{ downloadUrl }} interval=3600 strict=false

[General]
bypass-system = true
loglevel = notify
replica = false
doh-format = wireformat
skip-proxy = 127.0.0.1, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, 100.64.0.0/10, localhost, *.local, *.crashlytics.com, *.edu.cn
tun-excluded-routes = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12
wifi-access-http-port = 8888
wifi-access-socks5-port = 8889
external-controller-access = ray@0.0.0.0:6170
internet-test-url = {{ proxyTestUrl }}
proxy-test-url = {{ proxyTestUrl }}
test-timeout = 5
allow-wifi-access = true
exclude-simple-hostnames = true
ipv6 = false
network-framework = false
show-error-page-for-reject = true
tls-provider = default
use-default-policy-if-wifi-not-primary = false
wifi-assist = true
geoip-maxmind-url = https://cdn.jsdelivr.net/gh/Hackl0us/GeoIP2-CN@release/Country.mmdb
http-listen = 0.0.0.0
socks5-listen = 0.0.0.0
dns-server = 223.5.5.5, 119.29.29.29, system

[Proxy]
Crop-VPN = direct, interface=utun7
{{ getSurgeNodes(nodeList) }}

[Proxy Group]
🚀 Select = select, 🇭🇰 HK Auto, 🇭🇰 HK Fallback, 🇯🇵 JP Auto, 🇯🇵 JP Fallback, 🚀 ClashX, {{ getNodeNames(nodeList, hkFilter) }}, {{ getNodeNames(nodeList, japanFilter) }}
🎬 Netflix Select = select, 🚀 Proxy, 🇭🇰 HK Auto, 🇭🇰 HK Fallback, 🇯🇵 JP Auto, 🇯🇵 JP Fallback, 🚀 ClashX, {{ getNodeNames(nodeList, hkFilter) }}, {{ getNodeNames(nodeList, japanFilter) }}
🍎 Apple = select, DIRECT, 🚀 Proxy, 🇭🇰 HK Auto, 🇭🇰 HK Fallback, 🇯🇵 JP Auto, 🇯🇵 JP Fallback, 🚀 ClashX, {{ getNodeNames(nodeList, hkFilter) }}, {{ getNodeNames(nodeList, japanFilter) }}
🍎 Apple CDN = select, DIRECT, 🍎 Apple
🇭🇰 HK Auto = url-test, {{ getNodeNames(nodeList, hkFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
🇭🇰 HK Fallback = fallback, {{ getNodeNames(nodeList, hkFilter) }}, url={{ proxyTestUrl }}
🇯🇵 JP Auto = url-test, {{ getNodeNames(nodeList, japanFilter) }}, url = {{ proxyTestUrl }}, interval = 1200
🇯🇵 JP Fallback = fallback, {{ getNodeNames(nodeList, japanFilter) }}, url={{ proxyTestUrl }}
🚀 Proxy = ssid, default = 🚀 Select, "Ray-Home" = DIRECT
🎬 Netflix = ssid, default = 🎬 Netflix Select, "Ray-Home" = DIRECT
🇨🇳 Domestic = select, DIRECT, 🚀 Proxy
🛑 Block = select, REJECT, DIRECT, 🚀 Proxy

[Rule]
PROCESS-NAME,clash,DIRECT
PROCESS-NAME,ss-local,DIRECT
PROCESS-NAME,privoxy,DIRECT
PROCESS-NAME,trojan,DIRECT
PROCESS-NAME,trojan-go,DIRECT
PROCESS-NAME,naive,DIRECT
PROCESS-NAME,Thunder,DIRECT
PROCESS-NAME,DownloadService,DIRECT
PROCESS-NAME,qBittorrent,DIRECT
PROCESS-NAME,Transmission,DIRECT
# PROCESS-NAME,fdm,DIRECT
PROCESS-NAME,aria2c,DIRECT
PROCESS-NAME,Folx,DIRECT
PROCESS-NAME,NetTransport,DIRECT
PROCESS-NAME,uTorrent,DIRECT
PROCESS-NAME,WebTorrent,DIRECT
PROCESS-NAME,Jump Desktop,DIRECT
PROCESS-NAME,JumpConnect,DIRECT

RULE-SET,https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Rules/cn-ad.list,REJECT-TINYGIF

DOMAIN-SET,https://cdn.jsdelivr.net/gh/fgprodigal/anti-AD@master/anti-ad-surge2.txt,🛑 Block

URL-REGEX,https://app.bilibili.com/x/v2/(splash|search/(defaultword|square)),🛑 Block
URL-REGEX,https://api.bilibili.com/x/v2/dm/ad,🛑 Block
DOMAIN,appcloud2.zhihu.com,🛑 Block
DOMAIN,118.89.204.198,🛑 Block
USER-AGENT,AVOS*,🛑 Block
URL-REGEX,https://api.zhihu.com/(ad|drama|fringe|commercial|market/popover|search/(top|preset|tab)|.*featured-comment-ad),🛑 Block
AND,((USER-AGENT,ZhihuHybrid*), (URL-REGEX,.*recommend)),🛑 Block

# system
RULE-SET,SYSTEM,DIRECT

# LAN
RULE-SET,LAN,DIRECT

# VPN
DOMAIN-SUFFIX,n.com,Crop-VPN
DOMAIN-SUFFIX,vc184.bdnetlab.com,Crop-VPN

{{ remoteSnippets.apple.main('🚀 Proxy', '🍎 Apple', '🍎 Apple CDN', 'DIRECT', '🚀 Proxy') }}

DOMAIN-SET,https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Rules/icloud.txt,🚀 Proxy
DOMAIN-SET,https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Rules/google.txt,🚀 Proxy
RULE-SET,https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Rules/netflix.list,🎬 Netflix
DOMAIN-SET,https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Rules/proxy.txt,🚀 Proxy
DOMAIN-SET,https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Rules/direct.txt,🇨🇳 Domestic
RULE-SET,https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Rules/cncidr.txt,🇨🇳 Domestic

# GeoIP CN
GEOIP,CN,🇨🇳 Domestic

# Final
FINAL,🚀 Proxy,dns-failed

[Host]
vc184.bdnetlab.com = 192.168.1.184
n.com = 192.168.31.5
rayw.tech = server:syslib

[URL Rewrite]
# > Redirect Google Service
^https?:\/\/(www.)?g\.cn https:\/\/www.google.com 302
^https?:\/\/(www.)?google\.cn https:\/\/www.google.com 302
# > Redirect HTTP to HTTPS
^https?:\/\/(www.)?taobao\.com\/ https:\/\/www.taobao.com\/ 302
^https?:\/\/(www.)?jd\.com\/ https:\/\/www.jd.com\/ 302
^https?:\/\/(www.)?mi\.com\/ https:\/\/www.mi.com\/ 302
^https?:\/\/you\.163\.com\/ https:\/\/you.163.com\/ 302
^https?:\/\/(www.)?suning\.com\/ https:\/\/suning.com\/ 302
^https?:\/\/(www.)?yhd\.com https:\/\/yhd.com\/ 302
# Redirect False to True
# > IGN China to IGN Global
^https?:\/\/(www.)?ign\.xn--fiqs8s\/ http:\/\/cn.ign.com\/ccpref\/us 302
# > Fake Website Made By Makeding
^https?:\/\/(www.)?abbyychina\.com\/ http:\/\/www.abbyy.cn\/ 302
^https?:\/\/(www.)?bartender\.cc\/ https:\/\/cn.seagullscientific.com 302
^https?:\/\/(www.)?betterzip\.net\/ https:\/\/macitbetter.com\/ 302
^https?:\/\/(www.)?beyondcompare\.cc\/ https:\/\/www.scootersoftware.com\/ 302
^https?:\/\/(www.)?bingdianhuanyuan\.cn\/ http:\/\/www.faronics.com\/zh-hans\/ 302
^https?:\/\/(www.)?chemdraw\.com\.cn\/ http:\/\/www.cambridgesoft.com\/ 302
^https?:\/\/(www.)?codesoftchina\.com\/ https:\/\/www.teklynx.com\/ 302
^https?:\/\/(www.)?coreldrawchina\.com\/ https:\/\/www.coreldraw.com\/cn\/ 302
^https?:\/\/(www.)?crossoverchina\.com\/ https:\/\/www.codeweavers.com\/ 302
^https?:\/\/(www.)?easyrecoverychina\.com\/ https:\/\/www.ontrack.com\/ 302
^https?:\/\/(www.)?ediuschina\.com\/ https:\/\/www.grassvalley.com\/ 302
^https?:\/\/(www.)?flstudiochina\.com\/ https:\/\/www.image-line.com\/flstudio\/ 302
^https?:\/\/(www.)?formysql\.com\/ https:\/\/www.navicat.com.cn 302
^https?:\/\/(www.)?guitarpro\.cc\/ https:\/\/www.guitar-pro.com\/ 302
^https?:\/\/(www.)?huishenghuiying\.com\.cn\/ https:\/\/www.corel.com\/cn\/ 302
^https?:\/\/(www.)?iconworkshop\.cn\/ https:\/\/www.axialis.com\/iconworkshop\/ 302
^https?:\/\/(www.)?imindmap\.cc\/ https:\/\/imindmap.com\/zh-cn\/ 302
^https?:\/\/(www.)?jihehuaban\.com\.cn\/ https:\/\/sketch.io\/ 302
^https?:\/\/(www.)?keyshot\.cc\/ https:\/\/www.keyshot.com\/ 302
^https?:\/\/(www.)?mathtype\.cn\/ http:\/\/www.dessci.com\/en\/products\/mathtype\/ 302
^https?:\/\/(www.)?mindmanager\.cc\/ https:\/\/www.mindjet.com\/ 302
^https?:\/\/(www.)?mindmapper\.cc\/ https:\/\/mindmapper.com 302
^https?:\/\/(www.)?mycleanmymac\.com\/ https:\/\/macpaw.com\/cleanmymac 302
^https?:\/\/(www.)?nicelabel\.cc\/ https:\/\/www.nicelabel.com\/ 302
^https?:\/\/(www.)?ntfsformac\.cc\/ https:\/\/www.tuxera.com\/products\/tuxera-ntfs-for-mac-cn\/ 302
^https?:\/\/(www.)?ntfsformac\.cn\/ https:\/\/www.paragon-software.com\/ufsdhome\/zh\/ntfs-mac\/ 302
^https?:\/\/(www.)?overturechina\.com\/ https:\/\/sonicscores.com\/overture\/ 302
^https?:\/\/(www.)?passwordrecovery\.cn\/ https:\/\/cn.elcomsoft.com\/aopr.html 302
^https?:\/\/(www.)?pdfexpert\.cc\/ https:\/\/pdfexpert.com\/zh 302
^https?:\/\/(www.)?ultraiso\.net\/ https:\/\/cn.ezbsystems.com\/ultraiso\/ 302
^https?:\/\/(www.)?vegaschina\.cn\/ https:\/\/www.vegas.com\/ 302
^https?:\/\/(www.)?xmindchina\.net\/ https:\/\/www.xmind.cn\/ 302
^https?:\/\/(www.)?xshellcn\.com\/ https:\/\/www.netsarang.com\/products\/xsh_overview.html 302
^https?:\/\/(www.)?yuanchengxiezuo\.com\/ https:\/\/www.teamviewer.com\/zhcn\/ 302
^https?:\/\/(www.)?zbrushcn\.com\/ http:\/\/pixologic.com\/ 302
^https?:\/\/aweme-eagle(.*)\.snssdk\.com\/aweme\/v2\/ https:\/\/aweme-eagle$1.snssdk.com\/aweme\/v1\/ 302
# JD Protection
^https?:\/\/coupon\.m\.jd\.com\/ https:\/\/coupon.m.jd.com\/ 302
^https?:\/\/h5\.m\.jd\.com\/ https:\/\/h5.m.jd.com\/ 302
^https?:\/\/item\.m\.jd\.com\/ https:\/\/item.m.jd.com\/ 302
^https?:\/\/m\.jd\.com\/ https:\/\/m.jd.com\/ 302
^https?:\/\/newcz\.m\.jd\.com\/ https:\/\/newcz.m.jd.com\/ 302
^https?:\/\/p\.m\.jd\.com\/ https:\/\/p.m.jd.com\/ 302
^https?:\/\/so\.m\.jd\.com\/ https:\/\/so.m.jd.com\/ 302
^https?:\/\/union\.click\.jd\.com\/jda? http:\/\/union.click.jd.com\/jda?adblock= header
^https?:\/\/union\.click\.jd\.com\/sem.php? http:\/\/union.click.jd.com\/sem.php?adblock= header
^https?:\/\/www.jd.com\/ https:\/\/www.jd.com\/ 302
^https?:\/\/(.*)\.amemv\.com\/aweme\/v2\/(follow\/)?feed\/ https://$1.amemv.com/aweme/v1/$2feed/ header

[MITM]
skip-server-cert-verify = true
hostname = *.amemv.com, api.bilibili.com, app.bilibili.com, api.live.bilibili.com, ios.prod.ftl.netflix.com, www.zhihu.com, api.zhihu.com, link.zhihu.com, 118.89.204.198
ca-passphrase = RaySurge2021
ca-p12 = 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

[Script]
douyin_ad = type=http-response,pattern=^https?:\/\/.*\.amemv\.com\/aweme\/v1\/(feed|mix\/aweme|aweme\/post|(multi\/)?aweme\/detail|follow\/feed|nearby\/feed|search\/item|general\/search\/single|hot\/search\/video\/list)\/,requires-body=1,max-size=-1,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/douyin.js
bilibili_space = type=http-response,requires-body=1,max-size=0,pattern=^https://app.bilibili.com/x/v2/space\?access_key,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20bilibili%20space.js
bilibili_tab = type=http-response,requires-body=1,max-size=0,pattern=^https://app.bilibili.com/x/resource/show/tab\?access_key,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20bilibili%20tab.js
bilibili_feed = type=http-response,requires-body=1,max-size=0,pattern=^https://app.bilibili.com/x/v2/feed/index\?access_key,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20bilibili%20feed.js
bilibili_account = type=http-response,requires-body=1,max-size=0,pattern=^https://app.bilibili.com/x/v2/account/mine\?access_key,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20bilibili%20account.js
bilibili_view = type=http-response,requires-body=1,max-size=0,pattern=^https://app.bilibili.com/x/v2/view\?access_key,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20bilibili%20view%20relate.js
bilibili_reply = type=http-response,requires-body=1,max-size=0,pattern=^https://api.bilibili.com/x/v2/reply/main\?access_key,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20bilibili%20reply.js
bilibili_live = type=http-response,requires-body=1,max-size=0,pattern=^https://api.live.bilibili.com/xlive/app-room/v1/index/getInfoByRoom\?access_key,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20bilibili%20live.js
nf_rating = type=http-request,pattern=^https?://ios\.prod\.ftl\.netflix\.com/iosui/user/.+path=%5B%22videos%22%2C%\d+%22%2C%22summary%22%5D,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/nf_rating.js
nf_rating2 = type=http-response,requires-body=1,pattern=^https?://ios\.prod\.ftl\.netflix\.com/iosui/user/.+path=%5B%22videos%22%2C%\d+%22%2C%22summary%22%5D,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/nf_rating.js
nf_rating_season = type=http-response,pattern=^https?://ios\.prod\.ftl\.netflix\.com/iosui/warmer/.+type=show-ath,requires-body=1,max-size=0,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/nf_rating_season.js
zhihu_people = type=http-response,requires-body=1,max-size=0,pattern=^https://api.zhihu.com/people/,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20zhihu%20people.js
zhihu_feed = type=http-response,requires-body=1,max-size=0,pattern=^https://api.zhihu.com/moments/recommend,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20zhihu%20feed.js
zhihu_recommend = type=http-response,requires-body=1,max-size=0,pattern=^https://api.zhihu.com/topstory/recommend,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20zhihu%20recommend.js
zhihu_answer = type=http-response,requires-body=1,max-size=0,pattern=^https://api.zhihu.com/v4/questions,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20zhihu%20answer.js
zhihu_link = type=http-request,pattern=^https?://link.zhihu.com/\?target=,script-path=https://cdn.jsdelivr.net/gh/fgprodigal/Surge-Rule@master/Script/surge%20zhihu%20link.js
