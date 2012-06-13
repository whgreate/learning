#coding:utf-8
require 'net/smtp'


print 'please enter you password for 624906158@qq.com: '
passwd = gets
#content ='中文'.encode('gbk','utf-8')
content ='中文'

msg = <<EndOfMail,'624906158@qq.com','624906158@qq.com'
From: Ruby
To:
Date:
Subject: ruby mail test #{content}
Hi,Wanghui!
EndOfMail
 
    Net::SMTP.start('smtp.qq.com', 25, 'qq.com', "624906158@qq.com", passwd, :login) do |smtp| #此处配置发送服务器及账户
    smtp.send_message msg, '624906158@qq.com', '18810609189@139.com'
  end
