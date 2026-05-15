<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Edit Booking"/>
    </jsp:include>
</head>
<body class="page-customer pb-5">
<jsp:include page="/WEB-INF/views/fragments/customer-nav.jsp"/>

<div class="container pb-5" style="max-width:560px;">
    <h1 class="h3 fw-bold text-page-title mb-2">Modify your trip</h1>
    <p class="text-page-sub mb-4">Update your package selection, date, or notes for the planners.</p>

    <div class="tp-content-card tp-glass-rise tp-animate-fade-up">
        <div class="card-body p-4 p-lg-5">
            <c:if test="${not empty message}">
                <div class="alert alert-warning rounded-3 d-flex gap-2"><i class="bi bi-exclamation-triangle mt-1"></i>${message}</div>
            </c:if>
            <form class="needs-validation" method="post" action="${pageContext.request.contextPath}/bookings/customer/update" novalidate>
                <input type="hidden" name="id" value="${booking.id}"/>

                <div class="mb-4">
                    <label class="form-label fw-bold">Package</label>
                    <select class="form-select form-select-lg" name="packageId" id="bookingPackageSelect" required>
                        <option value="" disabled ${empty booking.packageId ? 'selected' : ''}>Select an experience…</option>
                        <c:forEach var="p" items="${packages}">
                            <option value="${p.id}" ${booking.packageId eq p.id ? 'selected' : ''}>${p.name} — <vh:price-lkr value="${p.price}"/></option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Choose one option.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold" for="tripStartDate">Trip start date</label>
                    <input class="form-control form-control-lg" type="date" name="tripDate" id="tripStartDate" required
                           min="${minTripDate}" max="${maxTripDate}" value="${booking.bookingDate}"/>
                    <div class="form-text mb-1">Dates use your browser’s calendar · must be today or later.</div>
                    <div class="invalid-feedback">Choose when you’d like your trip to start.</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Notes for planners</label>
                    <textarea class="form-control" name="notes" rows="4" maxlength="500" placeholder="Diet preferences, arrivals, birthdays…"><c:out value="${booking.notes}"/></textarea>
                </div>

                <button class="btn btn-primary btn-lg w-100 rounded-3 fw-bold" type="submit">
                    <i class="bi bi-save me-2"></i>Save changes
                </button>
                <a class="btn btn-outline-secondary w-100 mt-2 rounded-3" href="${pageContext.request.contextPath}/bookings/my">Cancel</a>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>