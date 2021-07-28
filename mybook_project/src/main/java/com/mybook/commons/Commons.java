package com.mybook.commons;

import java.util.HashMap;


public class Commons {
		
	
		// ����¡ ó�� �޼ҵ� - startCount, endCount
		public HashMap<String, Integer> getPage(String rpage, Object obj, String name) {			
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			
			//����¡ ó�� - startCount, endCount ���ϱ�
			int startCount = 0;
			int endCount = 0;
			int pageSize = 15;	//���������� �Խù� ��
			int reqPage = 1;	//��û������	
			int pageCount = 1;	//��ü ������ ��
			int dbCount = 0;	//DB���� ������ ��ü ���
			
			/*
			 * if (name.equals("Community")) { CommunityService communityService =
			 * (CommunityService)obj; dbCount = communityService.getFreeTotalCount(); }
			 */
			
			//�� ������ �� ���
			if(dbCount % pageSize == 0){
				pageCount = dbCount/pageSize;
			} else {
				pageCount = dbCount/pageSize+1;
			}
			
			//��û ������ ���
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
