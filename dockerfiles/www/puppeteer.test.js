const puppeteer = require('puppeteer')
const screenshot = 'amazon_nyan_cat_pullover.png'
try {
  (async () => {
    const browser = await puppeteer.launch({
        args: [
            // Required for Docker version of Puppeteer
            '--no-sandbox',
                '--disable-setuid-sandbox',
            // This will write shared memory files into /tmp instead of /dev/shm,
            // because Docker’s default for /dev/shm is 64MB
            '--disable-dev-shm-usage'
        ]
    })
    const page = await browser.newPage()
    await page.setViewport({ width: 1280, height: 800 })
    await page.goto('https://angular.cn')
    await page.waitForSelector('.promo-4')
    await page.screenshot({path: 'amazon_nyan_cat_pullovers_list.png'})
    await browser.close()
    console.log('See screenshot: ' + screenshot)
  })()
} catch (err) {
  console.error(err)
}
// https://github.com/GoogleChrome/puppeteer/tree/master/examples