<%@ Page Language="VB" AutoEventWireup="false" CodeFile="sw_offline.aspx.vb" Inherits="sw_offline" %>


    const cacheName = '<%=contentofLatestUpdate%>';
    const cacheAssets = [<%=contentofSW%>];
    //install event
    self.addEventListener('install', function (e) {
        console.log('Service Worker: Installed');
        e.waitUntil(
            caches
                .open(cacheName)
                .then(function (cache) {
                    console.log('Service Worker: Caching Files');
                    cache.addAll(cacheAssets);
                })
                .then(function () { return self.skipWaiting(); })
        );
    });

    //activate event
    self.addEventListener('activate', function (e) {
        console.log('Service Worker: Activated');
        e.waitUntil(
            caches.keys().then(function (cacheNames) {
                return Promise.all(
                    cacheNames.map(function (cache) {
                        if (cache !== cacheName) {
                            console.log('Service Worker: Clearing Old Cache');
                            return caches.delete(cache);
                        }
                    })
                )
            })
        )
    });


    //fetch event
    self.addEventListener('fetch', function (e) {
        console.log('Service Worker: Fetching');
        e.respondWith(fetch(e.request).catch(function () { return caches.match(e.request) }))
    });



