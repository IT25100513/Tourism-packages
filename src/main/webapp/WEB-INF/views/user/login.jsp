<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Customer sign in"/>
    </jsp:include>
</head>
<body class="page-public py-4">
<jsp:include page="/WEB-INF/views/fragments/public-nav.jsp"/>
<main class="container" style="max-width:440px;">
    <div class="card border-0 shadow-lg rounded-4">
        <div class="card-body p-4 p-lg-5">
            <div class="text-center mb-4">
                <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-info bg-opacity-10 text-info p-3 mb-3">
                    <i class="bi bi-person-circle fs-1"></i>
                </div>
                <h1 class="h4 fw-bold">Customer sign in</h1>
                <p class="text-secondary small mb-0">Access your bookings and feedback.</p>
            </div>
            <c:if test="${not empty message}">
                <div class="alert alert-info rounded-3 small mb-3">${message}</div>
            </c:if>
            <form class="needs-validation" method="post" action="${pageContext.request.contextPath}/users/login" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Username</label>
                    <input class="form-control form-control-lg" name="username" value="${loginUsername}" required maxlength="120" autocomplete="username"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-semibold small">Password</label>
                    <input class="form-control form-control-lg" type="password" name="password" required maxlength="120" autocomplete="current-password"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <button class="btn btn-primary btn-lg w-100 rounded-3 fw-semibold" type="submit"><i class="bi bi-box-arrow-in-right me-1"></i>Sign in</button>
                <p class="text-center small text-secondary mt-4 mb-0"><a href="${pageContext.request.contextPath}/users/register" class="fw-semibold text-decoration-none">Create an account</a></p>
            </form>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
