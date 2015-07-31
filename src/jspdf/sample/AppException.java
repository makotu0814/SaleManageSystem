package jspdf.sample;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;

/**
 * Servlet implementation class AppException
 */
@WebServlet("/AppException")
public class AppException extends ServletException implements Servlet {
       
    /**
     * @see ServletException#ServletException()
     */
    public AppException() {
        super();
        // TODO Auto-generated constructor stub
    }
       
    /**
     * @see ServletException#ServletException(String)
     */
    public AppException(String message) {
        super(message);
        // TODO Auto-generated constructor stub
    }
       
    /**
     * @see ServletException#ServletException(String, Throwable)
     */
    public AppException(String message, Throwable rootCause) {
        super(message, rootCause);
        // TODO Auto-generated constructor stub
    }
       
    /**
     * @see ServletException#ServletException(Throwable)
     */
    public AppException(Throwable rootCause) {
        super(rootCause);
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Servlet#getServletConfig()
	 */
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see Servlet#getServletInfo()
	 */
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null; 
	}

	/**
	 * @see Servlet#service(ServletRequest request, ServletResponse response)
	 */
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
