# coding: utf-8
require 'iconv'
require 'open-uri'
require 'time'
require 'uri'
require 'fileutils'

#图片类型
image_type = ['gif']
#脚本路径
location = File.dirname(__FILE__)
#下载相对路径
sub_dir = '/open-uri1'
#下载绝对路径
download_dir = location + sub_dir
#获取地址
fetch_url =""

#搜索所有链接
def collectLinkUrls(url)
	uri = URI(url)
	base = uri.scheme.to_s
	base += "://"
	base += uri.host.to_s+"/"
	arr_all = []
	open(URI::encode(url)) do |html|
	
		html.each_line{|line| 
			arr = line.scan(/(viewthread\.php[\S]*)\"\>/)
			# 2D Array
			arr.each {|item| 
				#puts item
				arr_all << (base + item[0].sub(/\&amp\;/,'&'))
			}
		}
		
	end
	arr_all.uniq!
	arr_all
end

#搜集指定链接的图片链接
def  collectImageUrls(url)
	puts Iconv.iconv("GBK","utf-8","正在获取图片下载列表...")
	puts "正在获取图片下载列表..."
	arr_all = []
	open(URI::encode(url)) do |html|
		html.each_line{|line| 
			arr = line.scan(/(http:\/\/[^\<\>\\\'\"]*?\.(jpg|jpeg|png))/)
			# 2D Array
			arr.each {|item| 
				arr_all <<item[0]
			}
		}
	end
	arr_all.uniq!
	puts Iconv.iconv("GBK","utf-8","获取下载列表成功...")
	arr_all
end

#从链接数组中下载（单线程）
def downFromUrls(arr_url, download_dir)
   if !Dir.exists?(download_dir) then 
		#Dir.mkdir(download_dir)
		FileUtils.makedirs(download_dir)
   end
	
	arr_url.each do |url|
		canDownload = true
		#print url
		begin
			data = open(url){|f| f.read }
			canDownload = false if data.size==0
		rescue 
			puts Iconv.iconv("GBK","utf-8","Bad...")[0]+Iconv.iconv("GBK","utf-8",url)[0]
			canDownload = false
		end
		
		if canDownload then
			type = url[url.rindex(".")..-1]
			file = File.new(download_dir+'/'+Time.new.nsec.to_s+type , 'w+')
			file.binmode
			file << data
			file.flush
			file.close
			puts Iconv.iconv("GBK","utf-8","OK...")[0]+Iconv.iconv("GBK","utf-8",url).to_s[0]
		end
	end
end

#从链接数组中下载（多线程）
def downFromUrlsEx(arr_url, download_dir)
	 if !Dir.exists?(download_dir) then 
		#Dir.mkdir(download_dir)
		FileUtils.makedirs(download_dir)
	 end
	d_threads = []
	#多线程
	print arr_url.length,"\n"
	for url in arr_url do 
		d_threads << Thread.new(url) do |url|
			#rand = Random.new
			#sleep( rand.rand *5)
			canDownload = true
			#print url

			begin
				data = open(url){|f| f.read }
				canDownload = false if data.size==0
			rescue 
				puts Iconv.iconv("GBK","utf-8","Bad...")[0]+Iconv.iconv("GBK","utf-8",url)[0]
				canDownload = false
			end
			
			if canDownload then
				type = url[url.rindex(".")..-1]
				file = File.new(download_dir+'/'+Time.new.nsec.to_s+type , 'w+')
				file.binmode
				file << data
				file.flush
				file.close
				puts Iconv.iconv("GBK","utf-8","OK...")[0]+Iconv.iconv("GBK","utf-8",url)[0]
			end
		end
	end
	d_threads.each{|t| t.join}
end

#删除空文件夹
def delNullDir(download_dir)
	puts '删除空文件夹'
	count = 0
	Dir.entries(download_dir).each{|item|
		cur = download_dir+'/'+item
		if File.directory?(cur) && Dir.entries(cur).size <= 2
			FileUtils.rm_r cur
			count = count+1
		end
	}
	puts '共删除'+count.to_s+'个空文件夹'
end

#downFromUrlsEx collectImageUrls(fetch_url) ,download_dir
puts download_dir
all_links = collectLinkUrls(fetch_url)
all_links.each do |link|
	uri = URI(link)	
	dir = download_dir.to_s + "/"+uri.query[4..9].to_s
	puts dir
	downFromUrlsEx collectImageUrls(link) ,dir
end
puts Iconv.iconv("GBK","utf-8","下载成功...")
