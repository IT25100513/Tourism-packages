<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Feedback form"/>
    </jsp:include>
</head>
<body class="page-admin">
<jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/>
<main class="container pb-5" style="max-width:760px;">
    <h1 class="h3 fw-bold mb-2"><c:out value="${editMode ? 'Amend testimonial' : 'Manual testimonial'}"/></h1>
    <p class="text-secondary small mb-4">Link a traveler UUID with a packaged experience.</p>

    <c:if test="${not empty message}"><div class="alert alert-warning rounded-3">${message}</div></c:if>

    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4">
            <form class="needs-validation" method="post" action="${pageContext.request.contextPath}${editMode ? '/feedback/update' : '/feedback/create'}" novalidate>
                <c:if test="${editMode}"><input type="hidden" name="id" value="${feedback.id}"/></c:if>

                <div class="mb-3">
                    <label class="form-label fw-bold small">Guest (user id)</label>
                    <select name="userId" class="form-select form-select-lg" required>
                        <option value="" disabled ${empty feedback.userId ? 'selected' : ''}>Pick traveler record…</option>
                        <c:forEach var="u" items="${users}">
                            <option value="${u.id}" ${feedback.userId eq u.id ? 'selected' : ''}>${u.fullName} (${u.username})</option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Select a user.</div>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold small">Package</label>
                    <select name="packageId" class="form-select" required>
                        <option value="" disabled ${empty feedback.packageId ? 'selected' : ''}>Attach package…</option>
                        <c:forEach var="p" items="${packages}">
                            <option value="${p.id}" ${feedback.packageId eq p.id ? 'selected' : ''}>${p.name} — <vh:price-lkr value="${p.price}"/></option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Select a package.</div>
                </div>
                <div class="mb-3">
                    <c:set var="ratingValue" value="${editMode && feedback.rating > 0 ? feedback.rating : 5}"/>
                    <label class="form-label fw-bold small d-block mb-2">Stars (tap to score)</label>
                    <vh:star-rating-input hiddenInputId="adminRatingHidden" initialRating="${ratingValue}"/>
                    <div class="invalid-feedback">Pick 1–5 stars.</div>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold small">Comment</label>
                    <textarea name="comment" class="form-control" rows="5" maxlength="1000" placeholder="Trip highlights or suggestions">${feedback.comment}</textarea>
                    <div class="form-text">Max 1000 characters.</div>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-primary rounded-pill px-4" type="submit"><i class="bi bi-check-lg me-1"></i>Publish</button>
                    <a class="btn btn-outline-secondary rounded-pill" href="${pageContext.request.contextPath}/feedback/list">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/star-rating-script.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
