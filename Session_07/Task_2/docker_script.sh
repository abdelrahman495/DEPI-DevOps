#!/bin/bash

echo "1) List all containers"
echo "2) List running containers"
echo "3) List all images"
echo "4) Run a container"
echo "5) Stop a container"
echo "6) Remove a container"
echo "7) Remove an image"
echo "8) Remove all unused images"
echo "9) Remove all stopped containers"
echo "10) Remove all containers"
echo "11) Remove all images"
echo "12) Pull an image"
echo "13) Exit"
echo ""

while true;
do
    read -p "Select an operation: " operation

    case $operation in
        1) docker ps -a ;;
        2) docker ps ;;
        3) docker images ;;
        4) read -p "Enter optional container name: " container_name
           read -p "Enter optional host port: " host_port
           read -p "Enter optional container port: " container_port
           port_mapping=""
           if [ -n "$host_port" ] && [ -n "$container_port" ];
	   then
               port_mapping="-p ${host_port}:${container_port}"
           fi
           read -p "Enter image name: " image_name
           read -p "Enter image tag (empty for latest): " image_tag
           docker run -d ${container_name:+--name $container_name} ${port_mapping} ${image_name}:${image_tag:-latest} ;;
        5) read -p "Enter container ID or name to stop: " container_id
           docker stop $container_id ;;
        6) read -p "Enter container ID or name to remove: " container_id
           docker rm $container_id ;;
        7) read -p "Enter image ID or name to remove: " image_id
           read -p "Enter image tag (empty for latest): " image_tag
           docker rmi ${image_id}:${image_tag:-latest} ;;
        8) docker image prune -a ;;
        9) docker container prune ;;
        10) docker rm -f $(docker ps -aq) ;;
        11) docker rmi -f $(docker images -aq) ;;
        12) read -p "Enter image name to pull: " image_name
            read -p "Enter image tag (empty for latest): " image_tag
            docker pull $image_name:${image_tag:-latest} ;;
        13) echo "Exiting..."; break ;;
        *) echo "Invalid operation" ;;
    esac

    echo ""
done

