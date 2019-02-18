package com.backbase.sample.security;

import com.backbase.portal.foundation.business.service.GroupBusinessService;
import com.backbase.portal.foundation.commons.exceptions.ItemNotFoundException;
import com.backbase.portal.foundation.domain.model.ExternalUser;
import com.backbase.portal.foundation.domain.model.Group;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

import java.util.Collections;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	private static final String DEFAULT_GROUP_NAME = "user";

	private static final Logger LOG = LoggerFactory.getLogger(CustomAuthenticationProvider.class);

	@Autowired
	private GroupBusinessService groupService;

	@Override
	public Authentication authenticate(Authentication authentication) {
		if (!(authentication instanceof UsernamePasswordAuthenticationToken)) {
			throw new IllegalArgumentException("This provider does not support " + authentication.getClass()
					+ ". Expecting instances of UsernamePasswordAuthenticationToken");
		}
		UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) authentication;

		// here you can call any external service to authentication
		ExternalUser user = createUser(userToken);
		UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user, null,
				user.getAuthorities());
		result.setDetails(userToken.getDetails());

		LOG.debug("{} logged in.", user.getUsername());

		return result;
	}

	private ExternalUser createUser(UsernamePasswordAuthenticationToken userToken) {
		ExternalUser user = new ExternalUser();
		user.setEnabled(true);
		user.setUsername(userToken.getName());
		try {
			Group userGroup = groupService.getGroup(DEFAULT_GROUP_NAME);
			user.setGroups(Collections.singletonList(userGroup));
		} catch (ItemNotFoundException e) {
			// This should never happen
			throw new AuthenticationServiceException("Could not find defaul group: " + DEFAULT_GROUP_NAME, e);
		}
		return user;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

}
