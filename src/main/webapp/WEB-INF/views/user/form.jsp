<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Traveler form"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:640px;">
    <h1 class="h3 fw-bold mb-2"><c:out value="${editMode ? 'Update traveler' : 'Add traveler'}"/></h1>
    <c:if test="${not empty message}">
        <div class="alert alert-warning rounded-3">${message}</div>
    </c:if>

    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4">
            <form class="needs-validation" method="post" action="${pageContext.request.contextPath}${editMode ? '/users/update' : '/users/create'}" novalidate>
                <c:if test="${editMode}">
                    <input type="hidden" name="id" value="${user.id}"/>
                </c:if>
                <div class="mb-3">
                    <label class="form-label fw-semibold small text-uppercase text-secondary">Username</label>
                    <input class="form-control" name="username" value="${user.username}" required maxlength="120"
                           pattern="[a-zA-Z0-9._\-]{3,120}" title="3–120 letters, digits, underscore, dot, or hyphen"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small text-uppercase text-secondary">Password</label>
                    <input class="form-control" type="password" name="password" value="${user.password}" required maxlength="120"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small text-uppercase text-secondary">Full name</label>
                    <input class="form-control" name="fullName" value="${user.fullName}" required maxlength="160"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small text-uppercase text-secondary">Email</label>
                    <input class="form-control" type="email" name="email" value="${user.email}" required maxlength="160"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-semibold small text-uppercase text-secondary">Phone</label>
                    <input class="form-control" name="phone" value="${user.phone}" maxlength="60" inputmode="numeric" pattern="[0-9+\-\s]{7,60}" title="Digits; 9–15 digits after stripping spaces"/>
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <button class="btn btn-primary px-4 rounded-pill" type="submit"><i class="bi bi-check2 me-1"></i>Save</button>
                    <a class="btn btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/users/list">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
