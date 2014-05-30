<#ftl strip_text=true>

<#if env_in_test || ! skinUrl?has_content>
  <#assign skin = 'yeah'>
</#if>

<#assign STATIC_URL><#if env_in_test>${officialServer}<#else>${staticServer}</#if></#assign>

<#function static filePath prefix=''>
  <#assign baseUrl><#if prefix?has_content>${prefix}<#else>${STATIC_URL}</#if></#assign>
  <#if env_in_test == false && Application.distMap['/' + filePath]??>
    <#assign url = baseUrl + Application.distMap['/' + filePath]>
  <#else>
    <#assign url = baseUrl + '/' + filePath>
  </#if>
  <#return url>
</#function>

<#assign componentVersion = {
    'base': '1.0.11',
    'layout': '1.1.5',
    'sharesns': '1.0.4',
    'jquery': '1.7.2',
    'jquery_easing': '1.3',
    'jquery_cookie': '1.3',
    'handlebars': '1.0.0-rc.4'
}>

<#macro footerScript>
    <script src="${static('js/jy/sea-modules/seajs/1.3.1/sea.js')}"></script>
    <script>
      var CONF = {
        ydBaseURL: '${officialServer}',
        baseURL: '${officialServer}' + '/brief'
      };
      seajs.config({
        preload: [<#if env_in_test>'seajs/plugin-text', </#if>parent === self ? 'bootstrap/bootstrap-notify/0.0.1/bootstrap-notify' : 'http://mimg.127.net/h/lib/crossdomain-201306211750.js'],
        <#if env_in_test>
            debug: true,
            alias: {
              'jquery': 'gallery/jquery/${componentVersion.jquery}/jquery',
              'layout': '/js/jy/layout/src/layout.js',
              'post': '/js/jy/layout/src/post.js',
              'sharesns': '/js/jy/sharesns/src/sharesns',
              'page-index': '/js/jy/pages/page-index/src/page-index.js',
              'page-search': '/js/jy/pages/search/src/search',
              'base': '/js/jy/base/src/base.js',
              'content-list': '/js/jy/pages/content-list/src/content-list',
              'jquery.easing': '/js/jy/jquery.easing/src/jquery.easing',
              'jquery.cookie': '/js/jy/jquery.cookie/src/jquery.cookie'
            }
        <#else>
            alias: {
                'sharesns': 'jy/sharesns/${componentVersion.sharesns}/sharesns.js',
                'layout': 'jy/layout/${componentVersion.layout}/layout',
                'post': 'jy/layout/${componentVersion.layout}/post',
                'jquery': 'gallery/jquery/${componentVersion.jquery}/jquery',
                'base': 'jy/base/${componentVersion.base}/base.js',
                'page-index': 'jy/page-index/1.0.4/page-index',
                'page-search': 'jy/page-search/1.0.2/search',
                'content-list': 'jy/content-list/1.0.4/content-list',
                'jquery.easing': 'jquery-plugins/jquery.easing/${componentVersion.jquery_easing}/jquery.easing'
            }
        </#if>
      });
    </script>
    <script src="${static('js/jy/sea-modules/gallery/jquery/${componentVersion.jquery}/jquery.js')}"></script>
    <script src="${static('js/jy/sea-modules/jquery-plugins/jquery.cookie/${componentVersion.jquery_cookie}/jquery.cookie.js')}"></script>
    <script src="${static('js/jy/sea-modules/jy/base/${componentVersion.base}/base.js')}"></script>
    <script>
        Modernizr.load([
            {
                test: Modernizr.input.placeholder,
                both: "${static('js/jy/sea-modules/patches/placeholder/0.0.1/placeholder.js')}",
                callback: function() { seajs.use('patches/placeholder/0.0.1/placeholder'); }
            },

            {
                test: Modernizr.localstorage,
                nope: "${static('js/jy/patches/localstorage/localstorage.min.js')}",
                complete: function() { <#nested> }
            }
        ]);
    </script>
</#macro>


<#macro subscribeBtnDefault source>
  <div class="m-subscribe-btn-default m-subscribe-btn" data-id="${source.sourceUuid}" data-pseudo="hover">
    <div class="<#if source.curUserSubscribed != 1>subscribe<#else>subscribed</#if>">
      <a href="javascript:void(0)" class="btn subscribe-btn"><span class="btn-content"><span class="icon icon-add"></span>添加订阅</span></a>
      <a href="javascript:void(0)" class="btn subscribed-btn"><span class="btn-content"><span class="icon icon-right"></span>已订阅</span></a>
      <a href="javascript:void(0)" class="btn cancel-btn"><span class="btn-content"><span class="icon icon-minus"></span>取消订阅</span></a>
    </div>
  </div>
</#macro>
