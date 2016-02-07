FROM erlang:18.2.3

MAINTAINER Grigory Starinkin <starinkin@gmail.com>

ADD ./snapaste /usr/local/snapaste

WORKDIR /usr/local/snapaste

RUN make

EXPOSE 8443

CMD erl -pa ebin deps -s snapaste -noinput -config config/erl
