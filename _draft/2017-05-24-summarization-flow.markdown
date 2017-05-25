---
layout: post
title:  "summarization flow"
subtitle:   "summarization flow"
categories:  til summarization 
---

요약 API

ㅇ흐름

{

    셀레니움으로 URL브라우징(url);

    본문찾기(url);

    쓸모없는태그제거(html);

    요약(본문);
   

}

ㅇ함수

셀레니움으로 URL브라우징(url);
return html;

본문찾기(url);
return div class| name | id;

쓸모없는태그제거(html);
return 본문;

요약(본문);
return 요약;


ㅇ요구사항

1. 동적 페이지도 요약할 수 있다.( 셀레니움 사용 )

2. url만 있으면 요약할 수 있다.

3. 반환값은 타이틀, 대표이미지, 요약내용, description


ㅇ참고자료

요약 알고리즘

현재 사용하는 js 라이브러리 - https://github.com/linanqiu/lexrank 

파이썬 라이브러리 - https://github.com/theeluwin/lexrankr


셀레니움 

셀레니움 - https://beomi.github.io/2017/02/27/HowToMakeWebCrawler-With-Selenium/


API

list/:site/:section
ex) list/brunch/IT

output

{
    0: {
        title : 'title0',
        summarized : 'contents0',
        origin : 'linkUrl0'
    },
    
    1: {
        title : 'title1',
        summarized : 'contents1',
        origin : 'linkUrl1'
    }

}

