from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time

# Set Chrome options for downloads
chrome_options = Options()
prefs = {"profile.default_content_settings.popups": 0,    
        "download.default_directory":r"C:\Users\MY Laptop\Desktop\guvi_class\web scrape", ### Set the path accordingly
        "download.prompt_for_download": False, ## change the downpath accordingly
        "download.directory_upgrade": True}
chrome_options.add_experimental_option("prefs", prefs)
driver = webdriver.Chrome(options=chrome_options)

# Navigate to the page
driver.get('https://cricsheet.org/matches/')
driver.find_element(By.XPATH,'//*[@id="main"]/div[3]/dl/dd[2]/a[1]').click()
driver.find_element(By.XPATH,'//*[@id="main"]/div[3]/dl/dd[4]/a[1]').click()
driver.find_element(By.XPATH,'//*[@id="main"]/div[3]/dl/dd[6]/a[1]').click()
driver.find_element(By.XPATH,'//*[@id="main"]/div[3]/dl/dd[19]/a[1]').click()

# Wait for download to complete (optional)
time.sleep(60)

# Close the browser
driver.quit()