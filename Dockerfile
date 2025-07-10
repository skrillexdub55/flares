services:
  byparr:
    image: ghcr.io/thephaseless/byparr:latest
    restart: unless-stopped
    shm_size: 2gb
    environment:
      - PROXY=http://pproxy.docker:8080
    volumes:
      - ./screenshots:/app/screenshots
    ports:
      - "8191:8191"
    networks:
      - byparr

  pproxy:
    tty: true
    container_name: pproxy
    restart: unless-stopped
    image: mosajjal/pproxy:latest
    command:
      - -vv
    ports:
      - "8080:8080"
    networks:
      byparr:
        aliases:
          - pproxy.docker
networks:
  byparr:
    driver: bridge
