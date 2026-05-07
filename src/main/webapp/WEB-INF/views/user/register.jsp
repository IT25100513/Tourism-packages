<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Register"/>
    </jsp:include>
</head>
<body class="page-public py-4">
<jsp:include page="/WEB-INF/views/fragments/public-nav.jsp"/>
<main class="container" style="max-width:520px;">
    <div class="card border-0 shadow-lg rounded-4 overflow-hidden tp-glass-rise tp-animate-fade-up">
        <div class="card-header border-0 py-4 text-white text-center" style="background:linear-gradient(135deg,var(--tp-teal),var(--tp-teal-dark));">
            <i class="bi bi-person-plus-fill fs-1 d-block mb-2 opacity-90"></i>
            <h1 class="h4 fw-bold mb-0">Create your account</h1>
            <p class="small mb-0 mt-2 opacity-75">Takes less than a minute.</p>
        </div>
        <div class="card-body p-4 p-lg-5">
            <c:if test="${not empty message}">
                <div class="alert alert-warning rounded-3 d-flex gap-2 align-items-start"><i class="bi bi-info-circle mt-1"></i><div>${message}</div></div>
            </c:if>
            <form method="post" action="${pageContext.request.contextPath}/users/register" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Username</label>
                    <input class="form-control form-control-lg" name="username" value="${user.username}" required maxlength="120" pattern="[a-zA-Z0-9._\-]{3,120}" title="Use 3–120 letters, digits, underscore, dot, or hyphen"
                           placeholder="Choose a login name"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Password</label>
                    <input class="form-control form-control-lg" type="password" name="password" value="${user.password}" required maxlength="120"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Full name</label>
                    <input class="form-control" name="fullName" value="${user.fullName}" required maxlength="160"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Email</label>
                    <input class="form-control" type="email" name="email" value="${user.email}" required maxlength="160"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-semibold small">Phone</label>
                    <input class="form-control" name="phone" value="${user.phone}" maxlength="60" inputmode="numeric" pattern="[0-9+\-\s]{7,60}" title="Digits only; optional + or spacing (9–15 digits)"
                           placeholder="0712345678"/>
                </div>
                <button class="btn btn-primary btn-lg w-100 rounded-3 fw-semibold" type="submit"><i class="bi bi-check-lg me-1"></i>Register</button>
                <p class="text-center text-secondary small mt-4 mb-0">Already have an account? <a href="${pageContext.request.contextPath}/users/login" class="fw-semibold">Sign in</a></p>
            </form>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
