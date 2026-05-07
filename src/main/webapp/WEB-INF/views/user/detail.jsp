<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Traveler profile"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:720px;">
    <div class="d-flex flex-wrap justify-content-between align-items-start gap-3 mb-4">
        <div>
            <h1 class="h2 fw-bold mb-1">${user.fullName}</h1>
            <p class="text-secondary mb-0 small">@${user.username}</p>
        </div>
        <div class="btn-group shadow-sm">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/users/edit?id=${user.id}"><i class="bi bi-pencil me-1"></i>Edit</a>
            <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/users/delete?id=${user.id}" onclick="return confirm('Delete this user?');"><i class="bi bi-trash me-1"></i>Delete</a>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/users/list"><i class="bi bi-list me-1"></i>All travelers</a>
        </div>
    </div>

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body px-4 pt-4 pb-4">
            <dl class="row mb-0 gy-3">
                <dt class="col-sm-3 text-secondary small fw-bold text-uppercase">Email</dt>
                <dd class="col-sm-9 mb-0"><a href="mailto:${user.email}" class="text-decoration-none">${user.email}</a></dd>
                <dt class="col-sm-3 text-secondary small fw-bold text-uppercase">Phone</dt>
                <dd class="col-sm-9 mb-0">${empty user.phone ? '—' : user.phone}</dd>
                <dt class="col-sm-3 text-secondary small fw-bold text-uppercase">Record id</dt>
                <dd class="col-sm-9 mb-0"><code class="small user-select-all">${user.id}</code></dd>
                <dt class="col-sm-3 text-secondary small fw-bold text-uppercase">Password</dt>
                <dd class="col-sm-9 mb-0 text-muted small">Stored in plain text for this assignment only—do not use real secrets.</dd>
            </dl>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
