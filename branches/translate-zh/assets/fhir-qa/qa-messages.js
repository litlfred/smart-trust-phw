(function () {
  "use strict";
  var COLOR = { fatal: "#ff9999", error: "#ffdddd", warning: "#ffebcc", information: "#ffffe6" };
  var boxes = document.querySelectorAll(".ig-qa-publisher");
  if (boxes.length && !document.getElementById("ig-qa-publisher-css")) {
    var css = document.createElement("style");
    css.id = "ig-qa-publisher-css";
    css.textContent =
      ".ig-qa-publisher table.grid{border-collapse:collapse;margin:0 0 1em;font-size:.85em;width:auto}" +
      ".ig-qa-publisher table.grid td{border:1px solid #888;padding:3px 6px;vertical-align:top;color:#000}" +
      ".ig-qa-publisher table.grid td.plain{color:inherit}" +
      ".ig-qa-publisher .mid{font-size:8px;color:navy;display:none}" +
      ".ig-qa-publisher.show-ids .mid{display:inline}" +
      ".ig-qa-publisher .grid-wrap{overflow-x:auto}";
    document.head.appendChild(css);
  }
  for (var i = 0; i < boxes.length; i++) run(boxes[i]);

  function el(tag, text, attrs) {
    var e = document.createElement(tag);
    if (text != null) e.textContent = String(text);
    for (var k in attrs || {}) if (Object.prototype.hasOwnProperty.call(attrs, k)) e.setAttribute(k, attrs[k]);
    return e;
  }
  function getJson(u) {
    return fetch(u).then(function (r) {
      if (!r.ok) throw new Error(u + " answered HTTP " + r.status);
      return r.json();
    });
  }
  function row(cells, color, bold) {
    var tr = el("tr", null, color ? { style: "background-color: " + color } : null);
    cells.forEach(function (c) {
      var td = el("td", null, color ? null : { "class": "plain" });
      if (c && c.nodeType) td.appendChild(c);
      else if (bold) td.appendChild(el("b", c));
      else td.textContent = c == null ? "" : String(c);
      tr.appendChild(td);
    });
    return tr;
  }
  function wrap(table) {
    var d = el("div", null, { "class": "grid-wrap" });
    d.appendChild(table);
    return d;
  }
  function counts(g) {
    var c = { err: 0, warn: 0, info: 0 };
    g.messages.forEach(function (m) {
      if (m.severity === "error" || m.severity === "fatal") c.err++;
      else if (m.severity === "warning") c.warn++;
      else c.info++;
    });
    return c;
  }

  function run(box) {
    var pagesUrl = box.getAttribute("data-pages");
    Promise.all([
      getJson(box.getAttribute("data-summary")).catch(function () { return {}; }),
      getJson(box.getAttribute("data-messages")),
      pagesUrl ? getJson(pagesUrl).catch(function () { return []; }) : Promise.resolve([]),
    ])
      .then(function (r) {
        var pages = {};
        (Array.isArray(r[2]) ? r[2] : []).forEach(function (p) { pages[p] = true; });
        var q = r[0] || {};
        var canon = typeof q.url === "string" ? q.url.replace(/\/ImplementationGuide\/[^\/]+$/, "") : "";
        draw(box, q, r[1] || {}, {
          pages: pages,
          artifacts: box.getAttribute("data-artifacts") || "artifact/",
          source: box.getAttribute("data-source") || "",
          canon: canon,
        });
      })
      .catch(function (e) {
        box.textContent = "";
        box.appendChild(el("p", "Could not load the Publisher's messages (" + e.message + ")."));
      });
  }

  /** The site's page for a resource named Type-id, when the site has one. */
  function pageFor(L, name) {
    return L.pages[name + ".html"] ? L.artifacts + name + ".html" : null;
  }
  /** A message file: its artifact page on this site, and its source at the built commit when it is tracked (input/...). */
  function fileCell(L, file, label) {
    var span = el("span");
    var base = file ? file.replace(/^.*\//, "").replace(/\.(json|xml|fsh)$/, "") : "";
    var page = base && pageFor(L, base);
    span.appendChild(page ? el("a", label, { href: page }) : document.createTextNode(label));
    if (file && L.source && /^input\//.test(file)) {
      span.appendChild(document.createTextNode(" "));
      span.appendChild(el("a", "(source)", { href: L.source + file.split("/").map(encodeURIComponent).join("/") }));
    }
    return span;
  }
  /** Message text with each URL linked: one of this IG's canonicals to its page here, any other to itself. */
  function linkText(L, text) {
    var out = el("b");
    var re = /https?:\/\/[^\s'"<>()|]+[^\s'"<>()|.,;:]/g;
    var last = 0;
    var m;
    while ((m = re.exec(text))) {
      out.appendChild(document.createTextNode(text.slice(last, m.index)));
      var u = m[0].replace(/\|.*$/, "");
      var href = u;
      if (L.canon && u.indexOf(L.canon + "/") === 0) {
        var rest = u.slice(L.canon.length + 1).split("/");
        if (rest.length === 2) href = pageFor(L, rest[0] + "-" + rest[1]) || u;
      }
      out.appendChild(el("a", m[0], { href: href }));
      last = m.index + m[0].length;
    }
    out.appendChild(document.createTextNode(text.slice(last)));
    return out;
  }

  function draw(box, q, m, L) {
    box.textContent = "";
    var groups = Array.isArray(m.groups) ? m.groups : [];
    box.appendChild(el("h4", "Validation Results for " + (q.title || q.name || "this IG")));
    var p = el("p");
    p.appendChild(document.createTextNode("Generated " + (q.date || q.dateISO8601 || "?") + ", FHIR version " + (q.version || "?") + " for "));
    var igName = (q["package-id"] || "?") + "#" + (q["ig-ver"] || "?");
    var igPage = q["package-id"] && pageFor(L, "ImplementationGuide-" + q["package-id"]);
    p.appendChild(igPage ? el("a", igName, { href: igPage }) : document.createTextNode(igName));
    if (q.url) {
      p.appendChild(document.createTextNode(" (canonical = "));
      var a = el("a", q.url, { href: q.url });
      p.appendChild(a);
      p.appendChild(document.createTextNode(")"));
    }
    p.appendChild(document.createTextNode("."));
    box.appendChild(p);

    var qc = el("table", null, { "class": "grid" });
    var head = el("tr");
    var th = el("td", null, { colspan: "2", "class": "plain" });
    th.appendChild(el("b", "Quality Checks"));
    head.appendChild(th);
    qc.appendChild(head);
    qc.appendChild(row(["Publisher Version:", q.tool || "?"]));
    var btn = el("button", "Show Message Ids", { type: "button" });
    btn.addEventListener("click", function () {
      var on = box.className.indexOf("show-ids") < 0;
      box.className = on ? box.className + " show-ids" : box.className.replace(/ ?show-ids/, "");
      btn.textContent = on ? "Hide Message Ids" : "Show Message Ids";
    });
    var sum = el("span");
    sum.appendChild(document.createTextNode(" errors = " + (q.errs != null ? q.errs : "?") + ", warn = " + (q.warnings != null ? q.warnings : "?") + ", info = " + (q.hints != null ? q.hints : "?") + ", broken links = " + (q["broken-links"] != null ? q["broken-links"] : "?") + ".  "));
    sum.appendChild(btn);
    qc.appendChild(row(["Summary:", sum]));
    box.appendChild(wrap(qc));

    var files = el("table", null, { "class": "grid", id: "qa-files" });
    files.appendChild(row(["Filename", "Errors", "Warnings", "Hints"], null, true));
    groups.forEach(function (g, i) {
      var c = counts(g);
      var b = el("b");
      b.appendChild(el("a", g.file || "Build Errors", { href: "#qa-f" + i }));
      var base = g.file ? g.file.replace(/^.*\//, "").replace(/\.(json|xml|fsh)$/, "") : "";
      var page = base && pageFor(L, base);
      if (page) {
        b.appendChild(document.createTextNode(" "));
        b.appendChild(el("a", "(page)", { href: page }));
      }
      files.appendChild(row([b, String(c.err), String(c.warn), String(c.info)], c.err ? COLOR.error : "#EFFFEF"));
    });
    box.appendChild(wrap(files));
    if (!groups.length) box.appendChild(el("p", m.absent ? "No messages: " + m.absent + "." : "The Publisher reported no messages."));

    groups.forEach(function (g, i) {
      box.appendChild(el("hr"));
      var c = counts(g);
      var h = el("h5", null, { id: "qa-f" + i });
      h.appendChild(fileCell(L, g.file, g.file || "Build Errors"));
      h.appendChild(document.createTextNode("  (" + c.err + " errors, " + c.warn + " warnings, " + c.info + " hints) "));
      h.appendChild(el("a", "\u2191 files", { href: "#qa-files" }));
      box.appendChild(h);
      var t = el("table", null, { "class": "grid" });
      t.appendChild(row(["Path", "Severity", "Message"], null, true));
      g.messages.forEach(function (msg) {
        var where = (msg.path || "") + (msg.line > 0 ? " (l" + msg.line + "/c" + msg.col + ")" : "");
        var text = el("span");
        text.appendChild(linkText(L, msg.text));
        if (msg.messageId) {
          text.appendChild(document.createTextNode(" "));
          text.appendChild(el("span", msg.messageId, { "class": "mid" }));
        }
        var pw = el("b", where);
        var sv = el("b", msg.severity);
        t.appendChild(row([pw, sv, text], COLOR[msg.severity] || COLOR.information));
      });
      box.appendChild(wrap(t));
    });
  }
})();
