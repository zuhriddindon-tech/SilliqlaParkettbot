SilliqlaParkettbot — ishga tushirish bo'yicha tez qo'llanma

1) Klonlash:
   git clone https://github.com/zuhriddindon-tech/SilliqlaParkettbot.git
   cd SilliqlaParkettbot
   git checkout fix/start-scripts

2) Konfiguratsiya:
   - .env faylini yarating: cp .env.example .env
   - .env ichiga haqiqiy BOT_TOKEN va boshqa credentiallarni kiriting.
   - Eslatma: hech qachon real tokenlarni commit qilmang. GitHub Actions Secrets yoki serverdagi /etc/... orqali saqlang.

3) Ishga tushirish (mahalliy yoki server):
   - Unix/Linux:
       chmod +x start.sh
       ./start.sh
   - Docker:
       docker-compose up --build -d

4) Xavfsizlik tavsiyalari:
   - BOT_TOKEN va boshqa credentiallarni GitHub Secrets yoki server muhit o'zgaruvchilarida saqlang.
   - Botni alohida system user bilan ishga tushiring (masalan, user: silliqla).
   - UFW yoki firewall orqali faqat kerakli portlarni oching.
   - Fail2ban, logrotate va monitoring qo‘shing.
   - Paket va OS yangilanishlarni muntazam bajaring.

5) Agar men PR ochishimni xohlasangiz:
   - Men fix/start-scripts branchga fayllarni qo'shib PR yuboraman.
   - Siz tekshirib merge qilishingiz mumkin. Mergedan keyin .env ni serverga qo‘ying yoki GitHub Actions Secrets orqali deploy qiling.
