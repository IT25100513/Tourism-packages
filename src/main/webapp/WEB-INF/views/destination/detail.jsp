<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Destination"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:760px;">
    <div class="d-flex flex-wrap justify-content-between gap-3 mb-4">
        <div>
            <span class="badge rounded-pill bg-primary-subtle text-primary-emphasis mb-2">${destination.country}</span>
            <h1 class="h2 fw-bold mb-0">${destination.name}</h1>
        </div>
        <div class="btn-group shadow-sm">
            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/destinations/edit?id=${destination.id}"><i class="bi bi-pencil me-1"></i>Edit</a>
            <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/destinations/delete?id=${destination.id}" onclick="return confirm('Delete?');"><i class="bi bi-trash"></i></a>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/destinations/list">All</a>
        </div>
    </div>
    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4 p-lg-5">
            <p class="lead text-secondary lh-lg mb-0">${empty destination.description ? 'Storytelling awaiting marketing.' : destination.description}</p>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
