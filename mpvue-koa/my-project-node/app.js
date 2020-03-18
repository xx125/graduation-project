const Koa = require('koa')
const app = new Koa()
const bodyparser = require('koa-bodyparser')
const config = require('./config')

// 解析请求体
app.use(bodyparser())

const router = require('./routes')
app.use(router.routes())

app.listen(config.port, () => {
    console.log(`server is started at port ${config.port}`)
})