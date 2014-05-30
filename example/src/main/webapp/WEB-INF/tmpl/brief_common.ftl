<#include "template_common.ftl">
<#include "brief_function.ftl">

<#macro page _pageName="" _pageDesc="" _pageTitle="" _pageKeywords="">
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="lt-ie9 lt-ie8 lt-ie7 page-${_pageName}"> <![endif]-->
<!--[if IE 7]>         <html class="lt-ie9 lt-ie8 page-${_pageName}"> <![endif]-->
<!--[if IE 8]>         <html class="lt-ie9 page-${_pageName}"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="page-${_pageName?html}">         <!--<![endif]-->
	<head>
    <meta charset="utf-8"/>
	<title>vvv</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" href="/favicon.ico?V2">
    <meta name="robots" content="index,follow">
    <meta name="robots" content="noodp">
    <link href="${static('css/jy/base.css')}" rel="stylesheet" />
    <link href="${static('css/jy/yuedu.css', officialServer)}" rel="stylesheet" />
    <link id="theme-active" href="<#if skin??>${static('css/jy/themes/${skin}/${skin}-yd.css')}<#else>${skinUrl!?html}</#if>" rel="stylesheet" />
    <script src="${static('js/jy/components/modernizr/modernizr.custom.08239.js')}"></script>
    <!--[if IE 6]>
      <script src="${static('js/jy/components/DD_belatedPNG/0.0.8a/DD_belatedPNG-min.js')}"></script>
    <![endif]-->
    <!--[if (gte IE 6)&(lte IE 8)]>
      <script src="${static('js/jy/components/respond/respond.min.js')}"></script>
    <![endif]-->
	</head>
	<body>
		<noscript><a href="#">请使用支持脚本的浏览器！</a></noscript>
		<div class="g-doc">
			<#nested />
		</div>
	</body>
</html>
</#macro>


<#macro briefPager _pager _compact=false>
  <ul>
    <#assign curPage=_pager.currentPage/>
    <#assign pageCount=_pager.pageCount/>
    <#assign s=_pager.startPage/>
    <#assign e=_pager.endPage/>
    
    <li><a <#if _pager.firstPage == true>class="disabled" href="javascript:;"<#else>href="<#nested (curPage - 1)>"</#if>>&lt;</a></li>
    
    <#if _pager.startDotLine == true>
      <#if !_compact>
       <li><a href="<#nested 1>">1</a></li>
      </#if>
       <li class="text"><span>...</span></li>
    </#if>
  
    <#list s..e as i>
      <li><a <#if curPage == i>class="active" href="javascript:;"<#else>href="<#nested i>"</#if>>${i}</a></li>
    </#list>
  
    <#if _pager.endDotLine == true>
     <li class="text"><span>...</span></li>
      <#if !_compact>
        <li><a href="<#nested pageCount>">${pageCount}</a></li>
      </#if>
    </#if>
    
     <li><a <#if _pager.lastPage == true>class="disabled" href="javascript:;"<#else>href="<#nested (curPage + 1)>"</#if>>&gt;</a></li>
  </ul>
</#macro>

<#macro sourceItem _source _from _openInNewWindow=false _tab="" _level2Uuid="" _noLi=false>
	<#if !_noLi>
		<li>
	</#if>
		<#assign sourceUrl = "/briefContentList.do?sourceUuid=${_source.sourceUuid}">
		 <div class="subscription">
			<div class="content">
			    <a href="${sourceUrl}" style="display:block;" title="${(_source.title)!?html}" <#if _openInNewWindow>target="_blank"</#if>><img src="${ifEmpty((_source.iconUrl)!, briefDefaultImg)}" width="100" height="100" alt="${(_source.title)!?html}" />
				<h3 class="subscription-title ellipsis">${(_source.title?html)!}</h3>
			    </a>
				<small class="metadata">${_source.subscribeCount?default(0)}人订阅</small>
			</div>
			
			<div class="ft btns">
			  <@subscribeBtnDefault _source />
			</div>
		</div>
	<#if !_noLi>
		</li>
	</#if>
</#macro>

<#macro searchResultPageControl _pager>
    <#assign curPage=_pager.currentPage/>
    <#assign s=_pager.spanStartPage/>
    <#assign e=_pager.spanEndPage/>
    <div class="pagination pagination-centered">
      <ul>
        <li>
            <a <#if _pager.firstPage == true>class="disabled" href="javascript:;"<#else>href="<#nested (curPage - 1)>"</#if>>&lt;</a>
        </li>
        <#list s..e as i>
            <li><a <#if curPage == i>class="active" href="javascript:;"<#else>href="<#nested i>"</#if>>${i}</a></li>
        </#list>
        <li>
            <a <#if _pager.lastPage == true>class="disabled" href="javascript:;"<#else>href="<#nested (curPage+1)>"</#if>>&gt;</a>
        </li>
      </ul>
    </div>
</#macro>

<#macro searchResult _source _from _openInNewWindow=false _tab="">
		<#assign sourceUrl = "/source/${_source.sourceUuid}">
		<#if _tab != ''>
			<#assign sourceUrl = "${sourceUrl}/${_tab?url}">
		</#if>
		<div class="m-inf">
			<div class="w-img"><a href="${sourceUrl}" style="display:block;" title="预览 ${(_source.title)!?html}" <#if _openInNewWindow>target="_blank"</#if>><img src="${ifEmpty((_source.iconUrl)!, briefDefaultImg)}" alt="预览 ${(_source.title)!?html}" /></a></div>
			<div class="txt">
				<h4><a href="${sourceUrl}" title="${(_source.title?html)!}" <#if _openInNewWindow>target="_blank"</#if>>${(_source.title?html)!}</a></h4>
				<div class="w-star w-star1 w-star11">
				<#list 1..5 as i>
					<#if _source.star gte i>
						<span>&nbsp;</span>
					<#else>
						<span class="no">&nbsp;</span>
					</#if>
				</#list>
				</div>
				<div class="has"><span>${_source.subscribeCount?default(0)}</span>人订阅</div>
				
				<#if _from=="mysubs">
					<a href="#" class="unsub"></a>
					<input type="hidden" value="${_source.sourceUuid}" />
					<input type="hidden" value="${_source.title?html}" />
					<input type="hidden" value="${_source.star}" />
					<input type="hidden" value="${_source.updateFrequency?default(0)}" />
					<input type="hidden" value="${ifEmpty((_source.iconUrl)!, briefDefaultImg)}" />
					<input type="hidden" value="${_from}" />
				<#else>
					<div class="ding">
						<#if _source.curUserSubscribed != 1>
							<a href="javascript:void(0)" class="w-ding">订阅</a>
						<#else>
							<a href="javascript:void(0)" class="w-ding w-ding-has">已经订阅</a>
						</#if>
						<input type="hidden" value="${_source.sourceUuid}" />
						<input type="hidden" value="${_source.title?html}" />
						<input type="hidden" value="${_source.star}" />
						<input type="hidden" value="${_source.updateFrequency?default(0)}" />
						<input type="hidden" value="${ifEmpty((_source.iconUrl)!, briefDefaultImg)}" />
						<input type="hidden" value="${_from}" />
					</div>
					<a class="pv" href="${sourceUrl}">预览</a>
				</#if>
			</div>
		</div>
</#macro>


<#macro navPopup _category>
	<#if _category.title != "本地资讯">
	<li class="ui-enabled dropdown nav-category-hasSub <#if _category.selected == true>active</#if>">
        <div class="popup dropdown-popup" id="category-popup">
            <span class="caret-top"></span>
            <ul class="clearfix popup-body unstyled">
            <#list _category.childCategories as category>
            	<#if briefCategory?seq_contains(category.title)>
            		<#if category.selected == true>
                  <#assign activeCategory = category>
            		</#if>
                 <li class="<#if category.selected == true>active</#if>"><a href="/brief/contentcenter/${category.briefNavItemUrlSuffix!}">${category.title?html}</a></li>
            	</#if>
            </#list>
            </ul>
        </div>
		<a href="#" data-toggle="dropdown" class="dropdown-toggle nav-item nav-category">
            <span class="plain-text">
         		${_category.title?html}<#if activeCategory??>-${activeCategory.title?html}</#if>
            </span>
            <span class="caret"></span>
		</a>
	</li>
	<#else>
	<li class="ui-enabled nav-city-container dropdown <#if _category.selected == true>active</#if>">
    <div class="popup dropdown-popup" id="city-popup">
        <span class="caret-top"></span>
        <div class="popup-body">
            <ul class="clearfix hot unstyled">
                    <#list _category.childCategories as category>
                      <#if category.selected == true>
                        <#assign activeCategory = category>
                      </#if>
                      <#if hotCities?seq_contains(category.title)>
                        <li><a href="/brief/contentcenter/${category.briefNavItemUrlSuffix!}">${category.title?html}</a></li>
                      </#if>
                    </#list>
            </ul>
            <ul class="clearfix unstyled">
                  <#list _category.childCategories as category1>
                    <li <#if category1.selected = true>class="active"</#if>><a href="/brief/contentcenter/${category1.briefNavItemUrlSuffix!}">${category1.title?html}</a></li>
                  </#list>
            </ul>
        </div>
    </div>
    <a href="#" data-toggle="dropdown" class="dropdown-toggle nav-item nav-city active">
        <span class="plain-text"><#if activeCategory?exists>${activeCategory.title?html}<#else>城市</#if></span>
        <span class="caret"></span>
    </a>
	</li>
	</#if>
</#macro>
<#macro navCateItem _category>
	<@navPopup _category/>
	<#if (_category.childCategories)?? &&  _category.childCategories?size gt 0>
		<#list _category.childCategories as __category>
			<#if __category.selected == true && (__category.childCategories)?? &&  __category.childCategories?size gt 0>
				<@navCateItem __category/>
				<#break>
			</#if>
		</#list>
	</#if>
</#macro>
<#macro navBar _categoryRoot>
  <div class="clearfix page-header subscription-header">
    <a id="global-return-btn" class="pull-left btn" href="/brief/index"><span class="btn-content">&lt;&lt; 返回</span></a>
    <div class="pull-right search-container">
			<#include "partials/brief_search_form.ftl">
    </div>
     <ul class="subscription-nav">
      <#list _categoryRoot.childCategories as category>
        <#if (category.childCategories)?? &&  category.childCategories?size gt 0>
          <@navCateItem category/>
        <#else>
          <li class="<#if category.selected == true >active</#if><#if category_index == 0> first</#if>">
              <a class="nav-item" href="/brief/contentcenter/${category.briefNavItemUrlSuffix}">${category.title?html}</a>
          </li>
        </#if>
      </#list>
   </ul>
  </div>
</#macro>
