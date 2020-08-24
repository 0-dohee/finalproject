package com.example.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class kakao_restapi {
	
	public static JsonNode getKakaoUserInfo(JsonNode accessToken) {
		 
        final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(RequestUrl);
 
        // add header
        post.addHeader("Authorization", "Bearer " + accessToken);
 
        JsonNode returnNode = null;
 
        try {
            final HttpResponse response = client.execute(post);
            final int responseCode = response.getStatusLine().getStatusCode();
 
            System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
            System.out.println("Response Code : " + responseCode);
 
            // JSON ���� ��ȯ�� ó��
            ObjectMapper mapper = new ObjectMapper();
            returnNode = mapper.readTree(response.getEntity().getContent());
 
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // clear resources
        }
 
        return returnNode;
    }
	
public JsonNode getAccessToken(String autorize_code) {
        
        final String RequestUrl = "https://kauth.kakao.com/oauth/token";
 
        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
        
        //����Ʈ �Ķ������ grant_type�̶�� ��Ī�� authorization_code�� �߰��Ѵ� �Ʒ��� ����
        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
 
        postParams.add(new BasicNameValuePair("client_id", "44c4398b724d06191dbaf99c087795b1"));
 
        postParams.add(new BasicNameValuePair("redirect_uri", "http://192.169.0.194:8088/oauth")); //�� : http://������:��Ʈ/�ֻ�������/�����̷��ǰ��
 
        postParams.add(new BasicNameValuePair("code", autorize_code));
        //��Ÿ ������ ���� �ڼ��� �˰� ������ ���۸��ϼ���.
        final HttpClient client = HttpClientBuilder.create().build();
 
        final HttpPost post = new HttpPost(RequestUrl);
 
        JsonNode returnNode = null;
 
        try {
 
            post.setEntity(new UrlEncodedFormEntity(postParams));
 
            final HttpResponse response = client.execute(post);
 
            ObjectMapper mapper = new ObjectMapper();
 
            returnNode = mapper.readTree(response.getEntity().getContent());
 
        } catch (UnsupportedEncodingException e) {
 
            e.printStackTrace();
 
        } catch (ClientProtocolException e) {
 
            e.printStackTrace();
 
        } catch (IOException e) {
 
            e.printStackTrace();
 
        } finally {
 
        }
 
        return returnNode;
 
    }

public JsonNode Logout(String autorize_code) {
	final String RequestUrl = "https://kapi.kakao.com/v1/user/logout";
	 
    final HttpClient client = HttpClientBuilder.create().build();

    final HttpPost post = new HttpPost(RequestUrl);

    post.addHeader("Authorization", "Bearer " + autorize_code);
    
    System.out.println(post);
    JsonNode returnNode = null;

    try {

        final HttpResponse response = client.execute(post);

        ObjectMapper mapper = new ObjectMapper();

        returnNode = mapper.readTree(response.getEntity().getContent());

    } catch (UnsupportedEncodingException e) {

        e.printStackTrace();

    } catch (ClientProtocolException e) {

        e.printStackTrace();

    } catch (IOException e) {

        e.printStackTrace();

    } finally {

    }

    return returnNode;

}


}
