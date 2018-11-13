const cacheName = 'v1';
const cacheAssets = ['index.aspx', 'ophcontent/themes/themeone/xslt/login.xslt', 'ophcore/script/default_theme.js', 'ophcore/script/fn_general.js', 'ophcore/script/fn_theme.js'];
//install event
self.addEventListener('install', function (e) {
    console.log('Service Worker: Installed');
});

//activate event
self.addEventListener('activate', function (e) {
    console.log('Service Worker: Activated');
});