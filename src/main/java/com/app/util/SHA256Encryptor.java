package com.app.util;
			
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
			
public class SHA256Encryptor {
			
	private static final String ENC_SALT = "sha256encsalt";
			
	public static String encrypt(String text) throws NoSuchAlgorithmException {	
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		text = text + ENC_SALT;
		md.update(text.getBytes());
			
		return bytesToHex(md.digest());
	}		
			
	private static String bytesToHex(byte[] cs) {
		StringBuilder sb = new StringBuilder();
		for (byte b : cs) {	
			sb.append(String.format("%02x", b));
		}	
		return sb.toString();
	}
}