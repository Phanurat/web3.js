# ใช้ Node.js official image เป็น base image (ในตัวอย่างนี้ใช้เวอร์ชัน 18)
FROM node:18

# ตั้ง working directory ภายใน container
WORKDIR /usr/src/app

# คัดลอกไฟล์ package.json และ package-lock.json (ถ้ามี) ไปยัง working directory
COPY package*.json ./

# ติดตั้ง dependencies
RUN npm install

# ถ้ามีการใช้ production build สำหรับ dependencies ใช้คำสั่งนี้แทน:
# RUN npm ci --only=production

# คัดลอกไฟล์ทั้งหมดจาก local ไปยัง container
COPY . .

# เปิดพอร์ตที่แอปพลิเคชันจะรัน
EXPOSE 3000

# รันคำสั่งเพื่อเริ่มต้นแอป
CMD ["node", "server.js"]
