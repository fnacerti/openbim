docker-compose -f i4sub.yml down
docker rmi registry.certi.org.br/cpc-openbim/oneclickpe-backend
docker rmi registry.certi.org.br/cpc-openbim/oneclickpe-frontend
docker rmi registry.certi.org.br/cpc-openbim/certikey-backend
docker-compose -f i4sub.yml up
