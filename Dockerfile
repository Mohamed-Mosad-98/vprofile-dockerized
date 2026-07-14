# ==========================================
# Stage 1: Build Stage (Builder)
# ==========================================
FROM maven:3.8-openjdk-11 AS builder

# تحديد مسار العمل جوه الكونتينر
WORKDIR /app

# نسخ ملفات المشروع بالكامل من جهازك للكونتينر
COPY pom.xml .
COPY src ./src

# بناء المشروع واستخراج ملف الـ .war
RUN mvn clean install -DskipTests

# ==========================================
# Stage 2: Runtime Stage (Production)
# ==========================================
FROM tomcat:9.0-jre11

# 1. Security: مسح التطبيقات الافتراضية للتومكات لتقليل ثغرات الاختراق
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. نسخ ملف الـ .war من مرحلة البناء (بدون نسخ أي ملفات سورس كود أو مافن)
# وبنسميه ROOT.war عشان يفتح على اللينك المباشر بدون /vprofile
COPY --from=builder /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# 3. Security: إنشاء مستخدم جديد بصلاحيات محدودة (بدل تشغيل السيرفر كـ Root)
RUN addgroup --system tomcat && adduser --system --ingroup tomcat tomcat

# 4. إعطاء الصلاحيات للمستخدم الجديد على فولدر التومكات فقط
RUN chown -R tomcat:tomcat /usr/local/tomcat

# 5. التبديل للمستخدم الآمن
USER tomcat

# 6. فتح بورت 8080
EXPOSE 8080

# 7. أمر تشغيل التومكات
CMD ["catalina.sh", "run"]