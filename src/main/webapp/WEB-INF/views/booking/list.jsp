<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="vh" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Bookings"/>
    </jsp:include>
</head>
<body class="<c:choose><c:when test="${not empty sessionScope['SESSION_ADMIN']}">page-admin</c:when><c:otherwise>page-staff</c:otherwise></c:choose>">
<c:choose>
    <c:when test="${not empty sessionScope['SESSION_ADMIN']}"><jsp:include page="/WEB-INF/views/fragments/admin-nav.jsp"/></c:when>
    <c:otherwise><jsp:include page="/WEB-INF/views/fragments/staff-nav.jsp"/></c:otherwise>
</c:choose>

<main class="container-fluid px-lg-4 pb-5">
    <header class="tp-page-header mb-4">
        <h1 class="h2 fw-bold mb-2">Booking board</h1>
        <p class="text-secondary mb-0 small">
            <c:choose>
                <c:when test="${not empty sessionScope['SESSION_ADMIN']}"><i class="bi bi-info-circle me-1"></i>Confirm trips as usual—after <strong>CONFIRMED</strong>, use edit view to mark <strong>completed</strong> so guests can leave feedback.</c:when>
                <c:otherwise><i class="bi bi-patch-check me-1"></i>Staff: update statuses only (completed is set by admins).</c:otherwise>
            </c:choose>
        </p>
    </header>

    <div class="tp-table-card">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                <tr><th>#</th><th>Guest</th><th>Package</th><th class="text-end">Price</th><th>Status</th><th>Trip start</th><th class="text-end">Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="b" items="${bookings}">
                    <c:set var="customerName" value="Unknown"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.id eq b.userId}"><c:set var="customerName" value="${u.fullName}"/></c:if>
                    </c:forEach>
                    <c:set var="packageName" value="—"/>
                    <c:set var="bookingPkgPrice" value="${null}"/>
                    <c:forEach var="p" items="${packages}">
                        <c:if test="${p.id eq b.packageId}">
                            <c:set var="packageName" value="${p.name}"/>
                            <c:set var="bookingPkgPrice" value="${p.price}"/>
                        </c:if>
                    </c:forEach>
                    <tr>
                        <td class="small text-muted font-monospace">${b.id}</td>
                        <td class="fw-semibold">${customerName}</td>
                        <td>${packageName}</td>
                        <td class="text-end font-monospace small">
                            <c:choose>
                                <c:when test="${packageName eq '—'}">—</c:when>
                                <c:otherwise><vh:price-lkr value="${bookingPkgPrice}"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${b.status eq 'COMPLETED'}"><span class="badge rounded-pill text-bg-dark">${b.status}</span></c:when>
                                <c:when test="${b.status eq 'CONFIRMED'}"><span class="badge rounded-pill text-bg-success">${b.status}</span></c:when>
                                <c:when test="${b.status eq 'CANCELLED'}"><span class="badge rounded-pill text-bg-secondary">${b.status}</span></c:when>
                                <c:otherwise><span class="badge rounded-pill text-bg-warning text-dark">${b.status}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="small">${b.bookingDate}</td>
                        <td class="text-end">
                            <a class="btn btn-sm btn-primary rounded-pill" href="${pageContext.request.contextPath}/bookings/edit?id=${b.id}"><i class="bi bi-sliders"></i></a>
                            <c:if test="${not empty sessionScope['SESSION_ADMIN']}">
                                <a class="btn btn-sm btn-outline-danger rounded-pill" href="${pageContext.request.contextPath}/bookings/delete?id=${b.id}"
                                   onclick="return confirm('Remove booking permanently?');"><i class="bi bi-trash"></i></a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${empty bookings}">
            <div class="tp-empty"><i class="bi bi-calendar-x"></i>No bookings queued.</div>
        </c:if>
    </div>
</main>

<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
</body>
</html>
