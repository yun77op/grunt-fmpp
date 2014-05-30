<#include "brief_common.ftl"/>
<@page _pageName="searchResult" _pageDesc="searchResult" _pageTitle="searchResult" _pageKeywords="searchResult">
	<div id="container">
	  <div class="clearfix page-header">
      <a id="global-return-btn" class="pull-left btn" href="/brief/contentcenter"><span class="btn-content">&lt;&lt; 返回</span></a>
      <div class="pull-right search-container">
        <#include "partials/brief_search_form.ftl">
      </div>
	  </div>
	<div class="page-content search-result-content">
	<#if sourcePager.contentCount gt 0 || rssNodes?exists && rssNodes?size gt 0>
			 <#if sourcePager.contentCount gt 0>
          <h2 class="search-title">以下 ${sourcePager.contentCount} 项符合<em class="keyword">${(key?html)!}</em>的订阅源，来自网易云阅读的内容中心</h2>
          <div class="clearfix subscription-container">
            <#list sourcePager.content as source>
				     <div class="subscription">
					     <div class="content">
							  <a href="/brief/contentList/${source.sourceUuid}/${(source.title?html)!}" title="${(source.title)!?html}">
								  <img src="${ifEmpty((source.iconUrl)!, briefDefaultImg)}" width="100" height="100">
								  <h3 class="subscription-title ellipsis">${HighlightUtil.highlight(source.title?html!, key?html!, '<em class="keyword">', '</em>')}</h3>
							  </a>
						    <small class="metadata">${source.subscribeCount?default(0)}人订阅</small>
					      </div>
					      <div class="ft btns">
			            <@subscribeBtnDefault source />
					      </div>
				      </div>
            </#list>
          </div>

          <#if rssNodes?? == false || rssNodes?size == 0>
            <@searchResultPageControl _pager=sourcePager; _pageNo>
              /briefSearch.do?key=${key?url}&curSourcePage=${_pageNo}&lastSourcePage=${sourcePager.pageCount}
            </@searchResultPageControl>
          </#if>
       </#if>

       <#if sourcePager.contentCount gt 0 && rssNodes?exists && rssNodes?size gt 0>
          <hr class="search-result-separator">
       </#if>

       <#if rssNodes?exists && rssNodes?size gt 0>
        <h2 class="search-title search-rss-title">以下符合<em class="keyword">${(key?html)!}</em>的订阅源，来自互联网</h2>
        <div>
  				<ul>
  				<#list rssNodes as rssNode>
  					<li class="subscription-outside">
  						<h3 class="title">${HighlightUtil.highlight(rssNode.title?html!, key?html!, '<em class="keyword">', '</em>')}</h3>
  						<div class="body">${HighlightUtil.highlight(rssNode.content?html!, key?html!, '<em class="keyword">', '</em>')}
                <#if rssNode.customNode>
                  <a target="_blank" href="${rssNode.customizationId?default('javascript:void 0;')}">${rssNode.customizationId?default('')}</a>
                <#else>
                  <a target="_blank" href="/source/${rssNode.id}">${baseUrl}/source/${rssNode.id}</a>
                </#if>
  						</div>
  						<div class="footer">
  							<div class="m-subscribe-btn m-subscribe-btn-default" data-id="${rssNode.id}">
                  <div class="<#if rssNode.curUserSubscribed != 1>subscribe<#else>subscribed</#if>">
  		              <a href="javascript:void(0)" class="btn-mini btn subscribe-btn"><span class="btn-content"><span class="icon icon-add"></span>订阅</span></a>
  		              <a href="javascript:void(0)" class="btn-mini btn subscribed-btn"><span class="btn-content"><span class="icon icon-right"></span>已订阅</span></a>
  		              <a href="javascript:void(0)" class="btn-mini btn cancel-btn"><span class="btn-content"><span class="icon icon-minus"></span>取消订阅</span></a>
                  </div>
  				      </div>
              </div>
            </li>
          </#list>
          </ul>
        </div>

        <#assign curSourcePage=sourcePager.currentPage/>
        <#assign lastSourcePage=sourcePager.pageCount/>
        <div class="pagination pagination-centered">
			    <ul>
            <li>
              <a
		            <#if sourcePager.firstPage == false || (curRssPage!0) gt 1>
	                href="
	                <#if sourcePager.firstPage == false && (curRssPage!0) == 1>
	                    /briefSearch.do?key=${key?url}&curSourcePage=${curSourcePage-1}&lastSourcePage=${lastSourcePage}
					        <#else>
					            /briefSearch.do?key=${key?url}&curRssPage=${curRssPage - 1}&curSourcePage=${curSourcePage}&lastSourcePage=${lastSourcePage}
			            </#if>"
			          <#else>class="disabled" href="javascript:;"
			          </#if>>&lt;
				       </a>
				    </li>
				
          <#if curRssPage+curSourcePage-1 gt 0>
            <li><a class="active" href="javascript:;">${curRssPage+curSourcePage-1}</a></li>
          </#if>

            <li>
              <a
					    <#if hasNextRssPage>
					        href="/briefSearch.do?key=${key?url}&curRssPage=${curRssPage + 1}&curSourcePage=${curSourcePage}&lastSourcePage=${lastSourcePage}"
              <#else>
                  class="disabled" href="javascript:;"
					    </#if>
					    >&gt;</a>
					  </li>

			    </ul>
        </div>
		  </#if>
	 <#else>
    <div class="no-result">
      <div class="alert search-title">很抱歉没有找到与<em class="keyword">${(key?html)!}</em>相关的内容源，建议您尝试其他关键字，或直接通过分类检索
      </div>
    </div>
	 </#if>
	</div>
	</div>

    <@footerScript>
        seajs.use(['base', 'page-search']);
    </@footerScript>
    <!--[if IE 6]>
        <script> DD_belatedPNG.fix('.icon'); </script>
    <![endif]-->
</@page>
