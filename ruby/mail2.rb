require 'net/pop'
require 'base64'

def decode_subject(sub)
  if sub.to_s.include?("B?") or sub.to_s.include?("b?") then 
	sub.to_s.scan(/=\?(.*?)\?(B|b\?)(.*?)\?=/)
	decode_str = $3?Base64.decode64($3):''
	
	return decode_str.encode('utf-8',$1)
  elsif sub.to_s.include?("Q?") then 
	sub.to_s.scan(/=\?(.*?)\?(Q\?)(.*?)\?=/)
	decode_str = $3?$3.unpack("M").first : ' '
	#return decode_str.encode('utf-8',$1)
	return decode_str
  else
	return sub.grep(/Subject:\s/)[0].gsub(/Subject:\s/,'')
  end	
end

Net::POP3.start( 'pop.qq.com', 110,
                 '624906158@qq.com', '' ){  |pop|
  if pop.mails.empty? then
    puts 'no mail.'
  else
    i = 0
    pop.each_mail do |m|   # or "pop.mails.each ..."
      #File.open( 'inbox/' + i.to_s, 'w' ) {|f|
      #  f.write m.pop
      #}
      #m.delete
      i += 1
	  #puts m.header['Subject']
	  hdr = m.header
      # if hdr =~ /Subject: ([\w\s]+)/ then
      #  puts $1
      #end
	  subject = hdr.split('\r\n').grep(/^Subject:/).to_s
	  puts decode_subject(subject.split('\r\n').grep(/^Subject:/))
	  puts '---------------------------'
	  #puts hdr.encode('utf-8', 'gb2312')
	  #puts Base64.decode64(hdr).encode('gbk','utf-8')
	  # puts hdr
	 end
    puts "#{pop.mails.size} mails popped."
  end
}
