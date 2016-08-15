package com.llb.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;

/**
 * Servlet Filter implementation class CharacterEncodingFilter
 */
@WebFilter(
		urlPatterns = { 
				"/work/contactsList.jsp", 
				"/*"
		}, 
		initParams = { 
				@WebInitParam(name = "enabled", value = "true"), 
				@WebInitParam(name = "characterEncoding", value = "UTF-8")
		})
public class CharacterEncodingFilter implements Filter {

	private String characterEncodingString;
	private boolean enabled;
	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		characterEncodingString=fConfig.getInitParameter("characterEncoding");
		enabled="true".equalsIgnoreCase(fConfig.getInitParameter("enabled").trim());
	}
	



	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		if(enabled||characterEncodingString!=null)
		{
			request.setCharacterEncoding(characterEncodingString);
			response.setCharacterEncoding(characterEncodingString);
		}

		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	

}
