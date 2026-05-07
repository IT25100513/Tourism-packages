<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Feedback"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container-fluid px-lg-4 pb-5">
    <header class="tp-page-header d-flex flex-wrap justify-content-between gap-3 mb-4">
        <div><h1 class="h2 fw-bold mb-1">Feedback desk</h1><p class="text-secondary small mb-0">Community signals from <code class="small">feedback.txt</code>.</p></div>
        <a class="btn btn-primary rounded-pill px-4" href="${pageContext.request.contextPath}/feedback/new"><i class="bi bi-pencil-plus me-1"></i>New entry</a>
    </header>

    <div class="tp-table-card">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                <tr><th>#</th><th class="small">Guest id</th><th>Stars</th><th>Snippet</th><th>Date</th><th class="text-end">Tools</th></tr>
                </thead>
                <tbody>
                <c:forEach var="fb" items="${feedbackList}">
                    <tr>
                        <td class="small font-monospace">${fb.id}</td>
                        <td><code class="small">${fb.userId}</code></td>
                        <td><vh:stars-display rating="${fb.rating}"/></td>
                        <td style="max-width:360px;"><span class="small text-secondary">${empty fb.comment ? '—' : fb.comment}</span></td>
                        <td class="small">${fb.createdAt}</td>
                        <td class="text-end text-nowrap">
                            <a class="btn btn-sm btn-outline-primary rounded-pill" href="${pageContext.request.contextPath}/feedback/detail?id=${fb.id}"><i class="bi bi-eye"></i></a>
                            <a class="btn btn-sm btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/feedback/edit?id=${fb.id}"><i class="bi bi-pencil"></i></a>
                            <a class="btn btn-sm btn-outline-danger rounded-pill" href="${pageContext.request.contextPath}/feedback/delete?id=${fb.id}" onclick="return confirm('Remove feedback?');"><i class="bi bi-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${empty feedbackList}">
            <div class="tp-empty"><i class="bi bi-chat"></i>No feedback captured yet.</div>
        </c:if>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
