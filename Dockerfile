# Sử dụng một image chính thức của Node.js để build ứng dụng
FROM node:16 AS build

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép file package.json và package-lock.json vào container
COPY package*.json ./

# Cài đặt các dependencies
RUN npm install --legacy-peer-deps

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Build ứng dụng React cho production
RUN npm run build

# Giai đoạn thứ hai: Sử dụng một image Nginx để phục vụ ứng dụng React
FROM nginx:alpine

# Sao chép thư mục build từ giai đoạn build Node.js sang thư mục HTML của Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose cổng mà Nginx sẽ sử dụng (thường là 80)
EXPOSE 80

# Khởi động Nginx khi container chạy
CMD ["nginx", "-g", "daemon off;"]


#  docker build -t frontend-ecomerce-final-v1 .
#  docker run -p 80:80 frontend-ecomerce-final-v1

#docker login
#docker tag frontend-ecomerce-final-v1 minhduyyy/frontend-ecomerce-final-v1:lastest
#docker push minhduyyy/frontend-ecomerce-final-v1:lastest

#docker pull minhduyyy/frontend-ecomerce-final-v1:lastest
#docker run -p 3000:80 frontend-ecomerce-final-v1