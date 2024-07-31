(function(b) {
    function g(b) {
        return null === b || "undefined" === typeof b
    }

    function G(b, e) {
        return g(b) ? !1 : 0 <= b.indexOf(e, b.length - e.length)
    }

    function u(b, g, a) {
        b.addEventListener ? b.addEventListener(g, a) : b.attachEvent && b.attachEvent("on" + g, a)
    }

    function p(q, e, a, z) {
        function A() {
            C = w = r = null;
            t = [];
            m = 0;
            k = [];
            B = 0;
            x = [];
            l = [];
            v = null;
            "PASSWORD" === h.type.toUpperCase() ? f.setOption("plainText", !1) : f.setOption("plainText", !0)
        }

        function p() {
            for (var d, c = 0; c < K.length; c += 1) try {
                d = K[c]();
                break
            } catch (b) {}
            if (!d) throw "vKeypad: Unable to create XMLHttpRequest object";
            return d
        }

        function F(d) {
            d || (d = b.event);
            return d
        }

        function H(d) {
            d = F(d);
            d.preventDefault ? d.preventDefault() : d.returnValue = !1
        }

        function I() {
            h.value = "";
            x = []
        }

        function J() {
            var d, c;
            if (!(0 >= k.length)) {
                var n = parseInt(b.screen.width / 1920 * B, 10);
                n < B && (n = B);
                d = n;
                var a = h.offsetLeft;
                c = h.offsetTop;
                for (var f = h.offsetParent; null !== f;) a += f.offsetLeft, c += f.offsetTop, f = f.offsetParent;
                c += h.offsetHeight;
                var g = 0;
                switch (l.align) {
                    case "right":
                        g -= d - h.offsetWidth;
                        break;
                    case "center":
                        g -= (d - h.offsetWidth) / 2
                }
                g += l.alignX;
                f = 0 + l.alignY;
                a += g;
                d = a + d - b.document.documentElement.scrollWidth;
                0 < d && (a -= d);
                0 > a && (a = 0);
                d = c + f;
                c = a;
                for (a = 0; a < k.length; a += 1)
                    if (f = k[a].childNodes[0].childNodes[0], l.isMobile) {
                        f.style.width = b.innerWidth + "px";
                        var y = b.document.documentElement,
                            g = (b.pageXOffset || y.scrollLeft) - (y.clientLeft || 0),
                            y = (b.pageYOffset || y.scrollTop) - (y.clientRight || 0);
                        k[a].style.width = b.innerWidth + "px";
                        k[a].style.top = y + b.innerHeight - f.clientHeight + "px";
                        k[a].style.left = g + "px"
                    } else f.style.width = n + "px", k[a].style.top = d + "px", k[a].style.left = c + "px"
            }
        }

        function D() {
            k[m].style.display = "none";
            h.blur()
        }

        function E(d) {
            var c = m;
            if (0 > d || d >= t.length) d = 0;
            m = d;
            k[m].style.display = "inline";
            J();
            m !== c && (k[c].style.display = "none")
        }

        function L(d) {
            if (g(d)) E(m + 1);
            else if (0 >= d.length) E(0);
            else {
                for (var c = -1, b = 0; b < d.length; b += 1)
                    if (d[b] === m) {
                        c = b;
                        break
                    } if (0 > c) E(d[0]);
                else {
                    c += 1;
                    if (0 > c || c >= d.length) c = 0;
                    E(d[c])
                }
            }
        }

        function M(d) {
            var c = p();
            c.onreadystatechange = function() {
                if (4 === c.readyState)
                    if (200 === c.status) {
                        var b = null;
                        try {
                            b = JSON.parse(c.responseText)
                        } catch (a) {
                            d.error("JSON.parse");
                            return
                        }
                        d.success(b)
                    } else d.error("HTTP Status " + c.status)
            };
            try {
                c.onerror = function() {
                    d.error("AJAX")
                }
            } catch (b) {}
            c.open("POST", N);
            c.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            var a = "operation=" + d.operation;
            d.params && 0 < d.params.length && (a += "&" + d.params);
            c.send(a)
        }

        function O(d) {
            M({
                operation: "pubkey",
                success: function(c) {
                    if (c.result) switch (c.v) {
                        case 1:
                            var a = c.n;
                            c = c.e;
                            try {
                                w = new b.KJSCrypto.RSA, w.setPublic(a, c)
                            } catch (f) {
                                w = null
                            }
                    }
                    d()
                },
                error: function(d) {
                    throw "vKeypad: Failed to communicate with server(" +
                        d + ")";
                }
            })
        }

        function P(d) {
            G(l.keypadType, "_MOBILE") && (l.isMobile || f.setOption("isMobile", !0));
            var c = "type=" + l.keypadType + "&plainText=" + l.plainText;
            if (null !== w) try {
                var a = Array(32),
                    h = Array(16);
                b.KJSCrypto.PRNG.getValues(a, 0, a.length);
                b.KJSCrypto.PRNG.getValues(h, 0, h.length);
                var q = w.encrypt(a),
                    e = b.KJSCrypto.ARIA_CTR.createInstance();
                e.setKey(a);
                e.setIV(h);
                C = a;
                var y = b.KJSCrypto.Utils.Encoding.toByteArray(c),
                    k = e.encryptStream(y),
                    a = "c1k=" + q,
                    a = a + ("&c1iv=" + b.KJSCrypto.Utils.Encoding.toHexString(h)),
                    c = a += "&c1d=" +
                    b.KJSCrypto.Utils.Encoding.toHexString(k)
            } catch (Q) {
                throw "vKeypad: Failed to encrypt data(" + Q + ")";
            }
            M({
                operation: "load",
                params: c,
                success: function(a) {
                    if (!a.result) throw "vKeypad: Server error(" + a.message + ")";
                    if (null !== w) {
                        var c = b.KJSCrypto.Utils.Encoding.fromHexString(a.c1iv),
                            f = b.KJSCrypto.ARIA_CTR.createInstance();
                        f.setKey(C);
                        f.setIV(c);
                        if (g(a.c1d)) throw "vKeypad: No server response";
                        a = b.KJSCrypto.Utils.Encoding.fromHexString(a.c1d);
                        a = f.decryptStream(a);
                        a = b.KJSCrypto.Utils.Encoding.fromByteArray(a);
                        a =
                            JSON.parse(a)
                    }
                    f = {};
                    f.vkid = a.vkid;
                    f.layouts = a.layouts;
                    f.width = a.width;
                    f.height = a.height;
                    d(f)
                },
                error: function(d) {
                    throw "vKeypad: Failed to communicate with server(" + d + ")";
                }
            })
        }
        var f = this,
            h = e,
            N = a,
            r = null,
            v = null,
            w = null,
            C = null,
            t = [],
            m = 0,
            k = [],
            B = 0,
            x = [],
            l = [],
            K = [function() {
                return new XMLHttpRequest
            }, function() {
                return new ActiveXObject("Microsoft.XMLHTTP")
            }, function() {
                return new ActiveXObject("Msxml3.XMLHTTP")
            }, function() {
                return new ActiveXObject("Msxml2.XMLHTTP")
            }];
        f.setOption = function(d, a) {
            l[d] = a
        };
        f.load = function() {
            null ===
                r && O(function() {
                    P(function(d) {
                        try {
                            r = d.vkid;
                            t = d.layouts;
                            B = d.width;
                            for (d = 0; d < t.length; d += 1) {
                                var a = b.document.createElement("DIV"),
                                    n = b.document.createElement("A"),
                                    e = b.document.createElement("IMG");
                                a.onmousedown = function(a) {
                                    H(a)
                                };
                                a.style.position = "absolute";
                                a.style.left = "0px";
                                a.style.top = "0px";
                                a.style.display = "none";
                                a.style.zIndex = l.zIndex;
                                n.ondragstart = function(a) {
                                    return !1
                                };
                                n.onmousedown = function(a) {
                                    H(a)
                                };
                                n.id = l.prefix + r + "_LegacyIEFix_" + d;
                                n.href = "#";
                                n.style.tapHighlightColor = "rgba(0, 0, 0, 0)";
                                n.style.webkitTapHighlightColor =
                                    "rgba(0, 0, 0, 0)";
                                n.style.mozTapHighlightColor = "rgba(0, 0, 0, 0)";
                                e.ondragstart = function(a) {
                                    return !1
                                };
                                e.onclick = function(a) {
                                    a = F(a);
                                    var d = a.offsetX,
                                        b = a.offsetY,
                                        c = B / k[m].clientWidth;
                                    if (g(d) || g(b)) b = (a.target || a.srcElement).getBoundingClientRect(), d = a.clientX - b.left, b = a.clientY - b.top;
                                    d = parseInt(d * c, 10);
                                    b = parseInt(b * c, 10);
                                    for (c = 0; c < t[m].keys.length; c += 1) {
                                        var e;
                                        e = t[m].keys[c].point.x;
                                        var n = t[m].keys[c].point.y;
                                        e = e > d || e + t[m].keys[c].width < d || n > b || n + t[m].keys[c].height < b ? !1 : !0;
                                        if (e) {
                                            c = t[m].keys[c];
                                            e = void 0;
                                            e = g(c.character) ? l.plainText ? "" : "~" : c.character;
                                            switch (e) {
                                                case "BACKSPACE":
                                                    x.pop();
                                                    h.value = h.value.substring(0, h.value.length - 1);
                                                    break;
                                                case "DONE":
                                                    D();
                                                    l.autoSubmit && (f.prepareSubmit(), null !== q && q.submit());
                                                    break;
                                                case "CLEAR":
                                                    I();
                                                    break;
                                                case "CANCEL":
                                                    I();
                                                    D();
                                                    break;
                                                case "SUBMIT":
                                                    f.prepareSubmit();
                                                    null !== q && q.submit();
                                                    break;
                                                case "CHANGE_LAYOUT":
                                                    L();
                                                    break;
												case "empty":
													break;
                                                default:
                                                    c = e;
                                                    if (g(c) ? 0 : 0 === c.indexOf("CHANGE_LAYOUT")) {
                                                        b = /\[(.*)\]/.exec(e);
                                                        d = [];
                                                        b = (2 > b.length ? "" : b[1]).split(",");
                                                        for (c = 0; c < b.length; c += 1) d.push(parseInt(b[c].replace(/^\s+|\s+$/g,
                                                            ""), 10));
                                                        L(d);
                                                        break
                                                    }
                                                    if (0 <= h.maxLength && h.maxLength <= x.length + 1) {
                                                        h.maxLength > x.length && (c = e, x.push(m + "." + d + "." + b), h.value += c);
                                                        D();
                                                        break
                                                    }
                                                    c = e;
                                                    x.push(m + "." + d + "." + b);
                                                    h.value += c
                                            }
                                            break
                                        }
                                    }
                                    H(a)
                                };
                                e.src = N + "?operation=image&vkid=" + r + "&layout=" + t[d].name;
                                e.style.height = "auto";
                                e.style.borderStyle = "none";
                                a.appendChild(n);
                                n.appendChild(e);
                                var area=document.getElementById('in');
                            	//if(frm.device.value=="mobile"){
                            	if(document.forms[0].device.value=="mobile"){
                            		 b.document.body.appendChild(a);
                                }
                            	else{
                            		area.appendChild(a);
                               
                            	}
                                k.push(a)
                            }
                            h.readOnly = !0;
                            h.value = "";
                            h.setAttribute("data-kdf-value-ext", "");
                            u(h, "focus", function(a) {
                                if (!g(r)) {
                                    a: {
                                        for (a = 0; a < k.length; a += 1)
                                            if ("none" !==
                                                k[a].style.display) {
                                                a = !0;
                                                break a
                                            } a = !1
                                    }
                                    a || l.clearWhenFocused && I();k[m].style.display = "inline";J()
                                }
                            });
                            u(h, "blur", function(a) {
                                g(r) || (0 === b.document.activeElement.id.indexOf(l.prefix + r + "_LegacyIEFix_") ? (a.target || a.srcElement).focus() : b.document.activeElement !== h && l.autoClose && D())
                            });
                            null !== q && l.autoPrepare && u(q, "submit", function() {
                                f.prepareSubmit()
                            });
                            var p = function() {
                                g(r) || J()
                            };
                            u(b, "resize", p);
                            setInterval(function() {
                                p()
                            }, 50)
                        } catch (z) {
                            throw "vKeypad: Unexpected error occurred. " + z;
                        }
                    })
                })
        };
        f.unload = function() {
        	var area=document.getElementById('in');
        	if(frm.device.value=="mobile"){
        		for (var a =
                    0; a < k.length; a += 1) b.document.body.removeChild(k[a]);
            null !== v && q.removeChild(v);
            a = l;
            A();
            l = a;
            h.readOnly = !1;
            h.value = "";
            a = h.name;
            0 === a.indexOf("_KDF_") && (a = a.substring(5));
            var c = b.document.getElementsByName("_KDFEXT_" + a);
            if (0 < c.length)
                for (a = 0; a < c.length; a += 1) c[a].value = ""
            }
        	else{
            for (var a =
                    0; a < k.length; a += 1) area.removeChild(k[a]);
            null !== v && q.removeChild(v);
            a = l;
            A();
            l = a;
            h.readOnly = !1;
            h.value = "";
            a = h.name;
            0 === a.indexOf("_KDF_") && (a = a.substring(5));
            var c = b.document.getElementsByName("_KDFEXT_" + a);
            if (0 < c.length)
                for (a = 0; a < c.length; a += 1) c[a].value = ""
        	}
        };
        f.reload = function() {
            f.unload();
            f.load()
        };
        f.prepareSubmit = function() {
            if (!g(q) && !g(r)) {
                g(v) || q.removeChild(v);
                v = b.document.createElement("INPUT");
                var a = h.name;
                0 === a.indexOf("_KDF_") && (a = a.substring(5));
                for (var c = b.document.getElementsByName("_KDFEXT_" +
                        a), e = 0; e < c.length; e += 1) c[e].value = "";
                c = b.document.getElementsByName("_M_KDFEXT_" + a);
                for (e = 0; e < c.length; e += 1) c[e].value = "";
                v.type = "hidden";
                v.name = l.prefix + r + a;
                v.value = f.getData();
                q.appendChild(v)
            }
        };
        f.getInput = function() {
            return h
        };
        f.getID = function() {
            return r
        };
        f.getData = function() {
            var a = x.toString();
            if (null === w) return a;
            var c = Array(16);
            b.KJSCrypto.PRNG.getValues(c, 0, c.length);
            var e = b.KJSCrypto.ARIA_CTR.createInstance();
            e.setKey(C);
            e.setIV(c);
            a = b.KJSCrypto.Utils.Encoding.toByteArray(a);
            a = e.encryptStream(a);
            e = b.KJSCrypto.Utils.Encoding.toHexString(a);
            a = b.KJSCrypto.HMAC.SHA256.compute(C, a);
            a = b.KJSCrypto.Utils.Encoding.toHexString(a);
            return "_CV2_" + b.KJSCrypto.Utils.Encoding.toHexString(c) + "_" + e + "_" + a
        };
        A();
        if (!g(q) && "FORM" !== (q.tagName || "")) throw "vKeypad: Invalid form object.";
        if (g(h) || "INPUT" !== (h.tagName || "")) throw "vKeypad: Invalid input object.";
        f.setOption("keypadType", z);
        f.setOption("autoClose", !0);
        f.setOption("autoPrepare", !0);
        f.setOption("autoSubmit", !1);
        f.setOption("clearWhenFocused", !1);
        f.setOption("isMobile",
            !1);
        f.setOption("prefix", "VKPad");
        f.setOption("align", "left");
        f.setOption("alignX", 0);
        f.setOption("alignY", 5);
        f.setOption("zIndex", 0)
    }

    function F() {
        var b = null,
            e = [];
        this.setDefaultServletURL = function(a) {
            b = a
        };
        this.newInstance = function(a, z, A, u) {
            g(a) && (a = null);
            if (g(z)) throw "vKeypad: input is null or undefined";
            if (g(A)) {
                if (g(b)) throw "vKeypad: servletURL is null or undefined";
                A = b
            }
            if (g(u)) throw "vKeypad: keypadType is null or undefined";
            a = new p(a, z, A, u);
            e.push(a);
            return a
        };
        this.getInstance = function(a) {
            for (var b =
                    0; b < e.length; b += 1)
                if (e[b].getInput() === a) return e[b];
            return null
        };
        this.setOptionAll = function(a, b) {
            for (var g = 0; g < e.length; g += 1) e[g].setOption(a, b)
        };
        this.loadAll = function() {
            for (var a = 0; a < e.length; a += 1) e[a].load()
        };
        this.unloadAll = function() {
            for (var a = 0; a < e.length; a += 1) e[a].unload()
        };
        this.reloadAll = function() {
            for (var a = 0; a < e.length; a += 1) e[a].reload()
        };
        this.prepareSubmitAll = function() {
            for (var a = 0; a < e.length; a += 1) e[a].prepareSubmit()
        }
    }
    g(b.vKeypadGlobal) && (b.vKeypadGlobal = new F, u(b, "pageshow", function(g) {
        g.persisted &&
            b.vKeypadGlobal.reloadAll()
    }))
})(this);

function vKeypad(b, g, G, u) {
    var p = new vKeypadGlobal.newInstance(b, g, G, u);
    this.setOption = function(b, g) {
        return p.setOption(b, g)
    };
    this.load = function() {
        return p.load()
    };
    this.unload = function() {
        return p.unload()
    };
    this.reload = function() {
        return p.reload()
    };
    this.prepareSubmit = function() {
        return p.prepareSubmit()
    };
    this.getID = function() {
        return p.getID()
    };
    this.getData = function() {
        return p.getData()
    };
    this.getInput = function() {
        return p.getInput()
    }
};