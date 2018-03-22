FROM jenkins/jenkins:lts

ENV X_JAVA_VERSION_MAJOR=8 \
    X_JAVA_VERSION_MINOR=162 \
    X_JAVA_VERSION_BUILD=12 \
    X_JAVA_PACKAGE=jdk \
    X_GRADLE_VERSION=4.6 \
    X_MAVEN_VERSION=3.5.3

USER root


RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl gnupg2 software-properties-common \
    && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce \
    && usermod -a -G staff,docker jenkins \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
      http://download.oracle.com/otn-pub/java/jdk/${X_JAVA_VERSION_MAJOR}u${X_JAVA_VERSION_MINOR}-b${X_JAVA_VERSION_BUILD}/0da788060d494f5095bf8624735fa2f1/${X_JAVA_PACKAGE}-${X_JAVA_VERSION_MAJOR}u${X_JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    && JAVA_PACKAGE_SHA256=$(curl -sSL https://www.oracle.com/webfolder/s/digest/${X_JAVA_VERSION_MAJOR}u${X_JAVA_VERSION_MINOR}checksum.html | grep -E "${X_JAVA_PACKAGE}-${X_JAVA_VERSION_MAJOR}u${X_JAVA_VERSION_MINOR}-linux-x64\.tar\.gz" | grep -Eo '(sha256: )[^<]+' | cut -d: -f2 | xargs) \
    && echo "${JAVA_PACKAGE_SHA256}  /tmp/java.tar.gz" > /tmp/java.tar.gz.sha256 \
    && sha256sum -c /tmp/java.tar.gz.sha256 \
    && gunzip /tmp/java.tar.gz \
    && tar -C /opt -xf /tmp/java.tar \
    && ln -s /opt/jdk1.${X_JAVA_VERSION_MAJOR}.0_${X_JAVA_VERSION_MINOR} /opt/jdk \
    && curl -ksSL -o /tmp/gradle.zip https://services.gradle.org/distributions/gradle-${X_GRADLE_VERSION}-bin.zip \
    && unzip -d /opt /tmp/gradle.zip \
    && ln -s /opt/gradle-${X_GRADLE_VERSION} /opt/gradle \
    && curl -ksSL -o /tmp/maven.tar.gz http://www-us.apache.org/dist/maven/maven-3/${X_MAVEN_VERSION}/binaries/apache-maven-${X_MAVEN_VERSION}-bin.tar.gz \
    && tar -xvzf /tmp/maven.tar.gz -C /opt \
    && ln -s /opt/apache-maven-${X_MAVEN_VERSION} /opt/maven \
    && chown -R jenkins:jenkins /opt/* \
    && rm -rf /tmp/* \
	  /var/lib/apt/lists/*