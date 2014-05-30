<#include "brief_common.ftl"/>
<@page _pageName= "briefindex" _pageDesc="index" _pageTitle="index" _pageKeywords="index">
    <div class="feeds">
        <div class="feeds-header">
          <a href="/brief/myfavorite" class="fav-link"><span class="icon icon-fav-on"></span>我的收藏</a>
          <h2 class="feeds-title">我的订阅</h2>
        </div>
        <div class="clearfix feeds-body">
        <#if latestPicSources?exists && latestPicSources?size gt 0>
        <#list latestPicSources as subSource>
          <#if briefUnsupportSources?seq_contains(subSource.sourceUuid) == false>
          <a class="feed" title="${subSource.sourceTitle?html}" href="/briefContentList.do?sourceUuid=${subSource.sourceUuid}">
            <div class="feed-header">
              <div class="feed-header-mask"></div> 
              <h3 class="feed-title ellipsis">${subSource.sourceTitle?html}</h3></div>
            <img width="160" height="151" src="${static('images/common/blank.gif')}" data-src="<#if subSource.latestArticlePic?exists>${subSource.latestArticlePic}?param=160y151&axis=5<#else>/images/common/sourceDefaultImg.png</#if>">
            <div class="feed-mask stretch-full"></div>
          </a>
          </#if>
        </#list>
        </#if>
          <a href="/brief/contentcenter" class="feed-add hide-text">add</a>
        </div>
    </div>
    <div class="recomments sidebar">
        <h2 class="recomments-title">推荐阅读</h2>
        <#if recommendLatestArticles?exists && recommendLatestArticles?size gt 0>
            <div class="content">
        	<#if recommendLatestArticles?size gt 0>
        		<#assign article=recommendLatestArticles[0]>
        		<#if article.summary??>
    			<a title="${article.title?html}" class="recomment recomment-primary" href="/briefContentList.do?sourceUuid=${article.sourceUuid}&isRecommend=1&articleUuid=${article.articleUuid}">
                      <img src="${article.summaryImage}?param=250y150&axis=5">
                      <div class="recomment-primary-header clearfix">
                        <h3 class="recomment-primary-title ellipsis">
                        	${(ellipsis(article.title, 22))!?html}
                        </h3>
                      </div>
                      <p class="summery"><#if article.summary?length lt 31>${article.summary?html}<#else>${article.summary?substring(0,31)?html}</#if><span class="icon-comma-right icon"></span></p>
                 </a>
        		<#else>
        		<a title="${article.title?html}" class="recomment recomment-primary" href="/briefContentList.do?sourceUuid=${article.sourceUuid}&isRecommend=1&articleUuid=${article.articleUuid}">
                      <img src="${article.summaryImage}?param=250y150&axis=5">
                      <div class="recomment-primary-header clearfix">
                        <h3 class="recomment-primary-title ellipsis">
                        	${(ellipsis(article.title, 22))!?html}
                     	   <span class="icon-comma-right icon"></span>
                        </h3>
                      </div>
                 </a>
        		</#if>
        	</#if>
        	<#if recommendLatestArticles?size gt 1>
        		<div class="clearfix">
		        	<#list recommendLatestArticles[1..] as article>
	        		<a title="${article.title}" class="recomment recomment-secondery <#if article_index == 0>recomment-secondery-first</#if>" href="/briefContentList.do?sourceUuid=${article.sourceUuid}&isRecommend=1&articleUuid=${article.articleUuid}">
                      	<img src="${article.summaryImage}?param=<#if article_index == 0>130y150<#else>110y124</#if>&axis=5">
                     	<h3 class="ellipsis">${article.title?html}</h3>
                    	<#if article.summary??><p class="summery"><#if article.summary?length lt 17>${article.summary?html}<#else>${article.summary?substring(0,17)?html}</#if></p></#if>
                     </a>
		        	</#list>
        		</div>
        	</#if>
      	 </#if>
	    	  <hr class="hr-dashed">
	          <div class="promotes">
	            <a href="${officialServer}/client?act=rdjymail_20130106_01" target="_blank">
	              <img src="${static('images/jy/promotes/yuedu.jpg')}">
	            </a>
	          </div>
      </div>
    </div>
  <@footerScript>
    seajs.use(['base', 'page-index']);
  </@footerScript>
</@page>
