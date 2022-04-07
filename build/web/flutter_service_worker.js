'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "264ab5273e312d94837b4028731c5eeb",
"assets/assets/images/1184247.jpg": "8c9345125b73ea287b1228b6c59776da",
"assets/assets/images/86.png": "fd759dca77b0638a40777eeeae97a824",
"assets/assets/images/Anju.jpg": "de6b4490932b98de5ea14c97f0ea6b41",
"assets/assets/images/bg.jpg": "0a0db9cba08227d9fe5b2ac8eced74ff",
"assets/assets/images/bg2.jpg": "423a6cea33c3e6b356651acabf086913",
"assets/assets/images/bgb.jpg": "46d85de742183504cb840bee9f5a4edf",
"assets/assets/images/Fredica.png": "fc461863b0ec0168c49da15acb80414a",
"assets/assets/images/Henrietta.jpg": "fa019ebf8de2d81fce066dc132398f8a",
"assets/assets/images/icon.png": "b3f8039c4bc02e5c70e6627fb58f44ae",
"assets/assets/images/Ikumi.png": "7b693b89488b4d2e1757ca7e11a47e91",
"assets/assets/images/Kurena.jpg": "389f23323705a9ca6d25b6929ffa6388",
"assets/assets/images/lena.jpg": "724d8c270f64cd20d0f16f4dabf98ecf",
"assets/assets/images/Middle.jpg": "b97f7dd9c7eeb81644d85ea9d1218dd8",
"assets/assets/images/middle2.jpg": "d9e40153f92b8cf734fcaa91290fe379",
"assets/assets/images/Misaki.png": "4573741dc2d7975e90e82a500100042f",
"assets/assets/images/Natsumi.png": "1aff23f959214baab124885ff0ec3318",
"assets/assets/images/Raiden.jpg": "8335ae8bac0fd48b311d8b16d8ab0e43",
"assets/assets/images/Riho.png": "daaf83cce736e7ed4975337b0752b15b",
"assets/assets/images/Rikka.jpg": "1aebda96014345883fa4196b21761e95",
"assets/assets/images/Saori.png": "94d418b23ed5c27bdb587ba0afee1c35",
"assets/assets/images/Sayumi.png": "6599dee9dbdc156895ccc46e2df7f06a",
"assets/assets/images/Seiichirou.png": "4377f051b92a72d24b6d66f17fa2aac0",
"assets/assets/images/shin.png": "fcf89388f60b11acc12c749d020092ce",
"assets/assets/images/Shouya.png": "8d795311c0129b4d405bd2e4846e56f8",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "8b5f0b8e497484f7604f333baa4fbc5b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "03bf34b3c94c9c07d0267daa1950610c",
"/": "03bf34b3c94c9c07d0267daa1950610c",
"main.dart.js": "013764ba6c7af1429c619e28c7ad520c",
"manifest.json": "3acc5db3cbc37cd9cfefea77e5c28a4a",
"version.json": "3d36d9745b99cb5d5a8cca314172cd92"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
