require 'fileutils'
require 'net/http'
require 'uri'
require 'iconv'
require 'UniversalDetector'

#脚本路径
location = File.dirname(__FILE__)

#下载相对路径
sub_dir = '/open-uri'

#下载绝对路径
download_dir = location + sub_dir

def test1(download_dir)
	print '-----', download_dir, "\n"
	if !Dir.exists?(download_dir) then 
		#Dir.mkdir(download_dir)
		FileUtils.makedirs(download_dir)
	end
end

#删除空文件夹
def delNullDir(download_dir)
	puts '删除空文件夹'
	count = 0
	Dir.entries(download_dir).each{|item|
		cur = download_dir+'/'+item
		if File.directory?(cur) && Dir.entries(cur).size <= 2
			FileUtils.rm_r cur
			count=count+1
		end
	}
	puts '共删除'+count.to_s+'个空文件夹'
end

#使用net/http下载
uri = URI('http://www.baidu.com/s?wd=dd&rsv_spt=1&issp=1&rsv_bp=0&ie=utf-8&tn=baiduhome_pg&inputT=628')
Net::HTTP.start(uri.host, uri.port) do |http|
	response = Net::HTTP.get_response(uri)
	puts "*****************************"
	#puts response.body
	html = response.body
	html.each_line{|line| 
	#<title>*?<\/title>
			arr = line.scan(/(\<title\>[^\n\r]*\<\/title\>)/)
			# 2D Array
			arr.each {|item| 
			
				puts item[0]
				puts UniversalDetector::chardet(html)
				puts Iconv.iconv("utf-8","GBK",item[0])
			}
		}

	puts "*****************************"
end

#test1 download_dir
#FileUtils.rm_r download_dir
print Dir.entries(download_dir).size
Dir.entries(download_dir).each{|item|
	#print item,"\n" if File.file?(download_dir+'/'+item)
	print item,"\n" if File.directory?(download_dir+'/'+item)
	}

#delNullDir(download_dir)
print 'ok'

