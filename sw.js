/* Joost OS - service worker
   ===========================================================================
   Two jobs: make the app installable, and make it open without a network.

   The page itself is fetched network-first, so opening the app on a working
   connection always gives you the newest version and you never have to think
   about clearing a cache. Everything else (icons, manifest) is cache-first,
   because those change about once a year.

   No workspace data passes through here. Your data lives in localStorage and
   never leaves the browser; this file only caches the program.
   ========================================================================= */

const VERSION = "joost-os-v1";
const SHELL = [
  "./",
  "./index.html",
  "./manifest.webmanifest",
  "./icon-192.png",
  "./icon-512.png",
  "./icon-maskable-512.png",
  "./apple-touch-icon.png",
  "./favicon-32.png",
];

self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open(VERSION)
      // One miss must not fail the whole install, so each file is added on
      // its own and a failure is allowed to pass.
      .then((c) => Promise.all(SHELL.map((u) => c.add(u).catch(() => {}))))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== VERSION).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (e) => {
  const req = e.request;
  if (req.method !== "GET") return;

  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;   // never touch anything external

  // The page: newest when online, last known copy when not.
  const isPage = req.mode === "navigate" ||
    (req.headers.get("accept") || "").includes("text/html");

  if (isPage) {
    e.respondWith(
      fetch(req)
        .then((res) => {
          const copy = res.clone();
          caches.open(VERSION).then((c) => c.put("./index.html", copy)).catch(() => {});
          return res;
        })
        .catch(() => caches.match("./index.html").then((hit) => hit || caches.match("./")))
    );
    return;
  }

  // Everything else: from the cache, and fetched once if it is not there yet.
  e.respondWith(
    caches.match(req).then((hit) => hit || fetch(req).then((res) => {
      if (res && res.ok) {
        const copy = res.clone();
        caches.open(VERSION).then((c) => c.put(req, copy)).catch(() => {});
      }
      return res;
    }))
  );
});
