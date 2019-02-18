package com.backbase.sample.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles security events such as Login Success, Login Failure, Access Denied, Logout Result. It either sends a HTTP
 * 204 back for success cases, or a 403 for failure cases.
 */
public class ServicesSecurityResultHandler implements AuthenticationSuccessHandler, AuthenticationFailureHandler,
		AccessDeniedHandler, LogoutSuccessHandler {

	private static final Logger LOG = LoggerFactory.getLogger(ServicesSecurityResultHandler.class);

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
										Authentication authentication) {
		handleSuccess(request, response);
	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
										AuthenticationException exception) throws IOException {
		handleFailure(response, "Invalid Username/Password");
	}

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		handleSuccess(request, response);
	}

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
					   AccessDeniedException accessDeniedException) throws IOException {
		handleFailure(response, "Nothing to see here");
	}

	private void handleSuccess(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	}

	private void handleFailure(HttpServletResponse response, String message) throws IOException {
		response.sendError(HttpServletResponse.SC_FORBIDDEN, message);
	}
}
