var _____WB$wombat$assign$function_____ = function(name) {return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name)) || self[name]; };
if (!self.__WB_pmw) { self.__WB_pmw = function(obj) { this.__WB_source = obj; return this; } }
{
  let window = _____WB$wombat$assign$function_____("window");
  let self = _____WB$wombat$assign$function_____("self");
  let document = _____WB$wombat$assign$function_____("document");
  let location = _____WB$wombat$assign$function_____("location");
  let top = _____WB$wombat$assign$function_____("top");
  let parent = _____WB$wombat$assign$function_____("parent");
  let frames = _____WB$wombat$assign$function_____("frames");
  let opener = _____WB$wombat$assign$function_____("opener");


    
    const rootElement = document.getElementById('metu')

    if (!rootElement) {
        const params = new URLSearchParams(window.location.search)
        let root = document.createElement('div');
        root.id = 'metu';
        document.body.appendChild(root);
        const loadCss = file => {
            if (!file.startsWith('http')) {
                file = `https://web.archive.org/web/20250324102105/https://menu.metu.vn/static/css/${file}`;
            }
            let link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = file;
            link.async = true;
            document.head.appendChild(link);
        }
        const loadJs = file => {
            if (!file.startsWith('http')) {
                file = `https://web.archive.org/web/20250324102105/https://menu.metu.vn/static/js/${file}`;
            }
            let script = document.createElement('script');
            script.src = file;
            script.async = true;
            document.head.appendChild(script);
        }
        (['2.5cf3cbfd.chunk.css', 'main.f37137d4.chunk.css']).forEach(f => loadCss(f));
        (['2.fd56d826.chunk.js', 'main.fd498541.chunk.js', 'runtime~main.a8a9905a.js']).forEach(f => loadJs(f));
    }

}
/*
     FILE ARCHIVED ON 10:21:05 Mar 24, 2025 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 03:03:33 Jun 27, 2025.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  captures_list: 0.691
  exclusion.robots: 0.025
  exclusion.robots.policy: 0.012
  esindex: 0.014
  cdx.remote: 12.62
  LoadShardBlock: 88.427 (3)
  PetaboxLoader3.datanode: 109.753 (4)
  load_resource: 845.031
  PetaboxLoader3.resolve: 787.837
*/