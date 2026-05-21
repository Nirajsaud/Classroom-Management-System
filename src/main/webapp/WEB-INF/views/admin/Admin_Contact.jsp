<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact – Pathshala</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Contact.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>
<div class="app-wrapper">
    <% request.setAttribute("activePage", "contact"); %>
    <jsp:include page="/WEB-INF/views/admin/adminSidebar.jsp" />

    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/adminTopbar.jsp" />

        <main class="content-area admin-contact-page">
            <div class="submission-header">
                <div class="title-block">
                    <h1>Contact Submission</h1>
                    <p>Review and manage inquiries sent through the Pathshala platform</p>
                </div>
            </div>

            <div class="submission-card">
                <div class="table-wrapper">
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th width="15%">Date / Time</th>
                                <th width="25%">Sender Details</th>
                                <th width="20%">Phone Number</th>
                                <th width="25%">Message Snippet</th>
                                <th width="15%" class="text-right">Actions</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="submission" items="${submissions}">
                                <tr class="main-row">
                                    <td>
                                        <div class="date-txt"><c:out value="${submission.date}"/></div>
                                        <div class="time-txt"><c:out value="${submission.time}"/></div>
                                    </td>

                                    <td>
                                        <div class="user-name"><c:out value="${submission.name}"/></div>
                                        <div class="user-email"><c:out value="${submission.email}"/></div>
                                    </td>

                                    <td>
                                        <span class="phone-tag"><c:out value="${submission.phone}"/></span>
                                    </td>

                                    <td>
                                        <p class="msg-preview"><c:out value="${submission.messageSnippet}"/></p>
                                    </td>

                                    <td class="text-right">
                                        <div class="action-group">
                                            <form action="${pageContext.request.contextPath}/admincontact"
                                                  method="POST"
                                                  class="delete-form"
                                                  onsubmit="return confirm('Permanently delete this inquiry?');">
                                                <input type="hidden" name="queryId" value="${submission.queryId}">
                                                <input type="hidden" name="action" value="delete">
                                                <button class="tbl-btn bin-btn" type="submit" title="Delete Submission">Bin</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>

                                <tr class="detail-row">
                                    <td colspan="5">
                                        <div class="detail-content">
                                            <h5>Full Message Content (${submission.subject}):</h5>
                                            <p><c:out value="${submission.fullMessage}"/></p>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty submissions}">
                                <tr>
                                    <td colspan="5" class="empty-contact-row">
                                        No contact submissions found.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/Admin_Contact.js"></script>
</body>
</html>
