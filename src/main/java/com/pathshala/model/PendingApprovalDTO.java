package com.pathshala.model;

public class PendingApprovalDTO {
    private int userId;
    private String fullName;
    private String role;
    private String timeAgo;

    // Constructors
    public PendingApprovalDTO() {}

    public PendingApprovalDTO(int userId, String fullName, String role, String timeAgo) {
        this.userId = userId;
        this.fullName = fullName;
        this.role = role;
        this.timeAgo = timeAgo;
    }

    // Getters
    public int getUserId() { return userId; }
    public String getFullName() { return fullName; }
    public String getRole() { return role; }
    public String getTimeAgo() { return timeAgo; }
}