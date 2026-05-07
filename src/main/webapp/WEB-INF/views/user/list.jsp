<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Travelers"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container-fluid px-lg-4 pb-5">
    <header class="tp-page-header d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
        <div>
            <h1 class="h2 fw-bold mb-1">Travelers</h1>
            <p class="text-secondary mb-0 small">Search and maintain traveler profiles.</p>
        </div>
        <a class="btn btn-primary rounded-pill px-4" href="${pageContext.request.contextPath}/users/new"><i class="bi bi-person-plus me-1"></i>Add user</a>
    </header>

    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body p-3">
            <form class="row g-2 align-items-center" method="get" action="${pageContext.request.contextPath}/users/list">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-secondary"></i></span>
                        <input class="form-control border-start-0" type="search" name="q" placeholder="Search name, email, username, phone..."
                               value="${searchQuery}"/>
                    </div>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-outline-primary w-100 rounded-3" type="submit">Search</button>
                </div>
            </form>
        </div>
    </div>

    <div class="tp-table-card">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr><th>Username</th><th>Full name</th><th>Email</th><th>Phone</th><th class="text-end">Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td class="fw-semibold">${u.username}</td>
                        <td>${u.fullName}</td>
                        <td class="small">${u.email}</td>
                        <td class="small">${u.phone}</td>
                        <td class="text-end text-nowrap">
                            <a class="btn btn-sm btn-outline-primary rounded-pill" href="${pageContext.request.contextPath}/users/detail?id=${u.id}"><i class="bi bi-eye"></i></a>
                            <a class="btn btn-sm btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/users/edit?id=${u.id}"><i class="bi bi-pencil"></i></a>
                            <a class="btn btn-sm btn-outline-danger rounded-pill" href="${pageContext.request.contextPath}/users/delete?id=${u.id}"
                               onclick="return confirm('Delete this user?');"><i class="bi bi-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${empty users}">
            <div class="tp-empty"><i class="bi bi-person-x"></i>No travelers match your filters.</div>
        </c:if>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
