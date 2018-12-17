waittime=10
docker run --rm --name artifactory -v /pipelines/artifactory:/var/opt/jfrog/artifactory -p 8081:8081 -d docker.bintray.io/jfrog/artifactory-oss:latest
echo "Please log in to Artifactory and setup a generic-local db"
read -n 1 -s -r -p "Press any key to continue"

response=$(curl -u admin:puppetlabs http://localhost:8081/artifactory/api/security/users/apiKey)
response=$(curl -X POST -u admin:puppetlabs http://localhost:8081/artifactory/api/security/apiKey)
echo "APIKEY = $response"

echo "Starting MYSQL"
docker run --rm --name mysql -v /cd4pe/mysql:/var/lib/mysql --env-file mysql.env -p 3306:3306 -d mysql/mysql-server:5.7
echo "Waiting for 5"
sleep 5
echo "Starting CD4PE"
docker run --rm --name pfa --env-file cd4pe.env -p 8080:8080 -p 8000:8000 -p 7000:7000 -d puppet/continuous-delivery-for-puppet-enterprise:latest
