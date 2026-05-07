<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Package form"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:720px;">
    <h1 class="h3 fw-bold mb-4"><c:out value="${editMode ? 'Edit package' : 'New package'}"/></h1>

    <c:if test="${not empty message}">
        <div class="alert alert-warning rounded-3">${message}</div>
    </c:if>

    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4">
            <form class="needs-validation" method="post" action="${pageContext.request.contextPath}${editMode ? '/packages/update' : '/packages/create'}" novalidate>
                <c:if test="${editMode}"><input type="hidden" name="id" value="${tourPackage.id}"/></c:if>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Name</label>
                    <input class="form-control" name="name" value="${tourPackage.name}" required maxlength="160"/>
                    <div class="invalid-feedback">Required</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold small">Description</label>
                    <textarea class="form-control" name="description" rows="5" maxlength="1000" placeholder="What makes this itinerary special?">${tourPackage.description}</textarea>
                </div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Price (LKR)</label>
                        <div class="input-group"><span class="input-group-text">LKR</span>
                            <input class="form-control" type="number" step="0.01" min="0.01" max="999999999" name="price" value="${tourPackage.price}" required placeholder="LKR"/></div>
                        <div class="invalid-feedback">Enter a positive price (LKR).</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Duration (days)</label>
                        <input class="form-control" type="number" min="1" max="365" name="durationDays" value="${tourPackage.durationDays}" required/>
                        <div class="invalid-feedback">From 1 to 365 days</div>
                    </div>
                </div>
                <div class="mb-4 mt-3">
                    <label class="form-label fw-semibold small">Destination</label>
                    <select class="form-select form-select-lg" name="destinationId" required>
                        <option value="" disabled ${empty tourPackage.destinationId ? 'selected' : ''}>Choose destination…</option>
                        <c:forEach var="d" items="${destinations}">
                            <option value="${d.id}" ${tourPackage.destinationId eq d.id ? 'selected' : ''}>${d.name} — ${d.country}</option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Pick one</div>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-primary rounded-pill px-4" type="submit"><i class="bi bi-check2 me-1"></i>Save package</button>
                    <a class="btn btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/packages/list">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
