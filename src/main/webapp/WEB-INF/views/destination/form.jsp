<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Destination form"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:680px;">
    <h1 class="h3 fw-bold mb-4"><c:out value="${editMode ? 'Edit destination' : 'Create destination'}"/></h1>
    <c:if test="${not empty message}"><div class="alert alert-warning rounded-3">${message}</div></c:if>

    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4">
            <form class="needs-validation" method="post" action="${pageContext.request.contextPath}${editMode ? '/destinations/update' : '/destinations/create'}" novalidate>
                <c:if test="${editMode}"><input type="hidden" name="id" value="${destination.id}"/></c:if>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Name</label>
                    <input class="form-control form-control-lg" name="name" value="${destination.name}" required maxlength="160"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Country</label>
                    <input class="form-control" name="country" value="${destination.country}" required maxlength="120"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-semibold small">Description</label>
                    <textarea class="form-control" name="description" rows="5" maxlength="1000" placeholder="Optional overview">${destination.description}</textarea>
                    <div class="form-text">Up to 1000 characters.</div>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-primary rounded-pill px-4" type="submit"><i class="bi bi-check2"></i> Save</button>
                    <a class="btn btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/destinations/list">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
