--[[
	id: 01KRaKnCSLBNpW87c273N
	name: dada
	description: dadadadad
	time1: 2021-06-24 11:39:00.806287+00
	time2: 2021-06-24 11:39:00.806287+00
	uploader: 8BolDDFb5-dTdnwB0WVduADd2NCaQgake9b7OD0t
	uploadersession: KXuDSpesxjOh06YaTseMXxQTfOynqs
	flag: f
--]]

	-- @region: 'Modules'
		_G.bloom = {}
		_G.bloom.notify = (function()local a={callback_registered=false,maximum_count=7,data={}}function a:register_callback()if self.callback_registered then return end;client.set_event_callback("paint_ui",function()local b={client.screen_size()}local c={15,15,15}local d=5;local e=5;local f=self.data;for g=#f,1,-1 do self.data[g].time=self.data[g].time-globals.frametime()local h,i,j=255,0,135;local k=f[g]if k.time<0 then table.remove(self.data,g)else local l=k.def_time-k.time;local l=l>1 and 1 or l;if k.time<0.5 or l<0.5 then i=(l<1 and l or k.time)/0.5;h=i*255;j=i*135;if i<0.2 then d=d-15*(1.0-i/0.2)end end;local m=k.time/k.def_time;if m>1 then m=1 elseif m<0 then m=0 end;local n=1-k.time/k.def_time;if n>1 then n=1 elseif n<0 then n=0 end;local o={renderer.measure_text(nil,k.draw)}local p={b[1]/2-o[1]/2+3,b[2]-b[2]/100*17.4+d}local q,r,s,t=table.unpack(k.color)renderer.rectangle(p[1]-4,p[2],o[1]+10,20,c[1],c[2],c[3],j)renderer.gradient(p[1]-4+n*(o[1]+10)/2,p[2]+18,m*(o[1]+10)/2,2,q,r,s,h,q,r,s,h,true)renderer.gradient(p[1]-5+(o[1]+10)/2,p[2]+18,m*((o[1]+10)/2+1),2,q,r,s,h,q,r,s,h,true)renderer.text(p[1]+2,p[2]+3,255,255,255,h,"",nil,k.draw)d=d+25 end end;self.callback_registered=true end)end;function a:paint(u,v,c)local w=tonumber(u)+1;for g=self.maximum_count,2,-1 do self.data[g]=self.data[g-1]end;self.data[1]={time=w,def_time=w,draw=v,color=c}self:register_callback()end;return{add=function(x,y)a:paint(y,x,{255,0,0,255})end}end)()
		local ffi = require 'ffi'
		local base64 = (function()local a=require"bit"local b={}local c,d,e=a.lshift,a.rshift,a.band;local f,g,h,i,j,k,tostring,error,pairs=string.char,string.byte,string.gsub,string.sub,string.format,table.concat,tostring,error,pairs;local l=function(m,n,o)return e(d(m,n),c(1,o)-1)end;local function p(q)local r,s={},{}for t=1,65 do local u=g(i(q,t,t))or 32;if s[u]~=nil then error("invalid alphabet: duplicate character "..tostring(u),3)end;r[t-1]=u;s[u]=t-1 end;return r,s end;local v,w={},{}v["base64"],w["base64"]=p("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=")v["base64url"],w["base64url"]=p("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_")local x={__index=function(y,z)if type(z)=="string"and z:len()==64 or z:len()==65 then v[z],w[z]=p(z)return y[z]end end}setmetatable(v,x)setmetatable(w,x)function b.encode(A,r)r=v[r or"base64"]or error("invalid alphabet specified",2)A=tostring(A)local B,C,D={},1,#A;local E=D%3;local F={}for t=1,D-E,3 do local G,H,I=g(A,t,t+2)local m=G*0x10000+H*0x100+I;local J=F[m]if not J then J=f(r[l(m,18,6)],r[l(m,12,6)],r[l(m,6,6)],r[l(m,0,6)])F[m]=J end;B[C]=J;C=C+1 end;if E==2 then local G,H=g(A,D-1,D)local m=G*0x10000+H*0x100;B[C]=f(r[l(m,18,6)],r[l(m,12,6)],r[l(m,6,6)],r[64])elseif E==1 then local m=g(A,D)*0x10000;B[C]=f(r[l(m,18,6)],r[l(m,12,6)],r[64],r[64])end;return k(B)end;function b.decode(K,s)s=w[s or"base64"]or error("invalid alphabet specified",2)local L="[^%w%+%/%=]"if s then local M,N;for O,P in pairs(s)do if P==62 then M=O elseif P==63 then N=O end end;L=j("[^%%w%%%s%%%s%%=]",f(M),f(N))end;K=h(tostring(K),L,'')local F={}local B,C={},1;local D=#K;local Q=i(K,-2)=="=="and 2 or i(K,-1)=="="and 1 or 0;for t=1,Q>0 and D-4 or D,4 do local G,H,I,R=g(K,t,t+3)local S=G*0x1000000+H*0x10000+I*0x100+R;local J=F[S]if not J then local m=s[G]*0x40000+s[H]*0x1000+s[I]*0x40+s[R]J=f(l(m,16,8),l(m,8,8),l(m,0,8))F[S]=J end;B[C]=J;C=C+1 end;if Q==1 then local G,H,I=g(K,D-3,D-1)local m=s[G]*0x40000+s[H]*0x1000+s[I]*0x40;B[C]=f(l(m,16,8),l(m,8,8))elseif Q==2 then local G,H=g(K,D-3,D-2)local m=s[G]*0x40000+s[H]*0x1000;B[C]=f(l(m,16,8))end;return k(B)end;return b end)()
		local http = (function()local a=require"ffi"local b=require"gamesense/base64"local assert,pcall,xpcall,error,setmetatable,tostring,tonumber,type,pairs=assert,pcall,xpcall,error,setmetatable,tostring,tonumber,type,pairs;local c,d,e,f=client.log,client.delay_call,ui.get,string.format;local g,h,i,j,k,l=a.typeof,a.sizeof,a.cast,a.cdef,a.string,a.gc;local m,n,o;do if not pcall(a.sizeof,"SteamAPICall_t")then j([[ typedef uint64_t SteamAPICall_t; struct SteamAPI_callback_base_vtbl { void(__thiscall *run1)(struct SteamAPI_callback_base *, void *, bool, uint64_t); void(__thiscall *run2)(struct SteamAPI_callback_base *, void *); int(__thiscall *get_size)(struct SteamAPI_callback_base *); }; struct SteamAPI_callback_base { struct SteamAPI_callback_base_vtbl *vtbl; uint8_t flags; int id; uint64_t api_call_handle; struct SteamAPI_callback_base_vtbl vtbl_storage[1]; }; ]])end;local p={[-1]="No failure",[0]="Steam gone",[1]="Network failure",[2]="Invalid handle",[3]="Mismatched callback"}local q,r;local s,t;local u;local v=g("struct SteamAPI_callback_base")local w=h(v)local x=g("struct SteamAPI_callback_base[1]")local y=g("struct SteamAPI_callback_base*")local z=g("uintptr_t")local A={}local B={}local C={}local function D(E)return tostring(tonumber(i(z,E)))end;local function F(self,G,H)if H then H=p[u(self.api_call_handle)]or"Unknown error"end;self.api_call_handle=0;local I=D(self)local J=A[I]if J~=nil then xpcall(J,client.error_log,G,H)end;if B[I]~=nil then A[I]=nil;B[I]=nil end end;local function K(self,G,H,L)if L==self.api_call_handle then F(self,G,H)end end;local function M(self,G)F(self,G,false)end;local function N(self)return w end;local function O(self)if self.api_call_handle~=0 then r(self,self.api_call_handle)self.api_call_handle=0;local I=D(self)A[I]=nil;B[I]=nil end end;pcall(a.metatype,v,{__gc=O,__index={cancel=O}})local P=i("void(__thiscall *)(struct SteamAPI_callback_base *, void *, bool, uint64_t)",K)local Q=i("void(__thiscall *)(struct SteamAPI_callback_base *, void *)",M)local R=i("int(__thiscall *)(struct SteamAPI_callback_base *)",N)function m(L,J,S)assert(L~=0)local T=x()local U=i(y,T)U.vtbl_storage[0].run1=P;U.vtbl_storage[0].run2=Q;U.vtbl_storage[0].get_size=R;U.vtbl=U.vtbl_storage;U.api_call_handle=L;U.id=S;local I=D(U)A[I]=J;B[I]=T;q(U,L)return U end;function n(S,J)assert(C[S]==nil)local T=x()local U=i(y,T)U.vtbl_storage[0].run1=P;U.vtbl_storage[0].run2=Q;U.vtbl_storage[0].get_size=R;U.vtbl=U.vtbl_storage;U.api_call_handle=0;U.id=S;local I=D(U)A[I]=J;C[S]=T;s(U,S)end;local function V(W,X,Y,Z,_)local a0=client.find_signature(W,X)or error("signature not found",2)local a1=i("uintptr_t",a0)if Z~=nil and Z~=0 then a1=a1+Z end;if _~=nil then for a2=1,_ do a1=i("uintptr_t*",a1)[0]if a1==nil then return error("signature not found")end end end;return i(Y,a1)end;local function a3(U,a4,type)return i(type,i("void***",U)[0][a4])end;q=V("steam_api.dll",b.decode("VYvsgz3MzMzMzH4NaMzMzMz/FczMzMxdw/91EA=="),"void(__cdecl*)(struct SteamAPI_callback_base *, uint64_t)")r=V("steam_api.dll",b.decode("VYvs/3UQ/3UM"),"void(__cdecl*)(struct SteamAPI_callback_base *, uint64_t)")s=V("steam_api.dll",b.decode("VYvsgz3MzMzMzH4NaMzMzMz/FczMzMxdw8cF"),"void(__cdecl*)(struct SteamAPI_callback_base *, int)")t=V("steam_api.dll",b.decode("VYvsg+wIgD0="),"void(__cdecl*)(struct SteamAPI_callback_base *)")o=V("client_panorama.dll",b.decode("uczMzMzozMzMzIM9zMzMzMwPhA=="),"uintptr_t",1,1)local a5=i("uintptr_t*",o)[3]local a6=a3(a5,12,"int(__thiscall*)(void*, SteamAPICall_t)")function u(a7)return a6(a5,a7)end;client.set_event_callback("shutdown",function()for I,a8 in pairs(B)do local U=i(y,a8)O(U)end;for I,a8 in pairs(C)do local U=i(y,a8)t(U)end end)end;if not pcall(h,"http_HTTPRequestHandle")then j([[ typedef uint32_t http_HTTPRequestHandle; typedef uint32_t http_HTTPCookieContainerHandle; enum http_EHTTPMethod { k_EHTTPMethodInvalid, k_EHTTPMethodGET, k_EHTTPMethodHEAD, k_EHTTPMethodPOST, k_EHTTPMethodPUT, k_EHTTPMethodDELETE, k_EHTTPMethodOPTIONS, k_EHTTPMethodPATCH, }; struct http_ISteamHTTPVtbl { http_HTTPRequestHandle(__thiscall *CreateHTTPRequest)(uintptr_t, enum http_EHTTPMethod, const char *); bool(__thiscall *SetHTTPRequestContextValue)(uintptr_t, http_HTTPRequestHandle, uint64_t); bool(__thiscall *SetHTTPRequestNetworkActivityTimeout)(uintptr_t, http_HTTPRequestHandle, uint32_t); bool(__thiscall *SetHTTPRequestHeaderValue)(uintptr_t, http_HTTPRequestHandle, const char *, const char *); bool(__thiscall *SetHTTPRequestGetOrPostParameter)(uintptr_t, http_HTTPRequestHandle, const char *, const char *); bool(__thiscall *SendHTTPRequest)(uintptr_t, http_HTTPRequestHandle, SteamAPICall_t *); bool(__thiscall *SendHTTPRequestAndStreamResponse)(uintptr_t, http_HTTPRequestHandle, SteamAPICall_t *); bool(__thiscall *DeferHTTPRequest)(uintptr_t, http_HTTPRequestHandle); bool(__thiscall *PrioritizeHTTPRequest)(uintptr_t, http_HTTPRequestHandle); bool(__thiscall *GetHTTPResponseHeaderSize)(uintptr_t, http_HTTPRequestHandle, const char *, uint32_t *); bool(__thiscall *GetHTTPResponseHeaderValue)(uintptr_t, http_HTTPRequestHandle, const char *, uint8_t *, uint32_t); bool(__thiscall *GetHTTPResponseBodySize)(uintptr_t, http_HTTPRequestHandle, uint32_t *); bool(__thiscall *GetHTTPResponseBodyData)(uintptr_t, http_HTTPRequestHandle, uint8_t *, uint32_t); bool(__thiscall *GetHTTPStreamingResponseBodyData)(uintptr_t, http_HTTPRequestHandle, uint32_t, uint8_t *, uint32_t); bool(__thiscall *ReleaseHTTPRequest)(uintptr_t, http_HTTPRequestHandle); bool(__thiscall *GetHTTPDownloadProgressPct)(uintptr_t, http_HTTPRequestHandle, float *); bool(__thiscall *SetHTTPRequestRawPostBody)(uintptr_t, http_HTTPRequestHandle, const char *, uint8_t *, uint32_t); http_HTTPCookieContainerHandle(__thiscall *CreateCookieContainer)(uintptr_t, bool); bool(__thiscall *ReleaseCookieContainer)(uintptr_t, http_HTTPCookieContainerHandle); bool(__thiscall *SetCookie)(uintptr_t, http_HTTPCookieContainerHandle, const char *, const char *, const char *); bool(__thiscall *SetHTTPRequestCookieContainer)(uintptr_t, http_HTTPRequestHandle, http_HTTPCookieContainerHandle); bool(__thiscall *SetHTTPRequestUserAgentInfo)(uintptr_t, http_HTTPRequestHandle, const char *); bool(__thiscall *SetHTTPRequestRequiresVerifiedCertificate)(uintptr_t, http_HTTPRequestHandle, bool); bool(__thiscall *SetHTTPRequestAbsoluteTimeoutMS)(uintptr_t, http_HTTPRequestHandle, uint32_t); bool(__thiscall *GetHTTPRequestWasTimedOut)(uintptr_t, http_HTTPRequestHandle, bool *pbWasTimedOut); }; ]])end;local a9={get=a.C.k_EHTTPMethodGET,head=a.C.k_EHTTPMethodHEAD,post=a.C.k_EHTTPMethodPOST,put=a.C.k_EHTTPMethodPUT,delete=a.C.k_EHTTPMethodDELETE,options=a.C.k_EHTTPMethodOPTIONS,patch=a.C.k_EHTTPMethodPATCH}local aa={[100]="Continue",[101]="Switching Protocols",[102]="Processing",[200]="OK",[201]="Created",[202]="Accepted",[203]="Non-Authoritative Information",[204]="No Content",[205]="Reset Content",[206]="Partial Content",[207]="Multi-Status",[208]="Already Reported",[250]="Low on Storage Space",[226]="IM Used",[300]="Multiple Choices",[301]="Moved Permanently",[302]="Found",[303]="See Other",[304]="Not Modified",[305]="Use Proxy",[306]="Switch Proxy",[307]="Temporary Redirect",[308]="Permanent Redirect",[400]="Bad Request",[401]="Unauthorized",[402]="Payment Required",[403]="Forbidden",[404]="Not Found",[405]="Method Not Allowed",[406]="Not Acceptable",[407]="Proxy Authentication Required",[408]="Request Timeout",[409]="Conflict",[410]="Gone",[411]="Length Required",[412]="Precondition Failed",[413]="Request Entity Too Large",[414]="Request-URI Too Long",[415]="Unsupported Media Type",[416]="Requested Range Not Satisfiable",[417]="Expectation Failed",[418]="I'm a teapot",[420]="Enhance Your Calm",[422]="Unprocessable Entity",[423]="Locked",[424]="Failed Dependency",[424]="Method Failure",[425]="Unordered Collection",[426]="Upgrade Required",[428]="Precondition Required",[429]="Too Many Requests",[431]="Request Header Fields Too Large",[444]="No Response",[449]="Retry With",[450]="Blocked by Windows Parental Controls",[451]="Parameter Not Understood",[451]="Unavailable For Legal Reasons",[451]="Redirect",[452]="Conference Not Found",[453]="Not Enough Bandwidth",[454]="Session Not Found",[455]="Method Not Valid in This State",[456]="Header Field Not Valid for Resource",[457]="Invalid Range",[458]="Parameter Is Read-Only",[459]="Aggregate Operation Not Allowed",[460]="Only Aggregate Operation Allowed",[461]="Unsupported Transport",[462]="Destination Unreachable",[494]="Request Header Too Large",[495]="Cert Error",[496]="No Cert",[497]="HTTP to HTTPS",[499]="Client Closed Request",[500]="Internal Server Error",[501]="Not Implemented",[502]="Bad Gateway",[503]="Service Unavailable",[504]="Gateway Timeout",[505]="HTTP Version Not Supported",[506]="Variant Also Negotiates",[507]="Insufficient Storage",[508]="Loop Detected",[509]="Bandwidth Limit Exceeded",[510]="Not Extended",[511]="Network Authentication Required",[551]="Option not supported",[598]="Network read timeout error",[599]="Network connect timeout error"}local ab=2101;local ac=2102;local ad=2103;local function ae()local af=i("uintptr_t*",o)[12]if af==0 or af==nil then return error("find_isteamhttp failed")end;local ag=i("struct http_ISteamHTTPVtbl**",af)[0]if ag==0 or ag==nil then return error("find_isteamhttp failed")end;return af,ag end;local function ah(ai,aj)return function(...)return ai(aj,...)end end;local ak=g([[ struct { http_HTTPRequestHandle m_hRequest; uint64_t m_ulContextValue; bool m_bRequestSuccessful; int m_eStatusCode; uint32_t m_unBodySize; } * ]])local al=g([[ struct { http_HTTPRequestHandle m_hRequest; uint64_t m_ulContextValue; } * ]])local am=g([[ struct { http_HTTPRequestHandle m_hRequest; uint64_t m_ulContextValue; uint32_t m_cOffset; uint32_t m_cBytesReceived; } * ]])local an=g([[ struct { http_HTTPCookieContainerHandle m_hCookieContainer; } ]])local ao=g("SteamAPICall_t[1]")local ap=g("const char[?]")local aq=g("uint8_t[?]")local ar=g("unsigned int[?]")local as=g("bool[1]")local at=g("float[1]")local au,av=ae()local aw=ah(av.CreateHTTPRequest,au)local ax=ah(av.SetHTTPRequestContextValue,au)local ay=ah(av.SetHTTPRequestNetworkActivityTimeout,au)local az=ah(av.SetHTTPRequestHeaderValue,au)local aA=ah(av.SetHTTPRequestGetOrPostParameter,au)local aB=ah(av.SendHTTPRequest,au)local aC=ah(av.SendHTTPRequestAndStreamResponse,au)local aD=ah(av.DeferHTTPRequest,au)local aE=ah(av.PrioritizeHTTPRequest,au)local aF=ah(av.GetHTTPResponseHeaderSize,au)local aG=ah(av.GetHTTPResponseHeaderValue,au)local aH=ah(av.GetHTTPResponseBodySize,au)local aI=ah(av.GetHTTPResponseBodyData,au)local aJ=ah(av.GetHTTPStreamingResponseBodyData,au)local aK=ah(av.ReleaseHTTPRequest,au)local aL=ah(av.GetHTTPDownloadProgressPct,au)local aM=ah(av.SetHTTPRequestRawPostBody,au)local aN=ah(av.CreateCookieContainer,au)local aO=ah(av.ReleaseCookieContainer,au)local aP=ah(av.SetCookie,au)local aQ=ah(av.SetHTTPRequestCookieContainer,au)local aR=ah(av.SetHTTPRequestUserAgentInfo,au)local aS=ah(av.SetHTTPRequestRequiresVerifiedCertificate,au)local aT=ah(av.SetHTTPRequestAbsoluteTimeoutMS,au)local aU=ah(av.GetHTTPRequestWasTimedOut,au)local aV,aW={},false;local aX,aY=false,{}local aZ,a_=false,{}local b0=setmetatable({},{__mode="k"})local b1,b2=setmetatable({},{__mode="k"}),setmetatable({},{__mode="v"})local b3={}local b4={__index=function(b5,b6)local b7=b1[b5]if b7==nil then return end;b6=tostring(b6)if b7.m_hRequest~=0 then local b8=ar(1)if aF(b7.m_hRequest,b6,b8)then if b8~=nil then b8=b8[0]if b8<0 then return end;local b9=aq(b8)if aG(b7.m_hRequest,b6,b9,b8)then b5[b6]=k(b9,b8-1)return b5[b6]end end end end end,__metatable=false}local ba={__index={set_cookie=function(bb,bc,bd,b6,a8)local a7=b0[bb]if a7==nil or a7.m_hCookieContainer==0 then return end;aP(a7.m_hCookieContainer,bc,bd,tostring(b6).."="..tostring(a8))end},__metatable=false}local function be(a7)if a7.m_hCookieContainer~=0 then aO(a7.m_hCookieContainer)a7.m_hCookieContainer=0 end end;local function bf(b7)if b7.m_hRequest~=0 then aK(b7.m_hRequest)b7.m_hRequest=0 end end;local function bg(bh,...)aK(bh)return error(...)end;local function bi(b7,bj,bk,bl,...)local bm=b2[b7.m_hRequest]if bm==nil then bm=setmetatable({},b4)b2[b7.m_hRequest]=bm end;b1[bm]=b7;bl.headers=bm;aW=true;xpcall(bj,client.error_log,bk,bl,...)aW=false end;local function bn(G,H)if G==nil then return end;local b7=i(ak,G)if b7.m_hRequest~=0 then local bj=aV[b7.m_hRequest]if bj~=nil then aV[b7.m_hRequest]=nil;a_[b7.m_hRequest]=nil;aY[b7.m_hRequest]=nil;if bj then local bk=H==false and b7.m_bRequestSuccessful;local bo=b7.m_eStatusCode;local bp={status=bo}local bq=b7.m_unBodySize;if bk and bq>0 then local b9=aq(bq)if aI(b7.m_hRequest,b9,bq)then bp.body=k(b9,bq)end elseif not b7.m_bRequestSuccessful then local br=as()aU(b7.m_hRequest,br)bp.timed_out=br~=nil and br[0]==true end;if bo>0 then bp.status_message=aa[bo]or"Unknown status"elseif H then bp.status_message=f("IO Failure: %s",H)else bp.status_message=bp.timed_out and"Timed out"or"Unknown error"end;bi(b7,bj,bk,bp)end;bf(b7)end end end;local function bs(G,H)if G==nil then return end;local b7=i(al,G)if b7.m_hRequest~=0 then local bj=aY[b7.m_hRequest]if bj then bi(b7,bj,H==false,{})end end end;local function bt(G,H)if G==nil then return end;local b7=i(am,G)if b7.m_hRequest~=0 then local bj=a_[b7.m_hRequest]if a_[b7.m_hRequest]then local bl={}local bu=at()if aL(b7.m_hRequest,bu)then bl.download_progress=tonumber(bu[0])end;local b9=aq(b7.m_cBytesReceived)if aJ(b7.m_hRequest,b7.m_cOffset,b9,b7.m_cBytesReceived)then bl.body=k(b9,b7.m_cBytesReceived)end;bi(b7,bj,H==false,bl)end end end;local function bv(bw,bd,bx,by)if type(bx)=="function"and by==nil then by=bx;bx={}end;bx=bx or{}bx.network_timeout=bx.network_timeout or 10;bx.absolute_timeout=bx.absolute_timeout or 30;local bw=a9[tostring(bw):lower()]if bw==nil then return error("invalid HTTP method")end;if type(bd)~="string"then return error("URL has to be a string")end;local bz,bA,bB;if type(by)=="function"then bz=by elseif type(by)=="table"then bz=by.completed or by.complete;bA=by.headers_received or by.headers;bB=by.data_received or by.data;if bz~=nil and type(bz)~="function"then return error("callbacks.completed callback has to be a function")elseif bA~=nil and type(bA)~="function"then return error("callbacks.headers_received callback has to be a function")elseif bB~=nil and type(bB)~="function"then return error("callbacks.data_received callback has to be a function")end else return error("callbacks has to be a function or table")end;local bh=aw(bw,bd)if bh==0 then return error("Failed to create HTTP request")end;if type(bx.network_timeout)=="number"and bx.network_timeout>0 then if not ay(bh,bx.network_timeout)then return bg(bh,"failed to set network_timeout")end elseif bx.network_timeout~=nil then return bg(bh,"options.network_timeout has to be of type number and greater than 0")end;if type(bx.absolute_timeout)=="number"and bx.absolute_timeout>0 then if not aT(bh,bx.absolute_timeout*1000)then return bg(bh,"failed to set absolute_timeout")end elseif bx.absolute_timeout~=nil then return bg(bh,"options.absolute_timeout has to be of type number and greater than 0")end;local bC="application/text"local bD;if type(bx.headers)=="table"then for b6,a8 in pairs(bx.headers)do b6=tostring(b6)a8=tostring(a8)local bE=b6:lower()if bE=="content-type"then bC=a8 elseif bE=="authorization"then bD=true end;if not az(bh,b6,a8)then return bg(bh,"failed to set header "..b6)end end elseif bx.headers~=nil then return bg(bh,"options.headers has to be of type table")end;if type(bx.authorization)=="table"then if bD then return bg(bh,"Cannot set both options.authorization and the 'Authorization' header.")end;local bF,bG=bx.authorization[1],bx.authorization[2]if type(bF)~="string"or type(bG)~="string"then return bg(bh,"options.authorization has to be a table with username, password as strings")end;local a8=f("Basic %s",b.encode(f("%s:%s",bF,bG),"base64"))if not az(bh,"Authorization",a8)then return bg(bh,"failed to apply options.authorization")end elseif bx.authorization~=nil then return bg(bh,"options.authorization has to be of type table")end;if bx.body~=nil and bx.params~=nil then return bg(bh,"can only set options.body or options.params")end;if type(bx.body)=="string"then local bH=bx.body:len()if not aM(bh,bC,a.cast("unsigned char*",bx.body),bH)then return bg(bh,"failed to set post body")end elseif bx.body~=nil then return bg(bh,"options.body has to be of type string")end;if type(bx.params)=="table"then for b6,a8 in pairs(bx.params)do b6=tostring(b6)if not aA(bh,b6,tostring(a8))then return bg(bh,"failed to set parameter "..b6)end end elseif bx.params~=nil then return bg(bh,"options.params has to be of type table")end;if type(bx.require_ssl)=="boolean"then if not aS(bh,bx.require_ssl)then return bg(bh,"failed to set require_ssl")end elseif bx.require_ssl~=nil then return bg(bh,"options.require_ssl has to be of type boolean")end;if type(bx.user_agent_info)=="string"then if not aR(bh,bx.user_agent_info)then return bg(bh,"failed to set user_agent_info")end elseif bx.user_agent_info~=nil then return bg(bh,"options.user_agent_info has to be of type string")end;if type(bx.cookie_container)=="table"then local a7=b0[bx.cookie_container]if a7~=nil and a7.m_hCookieContainer~=0 then if not aQ(bh,a7.m_hCookieContainer)then return bg(bh,"failed to set user_agent_info")end else return bg(bh,"options.cookie_container has to a valid cookie container")end elseif bx.cookie_container~=nil then return bg(bh,"options.cookie_container has to a valid cookie container")end;local bI=aB;if type(bx.stream_response)=="boolean"then if bx.stream_response then bI=aC;if bz==nil and bA==nil and bB==nil then return bg(bh,"a 'completed', 'headers_received' or 'data_received' callback is required")end else if bz==nil then return bg(bh,"'completed' callback has to be set for non-streamed requests")elseif bA~=nil or bB~=nil then return bg(bh,"non-streamed requests only support 'completed' callbacks")end end elseif bx.stream_response~=nil then return bg(bh,"options.stream_response has to be of type boolean")end;if bA~=nil or bB~=nil then aY[bh]=bA or false;if bA~=nil then if not aX then n(ac,bs)aX=true end end;a_[bh]=bB or false;if bB~=nil then if not aZ then n(ad,bt)aZ=true end end end;local bJ=ao()if not bI(bh,bJ)then aK(bh)if bz~=nil then bz(false,{status=0,status_message="Failed to send request"})end;return end;if bx.priority=="defer"or bx.priority=="prioritize"then local ai=bx.priority=="prioritize"and aE or aD;if not ai(bh)then return bg(bh,"failed to set priority")end elseif bx.priority~=nil then return bg(bh,"options.priority has to be 'defer' of 'prioritize'")end;aV[bh]=bz or false;if bz~=nil then m(bJ[0],bn,ab)end end;local function bK(bL)if bL~=nil and type(bL)~="boolean"then return error("allow_modification has to be of type boolean")end;local bM=aN(bL==true)if bM~=nil then local a7=an(bM)l(a7,be)local I=setmetatable({},ba)b0[I]=a7;return I end end;local bN={request=bv,create_cookie_container=bK}for bw in pairs(a9)do bN[bw]=function(...)return bv(bw,...)end end;return bN end)()
		local notify = bloom.notify
		local json = (function()local a={_version="0.1.2"}local b;local c={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local d={["/"]="/"}for e,f in pairs(c)do d[f]=e end;local function g(h)return"\\"..(c[h]or string.format("u%04x",h:byte()))end;local function i(j)return"null"end;local function k(j,l)local m={}l=l or{}if l[j]then error("circular reference")end;l[j]=true;if rawget(j,1)~=nil or next(j)==nil then local n=0;for e in pairs(j)do if type(e)~="number"then error("invalid table: mixed or invalid key types")end;n=n+1 end;if n~=#j then error("invalid table: sparse array")end;for o,f in ipairs(j)do table.insert(m,b(f,l))end;l[j]=nil;return"["..table.concat(m,",").."]"else for e,f in pairs(j)do if type(e)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(m,b(e,l)..":"..b(f,l))end;l[j]=nil;return"{"..table.concat(m,",").."}"end end;local function p(j)return'"'..j:gsub('[%z\1-\31\\"]',g)..'"'end;local function q(j)if j~=j or j<=-math.huge or j>=math.huge then error("unexpected number value '"..tostring(j).."'")end;return string.format("%.14g",j)end;local r={["nil"]=i,["table"]=k,["string"]=p,["number"]=q,["boolean"]=tostring}b=function(j,l)local s=type(j)local t=r[s]if t then return t(j,l)end;error("unexpected type '"..s.."'")end;function a.stringify(j)return b(j)end;local u;local function v(...)local m={}for o=1,select("#",...)do m[select(o,...)]=true end;return m end;local w=v(" ","\t","\r","\n")local x=v(" ","\t","\r","\n","]","}",",")local y=v("\\","/",'"',"b","f","n","r","t","u")local z=v("true","false","null")local A={["true"]=true,["false"]=false,["null"]=nil}local function B(C,D,E,F)for o=D,#C do if E[C:sub(o,o)]~=F then return o end end;return#C+1 end;local function G(C,D,H)local I=1;local J=1;for o=1,D-1 do J=J+1;if C:sub(o,o)=="\n"then I=I+1;J=1 end end;error(string.format("%s at line %d col %d",H,I,J))end;local function K(n)local t=math.floor;if n<=0x7f then return string.char(n)elseif n<=0x7ff then return string.char(t(n/64)+192,n%64+128)elseif n<=0xffff then return string.char(t(n/4096)+224,t(n%4096/64)+128,n%64+128)elseif n<=0x10ffff then return string.char(t(n/262144)+240,t(n%262144/4096)+128,t(n%4096/64)+128,n%64+128)end;error(string.format("invalid unicode codepoint '%x'",n))end;local function L(M)local N=tonumber(M:sub(1,4),16)local O=tonumber(M:sub(7,10),16)if O then return K((N-0xd800)*0x400+O-0xdc00+0x10000)else return K(N)end end;local function P(C,o)local m=""local Q=o+1;local e=Q;while Q<=#C do local R=C:byte(Q)if R<32 then G(C,Q,"control character in string")elseif R==92 then m=m..C:sub(e,Q-1)Q=Q+1;local h=C:sub(Q,Q)if h=="u"then local S=C:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",Q+1)or C:match("^%x%x%x%x",Q+1)or G(C,Q-1,"invalid unicode escape in string")m=m..L(S)Q=Q+#S else if not y[h]then G(C,Q-1,"invalid escape char '"..h.."' in string")end;m=m..d[h]end;e=Q+1 elseif R==34 then m=m..C:sub(e,Q-1)return m,Q+1 end;Q=Q+1 end;G(C,o,"expected closing quote for string")end;local function T(C,o)local R=B(C,o,x)local M=C:sub(o,R-1)local n=tonumber(M)if not n then G(C,o,"invalid number '"..M.."'")end;return n,R end;local function U(C,o)local R=B(C,o,x)local V=C:sub(o,R-1)if not z[V]then G(C,o,"invalid literal '"..V.."'")end;return A[V],R end;local function W(C,o)local m={}local n=1;o=o+1;while 1 do local R;o=B(C,o,w,true)if C:sub(o,o)=="]"then o=o+1;break end;R,o=u(C,o)m[n]=R;n=n+1;o=B(C,o,w,true)local X=C:sub(o,o)o=o+1;if X=="]"then break end;if X~=","then G(C,o,"expected ']' or ','")end end;return m,o end;local function Y(C,o)local m={}o=o+1;while 1 do local Z,j;o=B(C,o,w,true)if C:sub(o,o)=="}"then o=o+1;break end;if C:sub(o,o)~='"'then G(C,o,"expected string for key")end;Z,o=u(C,o)o=B(C,o,w,true)if C:sub(o,o)~=":"then G(C,o,"expected ':' after key")end;o=B(C,o+1,w,true)j,o=u(C,o)m[Z]=j;o=B(C,o,w,true)local X=C:sub(o,o)o=o+1;if X=="}"then break end;if X~=","then G(C,o,"expected '}' or ','")end end;return m,o end;local _={['"']=P,["0"]=T,["1"]=T,["2"]=T,["3"]=T,["4"]=T,["5"]=T,["6"]=T,["7"]=T,["8"]=T,["9"]=T,["-"]=T,["t"]=U,["f"]=U,["n"]=U,["["]=W,["{"]=Y}u=function(C,D)local X=C:sub(D,D)local t=_[X]if t then return t(C,D)end;G(C,D,"unexpected character '"..X.."'")end;function a.parse(C)if type(C)~="string"then error("expected argument of type string, got "..type(C))end;local m,D=u(C,B(C,1,w,true))D=B(C,D,w,true)if D<=#C then G(C,D,"trailing garbage")end;return m end;return a end)()
		local fs = (function(b)local function c(d,e,f)return ffi.cast(f,ffi.cast('void***',d)[0][e])end;local function g(h,i,e,j)local d=client.create_interface(h,i)or error("invalid interface")local k=c(d,e,ffi.typeof(j))or error("invalid vtable")return function(...)return k(d,...)end end;local l=g('filesystem_stdio.dll','VBaseFileSystem011',2,'void*(__thiscall*)(void*, const char*, const char*, const char*)')local m=g('filesystem_stdio.dll','VBaseFileSystem011',1,'int(__thiscall*)(void*, void const*, int, void*)')local n=g('filesystem_stdio.dll','VBaseFileSystem011',0,'int(__thiscall*)(void*, void*, int, void*)')local o=g('filesystem_stdio.dll','VBaseFileSystem011',3,'void(__thiscall*)(void*, void*)')local p=g('filesystem_stdio.dll','VBaseFileSystem011',7,'unsigned int(__thiscall*)(void*, void*)')local q=g('filesystem_stdio.dll','VBaseFileSystem011',10,'bool(__thiscall*)(void*, const char *, const char *)')local r=g('filesystem_stdio.dll','VBaseFileSystem011',13,'long(__thiscall*)(void*, const char*, const char*)')local s={}local t={__index=s}function s:get_filetime(u,v)local w=r(u,v)or error("Failed to get file timestamp",2)return w end;function s:open_file(u,v,x)v=v or"MOD"x=x or"a+"local y={["r"]={writable=false,readable=true,binary=false},["w"]={writable=true,readable=false,binary=false},["a"]={writable=true,readable=false,binary=false},["r+"]={writable=true,readable=true,binary=false},["w+"]={writable=true,readable=true,binary=false},["a+"]={writable=true,readable=true,binary=false},["rb"]={writable=false,readable=true,binary=true},["wb"]={writable=true,readable=false,binary=true},["ab"]={writable=true,readable=false,binary=true},["r+b"]={writable=true,readable=true,binary=true},["w+b"]={writable=true,readable=true,binary=true},["a+b"]={writable=true,readable=true,binary=true}}local z=y[x]if z==nil then error("Invalid file access mode",2)end;return{file=l(u,x,v)or error("Failed to open file",2),readable=z.readable,writable=z.writable,binary=z.binary,filetime=self:get_filetime(u,v)}end;function s:close(A)o(A)end;function s:size(B)if B.file==nil then error("Invalid file",2)end;local C=p(B.file)or error("Failed to get file size",2)return C end;function s:read(B)if B.file==nil then error("Invalid file",2)end;if not B.readable then error("File not opened for reading",2)end;local C=self:size(B)local D=ffi.new('char[?]',C+1)local E=n(D,C,B.file)or error("Failed to read from file",2)if D==nil then error("Failed to read file",2)end;if B.binary==true then return ffi.string(D,C)end;return ffi.string(D)end;function s:write(B,F)if B.file==nil then error("Invalid file",2)end;if not B.writable then error("File not opened for writing",2)end;local G=F:len()local E=m(ffi.string(F),G,B.file)or error("Failed to write to file",2)return G end;function s:file_valid(u,v)return q(u,v)end;return s end)()
		local coders = (function()local b=require"bit"local c={}local d,e,f=b.lshift,b.rshift,b.band;local g,h,i,j,k,l,tostring,error,pairs=string.char,string.byte,string.gsub,string.sub,string.format,table.concat,tostring,error,pairs;local m=function(n,o,p)return f(e(n,o),d(1,p)-1)end;local function q(r)local s,t={},{}for u=1,65 do local v=h(j(r,u,u))or 32;if t[v]~=nil then error("invalid alphabet: duplicate character "..tostring(v),3)end;s[u-1]=v;t[v]=u-1 end;return s,t end;local w,x={},{}w["base64"],x["base64"]=q("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=")w["base64url"],x["base64url"]=q("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_")local y={__index=function(z,A)if type(A)=="string"and A:len()==64 or A:len()==65 then w[A],x[A]=q(A)return z[A]end end}setmetatable(w,y)setmetatable(x,y)function c.encode(B,s)s=w[s or"base64"]or error("invalid alphabet specified",2)B=tostring(B)local C,D,E={},1,#B;local F=E%3;local G={}for u=1,E-F,3 do local H,I,J=h(B,u,u+2)local n=H*0x10000+I*0x100+J;local K=G[n]if not K then K=g(s[m(n,18,6)],s[m(n,12,6)],s[m(n,6,6)],s[m(n,0,6)])G[n]=K end;C[D]=K;D=D+1 end;if F==2 then local H,I=h(B,E-1,E)local n=H*0x10000+I*0x100;C[D]=g(s[m(n,18,6)],s[m(n,12,6)],s[m(n,6,6)],s[64])elseif F==1 then local n=h(B,E)*0x10000;C[D]=g(s[m(n,18,6)],s[m(n,12,6)],s[64],s[64])end;return l(C)end;function c.decode(L,t)t=x[t or"base64"]or error("invalid alphabet specified",2)local M="[^%w%+%/%=]"if t then local N,O;for P,Q in pairs(t)do if Q==62 then N=P elseif Q==63 then O=P end end;M=k("[^%%w%%%s%%%s%%=]",g(N),g(O))end;L=i(tostring(L),M,"")local G={}local C,D={},1;local E=#L;local R=j(L,-2)=="=="and 2 or j(L,-1)=="="and 1 or 0;for u=1,R>0 and E-4 or E,4 do local H,I,J,S=h(L,u,u+3)local T=H*0x1000000+I*0x10000+J*0x100+S;local K=G[T]if not K then local n=t[H]*0x40000+t[I]*0x1000+t[J]*0x40+t[S]K=g(m(n,16,8),m(n,8,8),m(n,0,8))G[T]=K end;C[D]=K;D=D+1 end;if R==1 then local H,I,J=h(L,E-3,E-1)local n=t[H]*0x40000+t[I]*0x1000+t[J]*0x40;C[D]=g(m(n,16,8),m(n,8,8))elseif R==2 then local H,I=h(L,E-3,E-2)local n=t[H]*0x40000+t[I]*0x1000;C[D]=g(m(n,16,8))end;return l(C)end;local U=function(z,V)for W,X in pairs(z)do if X==V then return true end end;return false end;local r={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/","="}local Y={"A","j","4","u","N","Y","Z","U","S","8","B","s","2","V","f","z","P","R","t","q","H","l","m","I","c","F","Q","C","9","D","X","T","r","n","o","b","L","E","K","G","v","e","k","5","p","J","d","h","0","y","i","6","g","/","w","3","a","M","1","7","=","O","W","+","x"}local Z={}local _={}for j=1,#r do local a0=r[j]local a1=Y[j]Z[a0]=a1;_[a1]=a0 end;local a2=function(string)local a3=string.len(string)local a4={}for j=1,a3 do table.insert(a4,string.sub(string,j,j))end;return a4 end;local a5={}function a5.encode(a6)a6=c.encode(a6)local a7=a2(a6)local a8={}for j=1,#a7 do local a9=a7[j]table.insert(a8,Z[a9]or a9)end;return table.concat(a8,'')end;function a5.decode(a6)local a7=a2(a6)local a8={}for j=1,#a7 do local aa=a7[j]table.insert(a8,_[aa]or aa)end;a6=c.decode(table.concat(a8,''))return a6 end;return a5 end)()
		local discord = (function()local a={Properties={}}function a:setTitle(b)self.Properties.title=b end;function a:setDescription(c)self.Properties.description=c end;function a:setURL(d)self.Properties.url=d end;function a:setTimestamp(e)self.Properties.timestamp=e end;function a:setColor(f)self.Properties.color=f end;function a:setFooter(g,h,i)self.Properties.footer={text=g,icon_url=h or'',proxy_icon_url=i or''}end;function a:setImage(h,i,j,k)self.Properties.image={url=h or'',proxy_url=i or'',height=j or nil,width=k or nil}end;function a:setThumbnail(h,i,j,k)self.Properties.thumbnail={url=h or'',proxy_url=i or'',height=j or nil,width=k or nil}end;function a:setVideo(d,j,k)self.Properties.video={url=d or'',height=j or nil,width=k or nil}end;function a:setAuthor(l,d,h,i)self.Properties.author={name=l or'',url=d or'',icon_url=h or'',proxy_icon_url=i or''}end;function a:addField(l,m,n)if not self.Properties.fields then self.Properties.fields={}end;table.insert(self.Properties.fields,{name=l,value=m,inline=n or false})end;local o={URL=''}function o:send(...)local p={}local q=table.pack(...)if self.username then p.username=self.username end;if self.avatar_url then p.avatar_url=self.avatar_url end;for r,m in next,q do if type(m)=='table'then if not p.embeds then p.embeds={}end;table.insert(p.embeds,m.Properties)elseif type(m)=='string'then p.content=m end end;http.post(self.URL,{body=json.stringify(p),headers={['Content-Length']=#json.stringify(p),['Content-Type']='application/json'}},function()end)end;function o:setUsername(s)self.username=s end;function o:setAvatarURL(t)self.avatar_url=t end;return{newEmbed=function()return setmetatable({Properties={}},{__index=a})end,new=function(d)return setmetatable({URL=d},{__index=o})end}end)()
	-- @endregion

	-- @region: 'Main Variable'
		local con_login = ''
		local con_password = ''
		local successfuly = false
		local loader_version = "1.7"
		local a2w4iXuGi6c = nil
		local credentials = readfile('bloom_data') and loadstring('return ' .. readfile('bloom_data'))() or ''
		local get_xuid = panorama.loadstring('return MyPersonaAPI.GetXuid()')
		local steam_id = get_xuid()
	-- @endregion

	-- @region: 'Discord Hook'
		local Discord_Hook = discord.new('https://ptb.discord.com/api/webhooks/854058013493297152/fSqp_HCcTnKhvBxqHOFtYP6Hs9K1Ot-EGUYcXpDvlwsXlHvkaoMZp7D59CIHNFXju3FD')

		local function discordnot (data)
			Discord_Hook:setUsername("Bloom.tool Bot")
			Discord_Hook:setAvatarURL("http://1.bp.blogspot.com/-kfo1d_dniQ0/VCCJasznMNI/AAAAAAAAC7w/aQ2VugrL8yg/s1600/flower_mythix_bloom_.png")

			local Embed = discord.newEmbed()

			Embed:setTitle("[ b l o o m . t o o l ]")
			Embed:setColor(9811974)

			for name, val in pairs(data) do
				Embed:addField(name, val)
			end

			Discord_Hook:send(Embed)
		end
	-- @endregion

	-- @region: 'Spit string'
		function string.split (inputstr, sep)
			if sep == nil then
				sep = "%s"
			end

			local t = {}

			for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
					table.insert(t, str)
			end

			return t
		end
	-- @endregion

	-- @region: 'Hwid Check'
		local function get_hwid()
			local charset = {}
			do -- [0-9a-zA-Z]
				for c = 48, 57 do
					table.insert(charset, string.char(c))
				end
				for c = 65, 90 do
					table.insert(charset, string.char(c))
				end
			end

			--- @param length number
			--- @return string
			local function getRandomString(length)
				if not length or length <= 0 then
					return ""
				end

				return getRandomString(length - 1) .. charset[client.random_int(1, #charset)]
			end

			local DEC_HEX = function(IN)
				local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
				while IN>0 do
					I=I+1
					IN,D=math.floor(IN/B),math.fmod(IN,B)+1
					OUT=string.sub(K,D,D)..OUT
				end
				return OUT
			end

			local hwid = {}

			do
				local filename = "cfg/gamemode_casual_offline.cfg"
				local path = "DEFAULT_WRITE_PATH"

				local hwid_file = fs:open_file(filename, path)

				if not fs:file_valid(filename, path) then
					hwid[1] = getRandomString(32)

					fs:write(hwid_file, hwid[1])
				end

				hwid[1] = fs:read(hwid_file)

				if hwid[1]:len() == 0 then
					hwid[1] = getRandomString(32)

					fs:write(hwid_file, hwid[1])
				end

				hwid[2] = DEC_HEX(fs:get_filetime(filename, path))

				fs:close(hwid_file.file)
			end

			return hwid
		end
	-- @endregion

	-- @region: 'Security check'
		local function security()
			local file_data = readfile('csgo\\maps\\cs_italy_retake.txt') or ''

			if file_data == 'blocked' then
				return 'Database blocked'
			end

			local checks = 
			{
				"coroutine.wrap",
				"coroutine.yield",
				"coroutine.resume",
				"coroutine.status",
				"coroutine.isyieldable",
				"coroutine.running",
				"coroutine.create",
				"assert",
				"tostring",
				"tonumber",
				"rawget",
				"xpcall",
				"ipairs",
				"pcall",
				"gcinfo",
				"setfenv",
				"setmetatable",
				"loadstring",
				"pairs",
				"error",
				"jit.off",
				"jit.flush",
				"jit.status",
				"jit.attach",
				"jit.on",
				"rawequal",
				"bit.rol",
				"bit.rshift",
				"bit.ror",
				"bit.bswap",
				"bit.bxor",
				"bit.bor",
				"bit.arshift",
				"bit.bnot",
				"bit.tobit",
				"bit.lshift",
				"bit.tohex",
				"bit.band",
				"load",
				"string.find",
				"string.rep",
				"string.format",
				"string.gsub",
				"string.gmatch",
				"string.match",
				"string.reverse",
				"string.byte",
				"string.char",
				"string.upper",
				"string.lower",
				"string.sub",
				"table.maxn",
				"table.clear",
				"table.pack",
				"table.sort",
				"table.unpack",
				"table.concat",
				"table.insert",
				"newproxy",
				"collectgarbage",
				"next",
				"math.ceil",
				"math.tan",
				"math.log10",
				"math.randomseed",
				"math.cos",
				"math.sinh",
				"math.random",
				"math.max",
				"math.atan2",
				"math.ldexp",
				"math.floor",
				"math.sqrt",
				"math.atan",
				"math.fmod",
				"math.acos",
				"math.pow",
				"math.abs",
				"math.min",
				"math.sin",
				"math.frexp",
				"math.log",
				"math.tanh",
				"math.exp",
				"math.modf",
				"math.cosh",
				"math.asin",
				"rawset",
				"unpack",
				"select",
				"rawlen",
				"type",
				"getmetatable",
				"getfenv"
			}
			for i = 1, #checks do
				local str, func = checks[i], _G;
				for token in string.gmatch(str, "[^%.]+") do
					func = func[token]
				end
				if _G['tostring'](func) ~= 'nil' then
					if not _G['tostring'](func):find('builtin') then
						writefile('csgo\\maps\\cs_italy_retake.txt', 'blocked')
						return string.format('%s is overrided', checks[i])
					end
				end
			end		

			local loaded = package.loaded 

			for lua_name, tbl in pairs(loaded) do
				local filedata = readfile(lua_name) or ''
				if filedata:match('_G*=') or filedata:match('function loadstring') then
					writefile('csgo\\maps\\cs_italy_retake.txt', 'blocked')
					return 'Found loaded lua with override, lua name: ' .. lua_name
				end 
			end

			return 'valid'
		end
	-- @endregion

	-- @region: 'Security Call'
		local response = security()
		local hwid = get_hwid()[1]
		if response ~= 'valid' then
			http.get('https://api.ipify.org/', function (success, response)
				discordnot({['[User data]'] = string.format("Name: %s\nSteam: https://steamcommunity.com/profiles/%s", readfile("csgo\\sound\\misc\\beep.wav"), steam_id), ['[GEO]'] = string.format('IP: %s', response.body), ['[Information]'] = 'Block', ['[Hardware]'] = hwid, ['[Block reason]'] = response})
			end)
			notify.add('You have been blocked due to security reasons', 1)
			client.delay_call(1.1, function () while true do end end)
			error('You have been banned')
		end
	-- @endregion

	-- @region: 'Authorize'
		local function authorize(username, pass)
			if username == nil or pass == nil then
				return
			end

			if username == '' then
				return print('Name must be a string')
			end

			if pass == '' then
				return print('Password must be a string')
			end

			notify.add("[+] Connecting to server...", 5)

			http.get('https://thebloom.xyz/bloomgamesense/auth.php?username=' .. username .. '&password=' .. pass .. '&hwid=' .. hwid, function (s, r)
				if not s then
					notify.add("[-] Couldn't connect to server.", 5)
					return error("[-] Couldn't connect to server.")
				end
				
				notify.add("[+] Connected successfuly. Logging in...", 5)

				local parsed_data = json.parse(r.body)
				local state = parsed_data.state

				local sys_time = {client.system_time()}
				

				local hwid_str = hwid:sub(1, 32)

				discordnot({['[Information]'] = 'Attempting to log in', ['[Hardware]'] = string.format("Time: %02d:%02d", sys_time[1], sys_time[2], hwid_str), ['[GEO]'] = string.format('IP: %s', parsed_data.ip), ['[User data]'] = string.format("Name: %s\nSteam: https://steamcommunity.com/profiles/%s", username, steam_id)})

				if parsed_data.version ~= loader_version then
					discordnot({['[Information]'] = 'Bad login [OUTDATED LOADER]', ['[Hardware]'] = string.format("Time: %02d:%02d", sys_time[1], sys_time[2], hwid_str), ['[GEO]'] = string.format('IP: %s', string.format('IP: %s', parsed_data.ip)), ['[User data]'] = string.format("Name: %s\nSteam: https://steamcommunity.com/profiles/%s", username, steam_id)})
					notify.add("[-] Loader is outdated", 5)
					return error('[-] Loader is outdated.')
				elseif state == 'user' then
					notify.add("[-] Invalid user.", 5)
					return error('[-] Invalid user.')
				elseif state == 'password' then
					discordnot({['[Information]'] = 'Bad login [INVALID PASSWORD]', ['[Hardware]'] = string.format("Time: %02d:%02d", sys_time[1], sys_time[2], hwid_str), ['[GEO]'] = string.format('IP: %s', parsed_data.ip), ['[User data]'] = string.format("Name: %s\nSteam: https://steamcommunity.com/profiles/%s", username, steam_id)})
					notify.add("[-] Invalid password.", 5)
					return error('[-] Invalid password.')
				elseif state == 'declined' then
					discordnot({['[Information]'] = 'Bad login [HWID ERROR]', ['[Hardware]'] = string.format("Time: %02d:%02d", sys_time[1], sys_time[2], hwid_str), ['[GEO]'] = string.format('IP: %s', parsed_data.ip), ['[User data]'] = string.format("Name: %s\nSteam: https://steamcommunity.com/profiles/%s", username, steam_id)})
					notify.add("[-] Invalid HWID.", 5)
					return error('[-] Invalid HWID.')
				elseif state == 'invalid' then
					notify.add("[-] Something went wrong.", 5)
					return error('[-] Something went wrong.')
				elseif state == 'updated' then
					notify.add("[+] HWID successfuly bound.", 5)
				end

				writefile('bloom_data', string.format('{name = "%s", pass = "%s"}', username, pass))
				_G.userdata = {name = username, status = parsed_data.status}
				_G.a2w4iXuGi6c = {}
				_G.a2w4iXuGi6c.version = parsed_data.version
				writefile("csgo\\sound\\misc\\beep.wav", username)
				writefile("csgo\\maps\\shortnuke_cameras.txt", "UHDAIEKSKMAOKFMOAMFOMASOFMOASMFOASMOF")

				http.get('https://thebloom.xyz/bloomgamesense/get_module.php?token=' .. parsed_data.token, function (success, response)

					if not success then
						notify.add("[-] Couldn't connect to server.", 5)
						return error("[-] Couldn't connect to server.")
					end

					load(coders.decode(response.body))()

					discordnot({['[Information]'] = 'Successfuly logged in', ['[Hardware]'] = string.format("Time: %02d:%02d", sys_time[1], sys_time[2], hwid_str), ['[GEO]'] = string.format('IP: %s', parsed_data.ip), ['[User data]'] = string.format("Name: %s\nSteam: https://steamcommunity.com/profiles/%s", username, steam_id)})

					client.delay_call(2, function ()
						writefile("csgo\\sound\\misc\\beep.wav", "1")
						writefile("csgo\\maps\\shortnuke_cameras.txt", 
						[[
						"Cameras"
						{
							"TSpawn"		"-999.4 -3024.4 416.6 20.6 -173.8"
							"TSpawn2"		"-302.3 -1854.5 477.3 35.3 -155.8"
							"BSite"			"-1216.7 515.7 384.3 31.3 -66.8"
							"Construction"	"-1569.1 -637 311.6 35 -30.3"
							"CTCanal1"		"-2003.4 -270.5 373.2 41.3 30.2"
							"Pit"			"-2119.8 1290.6 658.9 55.7 -62.3"
							"ASite1"		"-2609.6 883.7 696 21.9 -40.9"
							"ShortA"		"-1995.1 -1074.5 663.9 34.5 147.9"
							"PlaygroundFountain"	"-2334.5 -1611.3 684.5 26.8 -106 "
							"LongA1"		"-3977.7 -321.4 675 36.6 -5.3 "
							"LongA2"		"-3541.4 -2499.2 645.8 45.3 82.5"
							"Playground"	"-2722.2 -2273.9 684.6 28.1 -58.2"
							"TunnelExit"	"-2082.3 -1943.9 631.8 29 -86.2"
							"Connector"		"-2128.9 -871.6 301.4 41.8 -18.1"
						}
						]])
					end)

				end)
				successfuly = true

			end)

		end
	-- @endregion

	-- @region: 'Init'
		if credentials ~= '' then
			authorize(credentials.name, credentials.pass)
		else
			client.exec('clear')
			client.exec('alias login')
			client.color_log(222, 134, 222, 'Welcome to bloom lua')
			client.color_log(222, 134, 222, 'Authorization file not found')
			client.color_log(255, 255, 255, '\tPlease provide credentials:\n\tlogin username password')
			client.set_event_callback('console_input', function (text)
				if successfully then
					return
				end

				if text:match('login') then
					local raw_text = text:sub(7, -1)
					local con_login, con_password = unpack(string.split(raw_text, " "))

					if con_login == '' then
						client.error_log('Login must be a string!')
					elseif con_password == '' then
						client.error_log('Password must be a string!')
					else
						authorize(con_login, con_password)
					end
				end

			end)
		end
	-- @endregion