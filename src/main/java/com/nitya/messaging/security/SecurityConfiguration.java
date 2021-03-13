package com.nitya.messaging.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder; 
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher; 

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
 
	@Autowired
	private DataSource dataSource;
	  @Autowired
	    PasswordEncoder passwordEncoder;
	 
	    @Override
	    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
	        auth.jdbcAuthentication()
            .dataSource(dataSource)
            .passwordEncoder(passwordEncoder())
            .authoritiesByUsernameQuery("SELECT username,role as authority FROM user_role where username=?")
            .usersByUsernameQuery("SELECT username,password,enabled FROM users where username=?");
	    }
	 
	    @Bean
	    public PasswordEncoder passwordEncoder() {
	        return new BCryptPasswordEncoder();
	    }
	 
	    @Override
	    protected void configure(HttpSecurity http) throws Exception {
			  http .csrf().disable() .httpBasic().and() .authorizeRequests()
			  .antMatchers("/**").permitAll() .anyRequest().authenticated() .and()
			  .formLogin() .loginPage("/login").failureUrl("/login?error=true")
			  .defaultSuccessUrl("/contacts") .usernameParameter("username")
			  .passwordParameter("password") .and().logout() .logoutRequestMatcher(new
			  AntPathRequestMatcher("/logout"))
			  .logoutSuccessUrl("/login?logout=true").and().exceptionHandling()
			  .accessDeniedPage("/accessdenied");
	    }
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}
}
