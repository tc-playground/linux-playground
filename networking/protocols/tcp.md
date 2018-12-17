# TCP (Transmission Control Protocol)

## Curl Google and analyse traffic with 'tcpdump'

### Terminal 1: tcpdump
```
sudo tcpdump -vlttttXX host google.com
```

### Terminal 2: curl
```
curl -vvv google.com
```

### Terminal 1 : Ouput
```
2018-12-16 19:32:54.385620 IP (tos 0x0, ttl 64, id 31763, offset 0, flags [DF], proto TCP (6), length 60)
    occam.51924 > lhr35s07-in-f14.1e100.net.http: Flags [SEW], cksum 0x460e (correct), seq 3877225132, win 29200, options [mss 1460,sackOK,TS val 240101103 ecr 0,nop,wscale 7], length 0
	0x0000:  200c c85b d84f 38de ad49 519c 0800 4500  ...[.O8..IQ...E.
	0x0010:  003c 7c13 4000 4006 59b1 c0a8 0006 d83a  .<|.@.@.Y......:
	0x0020:  cc0e cad4 0050 e719 c2ac 0000 0000 a0c2  .....P..........
	0x0030:  7210 460e 0000 0204 05b4 0402 080a 0e4f  r.F............O
	0x0040:  a6ef 0000 0000 0103 0307                 ..........
2018-12-16 19:32:54.404214 IP (tos 0x0, ttl 121, id 22573, offset 0, flags [none], proto TCP (6), length 60)
    lhr35s07-in-f14.1e100.net.http > occam.51924: Flags [S.], cksum 0x5ef3 (correct), seq 4253496532, ack 3877225133, win 60192, options [mss 1380,sackOK,TS val 1138555087 ecr 240101103,nop,wscale 8], length 0
	0x0000:  38de ad49 519c 200c c85b d84f 0800 4500  8..IQ....[.O..E.
	0x0010:  003c 582d 0000 7906 8497 d83a cc0e c0a8  .<X-..y....:....
	0x0020:  0006 0050 cad4 fd87 34d4 e719 c2ad a012  ...P....4.......
	0x0030:  eb20 5ef3 0000 0204 0564 0402 080a 43dc  ..^......d....C.
	0x0040:  f8cf 0e4f a6ef 0103 0308                 ...O......
2018-12-16 19:32:54.404238 IP (tos 0x0, ttl 64, id 31764, offset 0, flags [DF], proto TCP (6), length 52)
    occam.51924 > lhr35s07-in-f14.1e100.net.http: Flags [.], cksum 0x779a (correct), ack 1, win 229, options [nop,nop,TS val 240101121 ecr 1138555087], length 0
	0x0000:  200c c85b d84f 38de ad49 519c 0800 4500  ...[.O8..IQ...E.
	0x0010:  0034 7c14 4000 4006 59b8 c0a8 0006 d83a  .4|.@.@.Y......:
	0x0020:  cc0e cad4 0050 e719 c2ad fd87 34d5 8010  .....P......4...
	0x0030:  00e5 779a 0000 0101 080a 0e4f a701 43dc  ..w........O..C.
	0x0040:  f8cf                                     ..
2018-12-16 19:32:54.404265 IP (tos 0x0, ttl 64, id 31765, offset 0, flags [DF], proto TCP (6), length 126)
    occam.51924 > lhr35s07-in-f14.1e100.net.http: Flags [P.], cksum 0x8433 (correct), seq 1:75, ack 1, win 229, options [nop,nop,TS val 240101121 ecr 1138555087], length 74: HTTP, length: 74
	GET / HTTP/1.1
	Host: google.com
	User-Agent: curl/7.61.0
	Accept: */*
	
	0x0000:  200c c85b d84f 38de ad49 519c 0800 4500  ...[.O8..IQ...E.
	0x0010:  007e 7c15 4000 4006 596d c0a8 0006 d83a  .~|.@.@.Ym.....:
	0x0020:  cc0e cad4 0050 e719 c2ad fd87 34d5 8018  .....P......4...
	0x0030:  00e5 8433 0000 0101 080a 0e4f a701 43dc  ...3.......O..C.
	0x0040:  f8cf 4745 5420 2f20 4854 5450 2f31 2e31  ..GET./.HTTP/1.1
	0x0050:  0d0a 486f 7374 3a20 676f 6f67 6c65 2e63  ..Host:.google.c
	0x0060:  6f6d 0d0a 5573 6572 2d41 6765 6e74 3a20  om..User-Agent:.
	0x0070:  6375 726c 2f37 2e36 312e 300d 0a41 6363  curl/7.61.0..Acc
	0x0080:  6570 743a 202a 2f2a 0d0a 0d0a            ept:.*/*....
2018-12-16 19:32:54.420609 IP (tos 0x0, ttl 121, id 22580, offset 0, flags [none], proto TCP (6), length 52)
    lhr35s07-in-f14.1e100.net.http > occam.51924: Flags [.], cksum 0x7739 (correct), ack 75, win 236, options [nop,nop,TS val 1138555103 ecr 240101121], length 0
	0x0000:  38de ad49 519c 200c c85b d84f 0800 4500  8..IQ....[.O..E.
	0x0010:  0034 5834 0000 7906 8498 d83a cc0e c0a8  .4X4..y....:....
	0x0020:  0006 0050 cad4 fd87 34d5 e719 c2f7 8010  ...P....4.......
	0x0030:  00ec 7739 0000 0101 080a 43dc f8df 0e4f  ..w9......C....O
	0x0040:  a701                                     ..
2018-12-16 19:32:54.434882 IP (tos 0x0, ttl 121, id 22587, offset 0, flags [none], proto TCP (6), length 592)
    lhr35s07-in-f14.1e100.net.http > occam.51924: Flags [P.], cksum 0x4c1c (correct), seq 1:541, ack 75, win 236, options [nop,nop,TS val 1138555117 ecr 240101121], length 540: HTTP, length: 540
	HTTP/1.1 301 Moved Permanently
	Location: http://www.google.com/
	Content-Type: text/html; charset=UTF-8
	Date: Sun, 16 Dec 2018 19:32:54 GMT
	Expires: Tue, 15 Jan 2019 19:32:54 GMT
	Cache-Control: public, max-age=2592000
	Server: gws
	Content-Length: 219
	X-XSS-Protection: 1; mode=block
	X-Frame-Options: SAMEORIGIN
	
	<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
	<TITLE>301 Moved</TITLE></HEAD><BODY>
	<H1>301 Moved</H1>
	The document has moved
	<A HREF="http://www.google.com/">here</A>.
	</BODY></HTML>
	0x0000:  38de ad49 519c 200c c85b d84f 0800 4500  8..IQ....[.O..E.
	0x0010:  0250 583b 0000 7906 8275 d83a cc0e c0a8  .PX;..y..u.:....
	0x0020:  0006 0050 cad4 fd87 34d5 e719 c2f7 8018  ...P....4.......
	0x0030:  00ec 4c1c 0000 0101 080a 43dc f8ed 0e4f  ..L.......C....O
	0x0040:  a701 4854 5450 2f31 2e31 2033 3031 204d  ..HTTP/1.1.301.M
	0x0050:  6f76 6564 2050 6572 6d61 6e65 6e74 6c79  oved.Permanently
	0x0060:  0d0a 4c6f 6361 7469 6f6e 3a20 6874 7470  ..Location:.http
	0x0070:  3a2f 2f77 7777 2e67 6f6f 676c 652e 636f  ://www.google.co
	0x0080:  6d2f 0d0a 436f 6e74 656e 742d 5479 7065  m/..Content-Type
	0x0090:  3a20 7465 7874 2f68 746d 6c3b 2063 6861  :.text/html;.cha
	0x00a0:  7273 6574 3d55 5446 2d38 0d0a 4461 7465  rset=UTF-8..Date
	0x00b0:  3a20 5375 6e2c 2031 3620 4465 6320 3230  :.Sun,.16.Dec.20
	0x00c0:  3138 2031 393a 3332 3a35 3420 474d 540d  18.19:32:54.GMT.
	0x00d0:  0a45 7870 6972 6573 3a20 5475 652c 2031  .Expires:.Tue,.1
	0x00e0:  3520 4a61 6e20 3230 3139 2031 393a 3332  5.Jan.2019.19:32
	0x00f0:  3a35 3420 474d 540d 0a43 6163 6865 2d43  :54.GMT..Cache-C
	0x0100:  6f6e 7472 6f6c 3a20 7075 626c 6963 2c20  ontrol:.public,.
	0x0110:  6d61 782d 6167 653d 3235 3932 3030 300d  max-age=2592000.
	0x0120:  0a53 6572 7665 723a 2067 7773 0d0a 436f  .Server:.gws..Co
	0x0130:  6e74 656e 742d 4c65 6e67 7468 3a20 3231  ntent-Length:.21
	0x0140:  390d 0a58 2d58 5353 2d50 726f 7465 6374  9..X-XSS-Protect
	0x0150:  696f 6e3a 2031 3b20 6d6f 6465 3d62 6c6f  ion:.1;.mode=blo
	0x0160:  636b 0d0a 582d 4672 616d 652d 4f70 7469  ck..X-Frame-Opti
	0x0170:  6f6e 733a 2053 414d 454f 5249 4749 4e0d  ons:.SAMEORIGIN.
	0x0180:  0a0d 0a3c 4854 4d4c 3e3c 4845 4144 3e3c  ...<HTML><HEAD><
	0x0190:  6d65 7461 2068 7474 702d 6571 7569 763d  meta.http-equiv=
	0x01a0:  2263 6f6e 7465 6e74 2d74 7970 6522 2063  "content-type".c
	0x01b0:  6f6e 7465 6e74 3d22 7465 7874 2f68 746d  ontent="text/htm
	0x01c0:  6c3b 6368 6172 7365 743d 7574 662d 3822  l;charset=utf-8"
	0x01d0:  3e0a 3c54 4954 4c45 3e33 3031 204d 6f76  >.<TITLE>301.Mov
	0x01e0:  6564 3c2f 5449 544c 453e 3c2f 4845 4144  ed</TITLE></HEAD
	0x01f0:  3e3c 424f 4459 3e0a 3c48 313e 3330 3120  ><BODY>.<H1>301.
	0x0200:  4d6f 7665 643c 2f48 313e 0a54 6865 2064  Moved</H1>.The.d
	0x0210:  6f63 756d 656e 7420 6861 7320 6d6f 7665  ocument.has.move
	0x0220:  640a 3c41 2048 5245 463d 2268 7474 703a  d.<A.HREF="http:
	0x0230:  2f2f 7777 772e 676f 6f67 6c65 2e63 6f6d  //www.google.com
	0x0240:  2f22 3e68 6572 653c 2f41 3e2e 0d0a 3c2f  /">here</A>...</
	0x0250:  424f 4459 3e3c 2f48 544d 4c3e 0d0a       BODY></HTML>..
2018-12-16 19:32:54.434913 IP (tos 0x0, ttl 64, id 31766, offset 0, flags [DF], proto TCP (6), length 52)
    occam.51924 > lhr35s07-in-f14.1e100.net.http: Flags [.], cksum 0x74ef (correct), ack 541, win 237, options [nop,nop,TS val 240101152 ecr 1138555117], length 0
	0x0000:  200c c85b d84f 38de ad49 519c 0800 4500  ...[.O8..IQ...E.
	0x0010:  0034 7c16 4000 4006 59b6 c0a8 0006 d83a  .4|.@.@.Y......:
	0x0020:  cc0e cad4 0050 e719 c2f7 fd87 36f1 8010  .....P......6...
	0x0030:  00ed 74ef 0000 0101 080a 0e4f a720 43dc  ..t........O..C.
	0x0040:  f8ed                                     ..
2018-12-16 19:32:54.435015 IP (tos 0x0, ttl 64, id 31767, offset 0, flags [DF], proto TCP (6), length 52)
    occam.51924 > lhr35s07-in-f14.1e100.net.http: Flags [F.], cksum 0x74ee (correct), seq 75, ack 541, win 237, options [nop,nop,TS val 240101152 ecr 1138555117], length 0
	0x0000:  200c c85b d84f 38de ad49 519c 0800 4500  ...[.O8..IQ...E.
	0x0010:  0034 7c17 4000 4006 59b5 c0a8 0006 d83a  .4|.@.@.Y......:
	0x0020:  cc0e cad4 0050 e719 c2f7 fd87 36f1 8011  .....P......6...
	0x0030:  00ed 74ee 0000 0101 080a 0e4f a720 43dc  ..t........O..C.
	0x0040:  f8ed                                     ..
2018-12-16 19:32:54.459188 IP (tos 0x0, ttl 121, id 22610, offset 0, flags [none], proto TCP (6), length 52)
    lhr35s07-in-f14.1e100.net.http > occam.51924: Flags [F.], cksum 0x74d5 (correct), seq 541, ack 76, win 236, options [nop,nop,TS val 1138555142 ecr 240101152], length 0
	0x0000:  38de ad49 519c 200c c85b d84f 0800 4500  8..IQ....[.O..E.
	0x0010:  0034 5852 0000 7906 847a d83a cc0e c0a8  .4XR..y..z.:....
	0x0020:  0006 0050 cad4 fd87 36f1 e719 c2f8 8011  ...P....6.......
	0x0030:  00ec 74d5 0000 0101 080a 43dc f906 0e4f  ..t.......C....O
	0x0040:  a720                                     ..
2018-12-16 19:32:54.459234 IP (tos 0x0, ttl 64, id 31768, offset 0, flags [DF], proto TCP (6), length 52)
    occam.51924 > lhr35s07-in-f14.1e100.net.http: Flags [.], cksum 0x74bc (correct), ack 542, win 237, options [nop,nop,TS val 240101176 ecr 1138555142], length 0
	0x0000:  200c c85b d84f 38de ad49 519c 0800 4500  ...[.O8..IQ...E.
	0x0010:  0034 7c18 4000 4006 59b4 c0a8 0006 d83a  .4|.@.@.Y......:
	0x0020:  cc0e cad4 0050 e719 c2f8 fd87 36f2 8010  .....P......6...
	0x0030:  00ed 74bc 0000 0101 080a 0e4f a738 43dc  ..t........O.8C.
	0x0040:  f906                                     ..
```

### Terminal 2 - Output
```* Rebuilt URL to: google.com/
*   Trying 216.58.204.14...
* TCP_NODELAY set
* Connected to google.com (216.58.204.14) port 80 (#0)
> GET / HTTP/1.1
> Host: google.com
> User-Agent: curl/7.61.0
> Accept: */*
> 
< HTTP/1.1 301 Moved Permanently
< Location: http://www.google.com/
< Content-Type: text/html; charset=UTF-8
< Date: Sun, 16 Dec 2018 19:35:06 GMT
< Expires: Tue, 15 Jan 2019 19:35:06 GMT
< Cache-Control: public, max-age=2592000
< Server: gws
< Content-Length: 219
< X-XSS-Protection: 1; mode=block
< X-Frame-Options: SAMEORIGIN
< 
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
* Connection #0 to host google.com left intact
```

### Understanding the Hex dump.
```
	0x0040:  a701 4854 5450 2f31 2e31 2033 3031 204d  ..HTTP/1.1.301.M
	0x0050:  6f76 6564 2050 6572 6d61 6e65 6e74 6c79  oved.Permanently
```
* A hex-digit represents '4-bits' or '1-nibble'. Decimal, 0-15.
* Two hex-digits represent '8-bits' or '1-byte' (1-octet). Decimal, 0-255.
* One byte can represent an ASCII character.
* Each row shows '16 bytes' (in 8x2 groups) and 16 'ASCII chars'.
* Hex '48' is the ASCII code for 'H'.
* The '.' can represent a '.' or special unrepresented protocol data,