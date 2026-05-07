<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>
LKR <fmt:formatNumber value="${value}" groupingUsed="true" minFractionDigits="0" maxFractionDigits="2"/>
