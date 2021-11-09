#!/bin/bash

read -p 'Docker-compose down? (y/n)' yn
if [ "$yn" == "y" ]; then
  docker-compose -f i4sub-portal-PB.yml down
fi

read -p 'Docker Harbor Login? (y/n)' useHarbor
if [ "$useHarbor" == "y" ]; then
  docker login registry.certi.org.br
else
  docker login
fi

read -p 'Docker Harbor LoginRemover imagens antigas do docker? (y/n)' yn
if [ "yn" == "y" ]; then
  docker rmi registry.certi.org.br/cpc-openbim/oneclickpe-backend
  docker rmi registry.certi.org.br/cpc-openbim/oneclickpe-frontend
  docker rmi registry.certi.org.br/cpc-openbim/certikey-backend
  docker rmi registry.certi.org.br/cpc-openbim/certiio-backend
fi

if [ "$useHarbor" == "y" ]; then
  echo 'Baixando imagens do Harbor'
  docker pull registry.certi.org.br/cpc-openbim/oneclickpe-backend
  docker pull registry.certi.org.br/cpc-openbim/oneclickpe-frontend
  docker pull registry.certi.org.br/cpc-openbim/certikey-backend
  docker pull registry.certi.org.br/cpc-openbim/certiio-backend
  docker logout registry.certi.org.br
else
  echo 'Baixando imagens do docker hub'
  docker pull e5rq/repository:oneclickpe
  docker pull e5rq/repository:certikey
  docker pull e5rq/repository:certiio
  docker pull e5rq/repository:frontend
  docker logout
  docker tag e5rq/repository:oneclickpe registry.certi.org.br/cpc-openbim/oneclickpe-backend
  docker tag e5rq/repository:frontend registry.certi.org.br/cpc-openbim/oneclickpe-frontend
  docker tag e5rq/repository:certikey registry.certi.org.br/cpc-openbim/certikey-backend
  docker tag e5rq/repository:certiio registry.certi.org.br/cpc-openbim/certiio-backend
  docker rmi e5rq/repository:oneclickpe
  docker rmi e5rq/repository:certikey
  docker rmi e5rq/repository:certiio
  docker rmi e5rq/repository:frontend
fi

read -p 'Docker-compose up? (y/n)' yn
if [ "$yn" == "y" ]; then
  docker-compose -f i4sub-portal-PB.yml up
fi
