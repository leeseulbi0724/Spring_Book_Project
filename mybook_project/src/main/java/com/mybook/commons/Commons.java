package com.mybook.commons;

import java.util.HashMap;


public class Commons {
		
	
		// 페이징 처리 메소드 - startCount, endCount
		public HashMap<String, Integer> getPage(String rpage, Object obj, String name) {			
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			
			//페이징 처리 - startCount, endCount 구하기
			int startCount = 0;
			int endCount = 0;
			int pageSize = 15;	//한페이지당 게시물 수
			int reqPage = 1;	//요청페이지	
			int pageCount = 1;	//전체 페이지 수
			int dbCount = 0;	//DB에서 가져온 전체 행수
			
			/*
			 * if (name.equals("Community")) { CommunityService communityService =
			 * (CommunityService)obj; dbCount = communityService.getFreeTotalCount(); }
			 */
			
			//총 페이지 수 계산
			if(dbCount % pageSize == 0){
				pageCount = dbCount/pageSize;
			} else {
				pageCount = dbCount/pageSize+1;
			}
			
			//요청 페이지 계산
			if(rpage != null){
				reqPage = Integer.parseInt(rpage);
				startCount = (reqPage-1) * pageSize+1;
				endCount = reqPage *pageSize;
			} else {
				startCount = 1;
				endCount = 5;
			}
			
			map.put("start", startCount);
			map.put("end", endCount);
			map.put("dbCount", dbCount);
			map.put("pageSize", pageSize);
			map.put("rpage", reqPage);
			
			return map;
		}
}
