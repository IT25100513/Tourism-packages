<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Staff form"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:680px;">
    <h1 class="h3 fw-bold mb-2"><c:out value="${editMode ? 'Update staff member' : 'Invite staff'}"/></h1>
    <p class="text-secondary mb-4">Keeps parity with comma-separated roster rows.</p>

    <c:if test="${not empty message}"><div class="alert alert-warning rounded-3">${message}</div></c:if>

    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4">
            <form class="needs-validation" method="post" action="${pageContext.request.contextPath}${editMode ? '/admin/staff/update' : '/admin/staff/create'}" novalidate>
                <c:if test="${editMode}"><input type="hidden" name="id" value="${staff.id}"/></c:if>
                <div class="row g-3">
                    <div class="col-md-6 mb-md-0">
                        <label class="form-label small fw-semibold text-uppercase text-secondary">Username</label>
                        <input class="form-control" name="username" value="${staff.username}" required maxlength="120"
                               pattern="[a-zA-Z0-9._\-]{3,120}" title="3–120 letters, digits, underscore, dot, or hyphen"/>
                        <div class="invalid-feedback">Required</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold text-uppercase text-secondary">Password</label>
                        <input class="form-control" type="password" name="password" value="${staff.password}" required maxlength="120" minlength="1"/>
                        <div class="invalid-feedback">Password required</div>
                    </div>
                </div>
                <div class="mt-3">
                    <label class="form-label small fw-semibold text-uppercase text-secondary">Full name</label>
                    <input class="form-control" name="fullName" value="${staff.fullName}" required maxlength="160"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mt-3">
                    <label class="form-label small fw-semibold text-uppercase text-secondary">Email</label>
                    <input class="form-control" type="email" name="email" value="${staff.email}" required maxlength="160"/>
                    <div class="invalid-feedback">Valid email required</div>
                </div>
                <div class="mt-3 mb-4">
                    <label class="form-label small fw-semibold text-uppercase text-secondary">Department</label>
                    <input class="form-control" name="department" value="${staff.department}" required maxlength="120" placeholder="e.g. Reservations"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <button class="btn btn-primary rounded-pill px-4" type="submit"><i class="bi bi-check2 me-1"></i>Save</button>
                    <a class="btn btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/admin/staff/list">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
