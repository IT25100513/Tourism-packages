<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Feedback detail"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:680px;">
    <div class="d-flex flex-wrap justify-content-between gap-3 mb-4">
        <div>
            <span class="d-inline-flex align-items-center gap-2 flex-wrap mb-2">
                <vh:stars-display rating="${feedback.rating}"/>
                <span class="text-secondary small">${feedback.rating} / 5</span>
            </span>
            <h1 class="h3 fw-bold mt-0 mb-0">Feedback #${feedback.id}</h1>
        </div>
        <div class="btn-group shadow-sm">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/feedback/edit?id=${feedback.id}"><i class="bi bi-pencil"></i></a>
            <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/feedback/delete?id=${feedback.id}" onclick="return confirm('Delete?');"><i class="bi bi-trash"></i></a>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/feedback/list">Back</a>
        </div>
    </div>
    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4 p-lg-5">
            <dl class="row mb-0">
                <dt class="col-sm-4 text-secondary small fw-bold text-uppercase">Package</dt>
                <dd class="col-sm-8"><c:out value="${empty tourPackage ? '—' : tourPackage.name}"/></dd>
                <dt class="col-sm-4 text-secondary small fw-bold text-uppercase">Captured</dt>
                <dd class="col-sm-8">${feedback.createdAt}</dd>
                <dt class="col-sm-12 text-secondary small fw-bold text-uppercase mt-4">Comment</dt>
                <dd class="col-sm-12"><p class="mb-0 text-secondary lh-lg"><c:out value="${empty feedback.comment ? 'No narrative provided.' : feedback.comment}"/></p></dd>
            </dl>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
