package com.pathshala.model;

public class ContactQueryDTO {
    private int queryId;
    private String date;
    private String time;
    private String name;
    private String email;
    private String phone;
    private String subject;
    private String messageSnippet;
    private String fullMessage;

    // Constructor
    public ContactQueryDTO(int queryId, String date, String time, String name, 
                           String email, String phone, String subject, 
                           String messageSnippet, String fullMessage) {
        this.queryId = queryId;
        this.date = date;
        this.time = time;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.messageSnippet = messageSnippet;
        this.fullMessage = fullMessage;
    }

    // Getters
    public int getQueryId() { return queryId; }
    public String getDate() { return date; }
    public String getTime() { return time; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getSubject() { return subject; }
    public String getMessageSnippet() { return messageSnippet; }
    public String getFullMessage() { return fullMessage; }
}