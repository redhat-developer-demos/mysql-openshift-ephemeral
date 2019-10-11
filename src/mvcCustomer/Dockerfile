FROM centos:latest


WORKDIR app
COPY /bin/Release/netcoreapp3.0/linux-x64/publish/. /app
RUN chmod +x mvcCustomer
EXPOSE 5000
EXPOSE 5001

CMD ["/app/mvcCustomer","--urls","http://0.0.0.0:5000"]