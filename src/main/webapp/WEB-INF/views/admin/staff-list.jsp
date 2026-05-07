<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Staff"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container-fluid px-lg-4 pb-5">
    <header class="tp-page-header d-flex flex-wrap justify-content-between gap-3 mb-4">
        <div><h1 class="h2 fw-bold mb-1">Staff roster</h1><p class="text-secondary mb-0 small">Team accounts persisted in <code class="small">staff.txt</code>.</p></div>
        <a class="btn btn-primary rounded-pill px-4" href="${pageContext.request.contextPath}/admin/staff/new"><i class="bi bi-person-plus me-1"></i>Add staff</a>
    </header>

    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body p-3">
            <form class="row g-2 align-items-center" method="get" action="${pageContext.request.contextPath}/admin/staff/list">
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-secondary"></i></span>
                        <input class="form-control border-start-0" name="q" placeholder="Search by name, email, department..."
                               value="${searchQuery}"/>
                    </div>
                </div>
                <div class="col-md-3"><button type="submit" class="btn btn-outline-primary w-100 rounded-3">Search</button></div>
            </form>
        </div>
    </div>

    <div class="tp-table-card">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                <tr><th>#</th><th>Name</th><th>Username</th><th>Email</th><th>Department</th><th class="text-end">Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="s" items="${staffList}">
                    <tr>
                        <td class="small text-muted font-monospace">${s.id}</td>
                        <td class="fw-semibold">${s.fullName}</td>
                        <td>${s.username}</td>
                        <td class="small">${s.email}</td>
                        <td><span class="badge bg-light text-dark border">${s.department}</span></td>
                        <td class="text-end text-nowrap">
                            <a class="btn btn-sm btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/admin/staff/edit?id=${s.id}"><i class="bi bi-pencil"></i></a>
                            <a class="btn btn-sm btn-outline-danger rounded-pill" href="${pageContext.request.contextPath}/admin/staff/delete?id=${s.id}"
                               onclick="return confirm('Revoke staff access for this profile?');"><i class="bi bi-person-x"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${empty staffList}">
            <div class="tp-empty"><i class="bi bi-people"></i>No staff profiles match.</div>
        </c:if>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
