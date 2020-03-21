const { mysql } = require('../../mysql')

async function foodDetail (ctx) {
  const list = await mysql('list').orderBy('id', 'asc').select()
  const goods = await mysql('food').select()
  ctx.body = {
    list,
    goods
  }
}

module.exports = {
  foodDetail
}