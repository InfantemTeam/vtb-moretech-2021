package com.example.test.http_helper;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.net.ssl.HttpsURLConnection;

public class HTTPSHelper {

    private String httpsURLLogin = "https://vtb.sdore.me/api/login";
    private String httpsURLReg = "https://vtb.sdore.me/api/register";
    private String httpsURLform = "https://vtb.sdore.me/api/profile";

    public void pushSegmentationInfo(int age, int education, int wage) {
        String query = null;
        try {
            query = "age=" + URLEncoder.encode(String.valueOf(age), "UTF-8") + "&education=";
            query += URLEncoder.encode(String.valueOf(education), "UTF-8");
            query += "&wage=" + URLEncoder.encode(String.valueOf(wage), "UTF-8");
            byte[] postData = query.getBytes(StandardCharsets.UTF_8);

            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        URL url = new URL(httpsURLform);
                        HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
                        con.setDoOutput(true);
                        con.setRequestMethod("POST");
                        con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                        wr.write(postData);

                        int code = con.getResponseCode();
                        System.out.println(code);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }).start();

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

    }

    public void doLogin(String username, String password) {
        try {
            String query = "email=" + URLEncoder.encode(username, "UTF-8");
            query += "&";
            query += "password=" + URLEncoder.encode(password, "UTF-8");
            byte[] postData = query.getBytes(StandardCharsets.UTF_8);

            new Thread(new Runnable() {
                @Override
                public void run() {
                        try {
                            URL url = new URL(httpsURLLogin);
                            HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
                            con.setDoOutput(true);
                            con.setRequestMethod("POST");
                            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                            wr.write(postData);

                            int code = con.getResponseCode();

                            if (code == 418) {
                                doRegister(username, password);
                            }
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
            }).start();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

    }
    public void doRegister(String username, String password) {
        try {
            String query = "email=" + URLEncoder.encode(username, "UTF-8");
            query += "&";
            query += "password=" + URLEncoder.encode(password, "UTF-8");
            byte[] postData = query.getBytes(StandardCharsets.UTF_8);

            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        URL url = new URL(httpsURLReg);
                        HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
                        con.setDoOutput(true);
                        con.setRequestMethod("POST");
                        con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                        wr.write(postData);

                        int code = con.getResponseCode();

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

    }

}
