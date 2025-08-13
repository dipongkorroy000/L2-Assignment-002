# L2-Assignment-002



1. What is PostgreSQL?
Ans: PostgreSQL একটি ওপেন-সোর্স object-relational ডেটাবেস সিস্টেম এবং SQL স্ট্যান্ডার্ড 



2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
Ans:
* Primary Key: একটি টেবিলের প্রতিটি row কে ইউনিকভাবে চিহ্নিত করে।
* Foreign Key: অন্য একটি টেবিলের Primary Key কে রেফার করে, যাতে টেবিলগুলোর মধ্যে সম্পর্ক তৈরি হয়


4. Explain the purpose of the WHERE clause in a SELECT statement.
Ans: - WHERE ক্লজ ব্যবহার করে নির্দিষ্ট শর্ত অনুযায়ী ডেটা ফিল্টার করা হয়।
SELECT * FROM users WHERE age > 18;

5. What are the LIMIT and OFFSET clauses used for?
Ans: 
* LIMIT: কতটি row রিটার্ন হবে তা নির্ধারণ করে।
* OFFSET: কতটি row স্কিপ করে তারপর রিটার্ন শুরু হবে তা নির্ধারণ করে।


6. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
Ans: - JOIN ব্যবহার করে একাধিক টেবিলের ডেটা একত্রে দেখানো যায়, যেখানে তাদের মধ্যে সম্পর্ক থাকে।
SELECT * FROM orders JOIN customers ON orders.customer_id = customers.id;
