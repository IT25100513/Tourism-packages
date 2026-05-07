<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Share feedback"/>
    </jsp:include>
</head>
<body class="page-customer pb-5">
<jsp:include page="/WEB-INF/views/fragments/customer-nav.jsp"/>

<div class="container pb-5" style="max-width:560px;">
    <h1 class="h3 fw-bold text-page-title mb-2">How was your voyage?</h1>
    <p class="text-page-sub small mb-4">Rates open when an admin marks your trip completed, or when staff confirmed it and the package’s last calendar day has passed.</p>

    <div class="tp-content-card tp-glass-rise tp-animate-fade-up">
        <div class="card-body p-4 p-lg-5">
            <c:if test="${not empty message}">
                <div class="alert alert-warning rounded-3 small">${message}</div>
            </c:if>

            <c:choose>
                <c:when test="${noEligibleTrips}">
                    <div class="tp-empty py-5 mb-4 rounded-3"><i class="bi bi-clock-history"></i>No finished trips yet. Wait until an admin marks yours completed—or keep a confirmed itinerary until after its last travel day.</div>
                    <a class="btn btn-primary w-100 rounded-3 fw-semibold" href="${pageContext.request.contextPath}/bookings/my">Open my trips</a>
                </c:when>
                <c:otherwise>
                    <form method="post" action="${pageContext.request.contextPath}/feedback/customer/add" class="needs-validation" novalidate>
                        <div class="mb-4">
                            <label class="form-label fw-bold" for="tripPackage">Trip</label>
                            <select name="packageId" id="tripPackage" class="form-select form-select-lg" required>
                                <option value="" disabled selected>Pick a finished trip…</option>
                                <c:forEach var="p" items="${packages}">
                                    <option value="${p.id}">${p.name} — <vh:price-lkr value="${p.price}"/></option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">Please choose.</div>
                        </div>
                        <div class="mb-4 p-4 rounded-4 bg-light">
                            <label class="form-label fw-bold d-block mb-2">Rating</label>
                            <vh:star-rating-input hiddenInputId="custRatingHidden" initialRating="${5}"/>
                            <div class="form-text mt-3 mb-0">Tap a star to set 1–5.</div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold">Comment</label>
                            <textarea class="form-control" name="comment" rows="5" maxlength="900" placeholder="Highlights from your itinerary…"></textarea>
                        </div>
                        <button class="btn btn-primary btn-lg w-100 rounded-3 fw-semibold mb-2" type="submit"><i class="bi bi-send-heart me-2"></i>Send feedback</button>
                        <a class="btn btn-outline-secondary w-100 rounded-3" href="${pageContext.request.contextPath}/bookings/my">Back to trips</a>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<c:if test="${!noEligibleTrips}">
    <jsp:include page="/WEB-INF/views/fragments/star-rating-script.jsp"/>
</c:if>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
