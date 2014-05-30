<#ftl strip_text=true>

<#include "config.ftl" />

<#function getSliderDivCount _count _size>
	<#assign sliderCount = ((_count - 1)/_size)?int + 1 />
	<#return sliderCount>
</#function>

<#function getBookBuyUnit bookType>
	<#if bookType == 5>
		<#return '话'>
	<#else>
		<#return '章节'>
	</#if>
</#function>

<#function ifEmpty variable replacementIfEmpty>
	<#if variable != "">
		<#return variable>
	<#else>
		<#return replacementIfEmpty>
	</#if>
</#function>

<#function ellipsis text length>
	<#if text?length lte length>
		<#return text>
	<#else>
		<#return text?substring(0,length) + "...">
	</#if>
</#function>

<#function getMarkNameLimit markName defaultName length>
	<#assign name = getMarkName(markName, defaultName)>
	<#return ellipsis(name, length)!?html>
</#function>

<#function getMarkName markName defaultName>
	<#return ifEmpty(markName, defaultName)!?html>
</#function>

<#function join separator texts...>
	<#assign result = ''>
	<#list texts as text>
		<#if text != ''>
			<#if result != ''>
				<#assign result = result + separator>
			</#if>
			<#assign result = result + text>
		</#if>
	</#list>
	<#return result>
</#function>

<#function compactNumber number>
	<#if number gt 9999>
		<#return (number/10000)?string("0") + "<span>万</span>">
	<#else>
		<#return number?string>
	</#if>
</#function>

<#-- 根据内容中心标签获取页面标题、关键字、描述-->
<#function getFirstLevelSEOTitle tab>
	<#return getFirstLevelSEO(tab).title>
</#function>

<#function getFirstLevelSEOKeywords tab>
	<#return getFirstLevelSEO(tab).keywords>
</#function>

<#function getFirstLevelSEODescription tab>
	<#return getFirstLevelSEO(tab).description>
</#function>


<#-- 根据二级分类的标题获取内容中心页面的页面标题、关键字、描述-->
<#function getSecondLevelSEOTitle tab CategoryTitle>
	<#return getSecondLevelSEO(tab, CategoryTitle).title>
</#function>

<#function getSecondLevelSEOKeywords tab CategoryTitle>
	<#return getSecondLevelSEO(tab, CategoryTitle).keywords>
</#function>

<#function getSecondLevelSEODescription tab CategoryTitle>
	<#return getSecondLevelSEO(tab, CategoryTitle).description>
</#function>


<#macro show _url _totalCount _curPage _pageSize _color='red'>
	<#assign totalPage = ((_totalCount - 1) / _pageSize)?int + 1 />
	
	<#-- 只有一页不显示分页 -->
	<#if (totalPage lte 1)>
		<#return>
	</#if>
	<#if totalPage gt 100>
		<#assign totalPage = 100 />
	</#if>
	
	<#assign showCount = 5 />
	
	<#assign intervalCount = (showCount - 1)/2 />
	
	<#assign s = _curPage - intervalCount />
	<#if s lt 1>
		<#assign s = 1/>
	</#if>

	<#assign e = _curPage + intervalCount />
	<#if e gt totalPage>
		<#assign e = totalPage/>
	</#if>

	<#if _curPage lte intervalCount>
		<#assign e = totalPage/>
		<#if e gt showCount>
			<#assign e = showCount/>
		</#if>
	</#if>

	<#assign rear = totalPage - _curPage/>
	<#if rear lt intervalCount>
		<#assign s = _curPage + rear + 1 - showCount/>
		<#if s lt 1>
			<#assign s = 1/>
		</#if>
	</#if>
	
	<div class="m-page <#if _color == 'green'>m-page-g<#elseif _color == 'blue'>m-page-b<#elseif _color == 'pink'>m-page-p<#elseif _color == 'orange'>m-page-o<#else>m-page-d</#if>">
		<#if _curPage gt 1>
			<a href="${_url}/p${_curPage-1}/s${_pageSize}" class="go go-p">上一页</a>
			<#if s gt 1>
				<span class="nums">
					<a href="${_url}/p1/s${_pageSize}">1</a>					
				</span>		
				<#if s gt 2>
					<span class="dian">...</span>
				</#if>
			</#if>
		</#if>
		<span class="nums">
			<#list s..e as i>
				<a href="${_url}/p${i}/s${_pageSize}" <#if _curPage == i>class="j-crt"</#if>>${i}</a>
			</#list>
		</span>
		<#if _curPage!=totalPage>
			<#if e lt totalPage>
				<#if e lt totalPage - 1>
					<span class="dian">...</span>
				</#if>
				<span class="nums">
					<a href="${_url}/p${totalPage}/s${_pageSize}">${totalPage}</a>
				</span>
			</#if>
			<a href="${_url}/p${_curPage+1}/s${_pageSize}" class="go go-n">下一页</a>
		</#if>
	</div>
</#macro>

<#macro pageControl _totalPage _curPage _compact=false _color='red'>
	<#assign totalPage = _totalPage>

	<#-- 只有一页不显示分页 -->
	<#if totalPage lte 1>
		<#return>
	</#if>
	<#if totalPage gt 100>
		<#assign totalPage = 100 />
	</#if>

	<#assign showCount = 5 />
	<#if _compact>
		<#assign showCount = 3 />
	</#if>
	
	<#assign intervalCount = (showCount - 1)/2 />

	<#assign s = _curPage - intervalCount />
	<#if s lt 1>
		<#assign s = 1 />
	</#if>

	<#assign e = _curPage + intervalCount />
	<#if e gt totalPage>
		<#assign e = totalPage/>
	</#if>

	<#if _curPage lte intervalCount>
		<#assign e = totalPage/>
		<#if e gt showCount>
			<#assign e = showCount/>
		</#if>
	</#if>

	<#assign rear = totalPage - _curPage/>
	<#if rear lt intervalCount>
		<#assign s = _curPage + rear + 1 - showCount/>
		<#if s lt 1>
			<#assign s = 1/>
		</#if>
	</#if>

	<div class="<#if _compact>m-page-1<#else>m-page</#if> <#if _color == 'green'>m-page-g<#elseif _color == 'blue'>m-page-b<#elseif _color == 'pink'>m-page-p<#elseif _color == 'orange'>m-page-o<#else>m-page-d</#if>">
		<#if _curPage gt 1>
			<a href="<#nested (_curPage - 1)>" class="go go-p">上一页</a>
			<#if !_compact && s gt 1>
				<span class="nums">
					<a href="<#nested 1>">1</a>					
				</span>
				<#if s gt 2>
					<span class="dian">...</span>
				</#if>
			</#if>
		</#if>
		<span class="nums">
			<#list s..e as i>
				<a href="<#nested i>" <#if _curPage == i>class="j-crt"</#if>>${i}</a>
			</#list>
		</span>
		<#if _curPage != totalPage>
			<#if !_compact && e lt totalPage>
				<#if e lt totalPage - 1>
					<span class="dian">...</span>
				</#if>
				<span class="nums">
					<a href="<#nested totalPage>">${totalPage}</a>
				</span>
			</#if>
			<a href="<#nested (_curPage+1)>" class="go go-n">下一页</a>
		</#if>
	</div>
</#macro>
