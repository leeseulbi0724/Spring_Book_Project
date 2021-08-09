package com.mybook.service;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service("SendEmailService")
public class SendEmailServiceImpl implements SendEmailService {	
	
	public void sendEmail(String email, String number) throws Exception {
		
		String host = "smtp.naver.com";
		final String username = "tmfql4428";
		final String password = "dlwjdghks0320";
		int port = 465;
		
		String tomail = email; // 받는 사람 이메일
		String title = "[ LAON ] 이메일 인증번호";
		String content = " 인증번호 [ "+number+ " ] ";
		
		Properties props = System.getProperties();
		
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = username;
			String pw = password;
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		
		session.setDebug(true);
		
		Message mimeMessage = new MimeMessage(session);
		mimeMessage.setFrom(new InternetAddress(username+"@naver.com"));
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(tomail));
		mimeMessage.setSubject(title);
		mimeMessage.setText(content);
		Transport.send(mimeMessage);

	}
}
