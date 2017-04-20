# Unity-WebGL-Utilities
Some helpful utilities for Unity WebGL games based on and inspired by the Unity team's blog posts and WebGL essentials asset packages.

## Installing
Grab the [latest release](https://github.com/kongregate/Unity-WebGL-Utilities/releases) and import the `unitypackage` into your project.

## WebGLMemoryStats

This is a simple behavior that you can add to a persistent game object. It will periodically log WebGL memory statistics to the browser console to help you tune your WebGL memory size:

![](http://kong.dreamhosters.com/grabs/Default_unity_-_mtx-unity_-_WebGL__Personal___OpenGL_4_1__1E96A487.png)

![](http://kong.dreamhosters.com/grabs/Play_webgl-test__a_free_online_game_on_Kongregate_1E96A97A.png)

## Updated CachedXMLHttpRequest

The original version of CachedXMLHttpRequest unfortunately has a few bugs. This package includes an updated drop-in replacement that resolves the following issues:

* An error dialog is displayed in Firefox private browsing mode
* When used with Safari and content in an iframe the plugin is non-functional
* Synchronous XHR requests are used to revalidate resources

The updated version also adds some functionality to give you finer control over the XHR cache:

 * `Module.CachedXMLHttpRequestBlacklist` can be set to an array of `RegExp` or string objects to disable caching for matching URLs (useful to prevent caching of API endpoints, etc)
* `Module.CachedXMLHttpRequestRevalidateBlacklist` can be set to an array of `RegExp` or string objects to disable re-validation for matching URLs (helpful if you use explicit versioning on your asset bundles)

For example, the following configuration will never cache files containing `.xml`, `.php`, or `xhr_nocache`, and requests with `.unity3d` in them will not be re-validated when being loaded:

```js
var Module = {
  TOTAL_MEMORY: 268435456,
  CachedXMLHttpRequestCacheBlacklist: [/\.xml/, /\.php/, 'xhr_nocache'],
  CachedXMLHttpRequestRevalidateBlacklist: [/\.unity3d/]
};
```

## CachedXHRExtensions

This package also provides extensions to the `CachedXMLHttpRequest` addon which allow you to clear and query for the existence of items in the cache. This can be useful if you pre-fetch your asset bundles on startup to avoid doing so multiple times. The classes used below are in the `Kongregate` namespace.

**Clear the cache:**
```csharp
CachedXHRExtensions.CleanCache();
```

**Query the cache:**
```csharp
IEnumerator CheckIfAssetExists() {
  var query = new CacheEntryQuery("https://whatever.io/file.xml");
  yield return query;
  if (query.IsCached) {
    Debug.Log("Asset exists in cache!");
  }
}
```
