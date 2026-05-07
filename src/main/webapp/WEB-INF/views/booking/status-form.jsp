<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Booking status"/>
    </jsp:include>
</head>
<body class="<c:choose><c:when test="${not empty sessionScope['SESSION_ADMIN']}">page-admin</c:when><c:otherwise>page-staff</c:otherwise></c:choose>">
<c:choose>
    <c:when test="${not empty sessionScope['SESSION_ADMIN']}"><jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/></c:when>
    <c:otherwise><jsp:include page="/WEB-INF/views/fragments/staff-nav.jsp"/></c:otherwise>
</c:choose>

<main class="container pb-5" style="max-width:560px;">
    <div class="mb-4">
        <span class="badge bg-secondary rounded-pill">Booking #${booking.id}</span>
        <h1 class="h3 fw-bold mt-2 mb-1">
            <c:choose>
                <c:when test="${booking.status eq 'COMPLETED'}">Trip completed</c:when>
                <c:otherwise>Update status</c:otherwise>
            </c:choose>
        </h1>
        <p class="text-secondary small mb-0">Requested trip start: <strong>${booking.bookingDate}</strong></p>
    </div>

    <div class="card border-0 shadow-sm rounded-4 mb-3">
        <div class="card-body p-4">
            <c:choose>
                <c:when test="${booking.status eq 'COMPLETED'}">
                    <div class="d-flex align-items-center gap-2 mb-4">
                        <span class="badge rounded-pill text-bg-dark px-3 py-2"><i class="bi bi-check2-circle me-1"></i>COMPLETED</span>
                        <span class="text-secondary small mb-0">This booking is archived. Customers can submit feedback.</span>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">Traveler</label>
                        <c:set var="travelerDone" value="Unknown"/>
                        <c:forEach var="u" items="${users}">
                            <c:if test="${u.id eq booking.userId}"><c:set var="travelerDone" value="${u.fullName}"/></c:if>
                        </c:forEach>
                        <input class="form-control bg-light border-0" value="${travelerDone}" readonly/>
                    </div>
                    <div class="mb-0">
                        <label class="form-label fw-bold small text-muted">Package</label>
                        <c:set var="pkgLabelDone" value="—"/>
                        <c:forEach var="p" items="${packages}">
                            <c:if test="${p.id eq booking.packageId}"><c:set var="pkgLabelDone" value="${p.name}"/></c:if>
                        </c:forEach>
                        <input class="form-control bg-light border-0" value="${pkgLabelDone}" readonly/>
                    </div>
                </c:when>
                <c:otherwise>
                    <form method="post" action="${pageContext.request.contextPath}/bookings/update-status" class="needs-validation" novalidate>
                        <input type="hidden" name="id" value="${booking.id}"/>
                        <div class="mb-4">
                            <label class="form-label fw-bold">Status</label>
                            <select class="form-select form-select-lg" name="status" required aria-label="Booking status">
                                <option value="PENDING" ${booking.status eq 'PENDING' ? 'selected' : ''}>Pending review</option>
                                <option value="CONFIRMED" ${booking.status eq 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                <option value="CANCELLED" ${booking.status eq 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                            </select>
                            <div class="invalid-feedback">Choose a status.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">Traveler</label>
                            <c:set var="traveler" value="Unknown"/>
                            <c:forEach var="u" items="${users}">
                                <c:if test="${u.id eq booking.userId}"><c:set var="traveler" value="${u.fullName}"/></c:if>
                            </c:forEach>
                            <input class="form-control bg-light border-0" value="${traveler}" readonly/>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">Package</label>
                            <c:set var="pkgLabel" value="—"/>
                            <c:set var="pkgPrice" value="${null}"/>
                            <c:forEach var="p" items="${packages}">
                                <c:if test="${p.id eq booking.packageId}">
                                    <c:set var="pkgLabel" value="${p.name}"/>
                                    <c:set var="pkgPrice" value="${p.price}"/>
                                </c:if>
                            </c:forEach>
                            <input class="form-control bg-light border-0" value="${pkgLabel}" readonly/>
                        </div>
                        <c:if test="${pkgLabel ne '—'}">
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-muted">Package price</label>
                                <div class="form-control bg-light border-0 font-monospace mb-0"><vh:price-lkr value="${pkgPrice}"/></div>
                            </div>
                        </c:if>
                        <div class="d-grid gap-2">
                            <button class="btn btn-primary btn-lg rounded-3 fw-semibold" type="submit"><i class="bi bi-check-lg me-1"></i>Save status</button>
                            <a class="btn btn-outline-secondary rounded-3" href="${pageContext.request.contextPath}/bookings">← Back to list</a>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>

            <c:if test="${booking.status eq 'COMPLETED'}">
                <div class="d-grid mt-4">
                    <a class="btn btn-outline-secondary rounded-3" href="${pageContext.request.contextPath}/bookings">← Back to list</a>
                </div>
            </c:if>
        </div>
    </div>

    <c:if test="${adminPresent && booking.status eq 'CONFIRMED'}">
        <div class="card border-0 border-top border-warning border-3 shadow-sm rounded-4 mb-5">
            <div class="card-body p-4">
                <h2 class="h6 fw-bold text-uppercase text-secondary mb-2">Administrator</h2>
                <p class="small text-secondary mb-4 mb-md-3">Finished handover with the traveler after a confirmed getaway? Lock the trip here so feedback unlocks instantly.</p>
                <form method="post" action="${pageContext.request.contextPath}/bookings/mark-completed" class="d-grid gap-2">
                    <input type="hidden" name="id" value="${booking.id}"/>
                    <button type="submit" class="btn btn-dark btn-lg rounded-3 fw-semibold">
                        <i class="bi bi-flag-fill me-2"></i>Mark trip completed
                    </button>
                </form>
            </div>
        </div>
    </c:if>
</main>
<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<c:if test="${booking.status ne 'COMPLETED'}">
    <jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</c:if>
</body>
</html>
