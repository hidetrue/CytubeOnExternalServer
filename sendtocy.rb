require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome # ブラウザ起動

driver.navigate.to 'https://cytube.xyz/login' # ログインページ

ctvid = "id"  # ログインID
ctvpass = "Password"  #　ログインパスワード
videourl = "VideoURL"  #　動画アドレス


# 表示待機時間
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until {driver.find_element(:xpath, '/html/body/div/section/div/div/form/button').displayed?}

# 入力、ログインボタンクリック

 driver.find_element(:xpath, '/html/body/div/section/div/div/form/div[1]/input').send_keys ctvid
 driver.find_element(:xpath, '/html/body/div/section/div/div/form/div[2]/input').send_keys ctvpass
 driver.find_element(:xpath, '/html/body/div/section/div/div/form/button').click

sleep 1

 driver.navigate.to 'cytubeURL' # 動画ページ移動

sleep 3

# 表示待機時間
 wait = Selenium::WebDriver::Wait.new(:timeout => 10)
 wait.until {driver.find_element(:id, 'showmediaurl').displayed?}

# 動画登録フォーム表示ボタン
driver.find_element(:id, 'showmediaurl').click

sleep 1

# 動画登録
element = driver.find_element(:id, 'mediaurl')
element.send_keys videourl
driver.find_element(:id, 'queue_next').click

driver.quit # ブラウザ終了
