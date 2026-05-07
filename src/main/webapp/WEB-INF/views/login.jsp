<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp">
        <jsp:param name="pageTitle" value="Staff &amp; admin sign in"/>
    </jsp:include>
</head>
<body class="page-public">
<jsp:include page="/WEB-INF/views/fragments/public-nav.jsp"/>

<main class="container py-4 py-lg-5" style="max-width: 1040px;">
    <section class="tp-login-billboard mb-5 rounded-4 shadow-lg tp-animate-fade-up" aria-labelledby="staffAdminLoginHeading">
        <div class="tp-login-billboard-inner">
            <div class="billboard-plane text-warning mb-2"><i class="bi bi-airplane-fill fs-2"></i></div>
            <h2 id="staffAdminLoginHeading" class="h3 fw-bold mb-2">Departures Lounge</h2>
            <p class="small mb-3 opacity-90">Sign in beneath a living runway scene—credentials stay humble inside your comma-separated roster files.</p>
            <div class="d-flex flex-wrap gap-2 mt-4">
                <span class="badge rounded-pill bg-white bg-opacity-15 border border-white border-opacity-25 fw-semibold">Admin console</span>
                <span class="badge rounded-pill bg-white bg-opacity-15 border border-white border-opacity-25 fw-semibold">Staff kiosk</span>
            </div>
        </div>
    </section>

    <div class="text-center mb-4 tp-animate-fade-up tp-delay-1">
        <h1 class="h2 fw-bold">Authenticate</h1>
        <p class="text-secondary mb-0">Use <code class="small">data/admins.txt</code> &amp; <code class="small">data/staff.txt</code> for accounts.</p>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-warning shadow-sm d-flex align-items-center gap-2 mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-5"></i><div>${message}</div>
        </div>
    </c:if>

    <div class="row g-4 align-items-stretch">
        <div class="col-lg-6">
            <div class="tp-login-card card h-100 border-0 shadow">
                <div class="admin-header tp-login-card-header-custom px-4 py-3 text-white d-flex align-items-center gap-2" style="background:linear-gradient(90deg,#4f46e5,#4338ca);">
                    <i class="bi bi-shield-lock fs-4"></i><span class="fw-bold">Administrator</span>
                </div>
                <div class="card-body p-4">
                    <form method="post" action="${pageContext.request.contextPath}/auth/admin/login" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-uppercase text-secondary">Username</label>
                            <input type="text" name="username" class="form-control form-control-lg" required maxlength="120" autocomplete="username" placeholder="admin"/>
                            <div class="invalid-feedback">Username is required.</div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-uppercase text-secondary">Password</label>
                            <input type="password" name="password" class="form-control form-control-lg" required maxlength="120" autocomplete="current-password"/>
                            <div class="invalid-feedback">Password is required.</div>
                        </div>
                        <button class="btn btn-lg w-100 text-white fw-semibold rounded-3 border-0" style="background:linear-gradient(135deg,#4f46e5,#4338ca);" type="submit"><i class="bi bi-box-arrow-in-right me-2"></i>Continue as admin</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="tp-login-card card h-100 border-0 shadow">
                <div class="staff-header px-4 py-3 text-white d-flex align-items-center gap-2" style="background:linear-gradient(90deg,#059669,#047857);">
                    <i class="bi bi-person-badge fs-4"></i><span class="fw-bold">Staff member</span>
                </div>
                <div class="card-body p-4">
                    <form method="post" action="${pageContext.request.contextPath}/auth/staff/login" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-uppercase text-secondary">Username</label>
                            <input type="text" name="username" class="form-control form-control-lg" required maxlength="120" autocomplete="username"/>
                            <div class="invalid-feedback">Username is required.</div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-uppercase text-secondary">Password</label>
                            <input type="password" name="password" class="form-control form-control-lg" required maxlength="120" autocomplete="current-password"/>
                            <div class="invalid-feedback">Password is required.</div>
                        </div>
                        <button class="btn btn-lg w-100 text-white fw-semibold rounded-3 border-0" style="background:linear-gradient(135deg,#059669,#047857);" type="submit"><i class="bi bi-box-arrow-in-right me-2"></i>Continue as staff</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <p class="text-center small text-secondary mt-5 mb-0"><i class="bi bi-info-circle me-1"></i>New here? <a href="${pageContext.request.contextPath}/users/register">Register as a customer</a> separately.</p>
</main>

<jsp:include page="/WEB-INF/views/fragments/footer-scripts.jsp"/>
<jsp:include page="/WEB-INF/views/fragments/form-validation-script.jsp"/>
</body>
</html>
