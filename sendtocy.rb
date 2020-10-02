cyid = "userid"  # ログインID
cypass = "userpassword"  #　ログインパスワード
videoarray = video_array #動画配列データ
channel = "channel"  #　Cytubeチャンネル

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome # ブラウザ起動

driver.navigate.to 'https://cytube.xyz/login' # ログインページ

# 表示待機時間
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until {driver.find_element(:xpath, '/html/body/div/section/div/div/form/button').displayed?}

# 入力、ログインボタンクリック

 driver.find_element(:xpath, '/html/body/div/section/div/div/form/div[1]/input').send_keys cyid
 driver.find_element(:xpath, '/html/body/div/section/div/div/form/div[2]/input').send_keys cypass
 driver.find_element(:xpath, '/html/body/div/section/div/div/form/button').click

sleep 1

 driver.navigate.to 'https://cytube.xyz/r/' + channel  # 動画ページ移動

sleep 3

# 動画登録

videoarray.each do |videourl|
  
scriptQueue = <<EOS
const data = parseMediaLink('#{videourl}')

socket.emit('queue', {
  duration: undefined,
  pos: "end",
  temp: true,
  title: undefined,
  id: data.id,
  type: data.type,
  stime: data.stime
});
EOS

driver.execute_script(scriptQueue)
end

driver.quit # ブラウザ終了
