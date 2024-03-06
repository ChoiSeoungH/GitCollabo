package com.basic.team.controller.frontController;

public class ViewResolver {
	public static String makeView(String nextPage) {
		return "/WEB-INF/"+nextPage+".jsp";
	}
}
