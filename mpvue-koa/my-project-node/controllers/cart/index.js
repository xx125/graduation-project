const { mysql } = require('../../mysql')

async function detailAction (ctx) {
  const openId = ctx.query.openId

   const carts = await mysql('cart').where({
    'user_id': openId
  }).select()

    // 判断用户的购物车里是否有该商品
    const oldNumber = await mysql('cart').where({
      'user_id': openId,
    }).column('number').select()
    let allnumber = 0
    if (oldNumber.length > 0) {
      for (let i = 0; i < oldNumber.length; i++) {
        const element = oldNumber[i]    // {number: 1}
        allnumber += element.number
      }
    }

  ctx.body = {
    'carts': carts,
    'allnumber': allnumber
  }
}

async function addCart (ctx) {
  const { openId, goodsId, number } = ctx.request.body

  // 判断购物车是否已含有该商品
  const haveGoods = await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).select()

  if (haveGoods.length === 0) {
    const goods = await mysql('food').where({
      'id': goodsId
    }).select()
    // console.log(goods)
    // 如果不存在
    const { price, name, image } = goods[0]
    await mysql('cart').insert({
      'user_id': openId,
      'goods_id': goodsId,
      'goods_name':name,
      number,
      price,
      image
    })
  } else {
    const oldNumber = await mysql('cart').where({
      'user_id': openId,
      'goods_id': goodsId
    }).column('number').select()
    await mysql('cart').where({
      'user_id': openId,
      'goods_id': goodsId
    }).update({
      'number': oldNumber[0].number + 1
    })
  }
  ctx.body = {
    data: 'add'
  }
}

async function reduceCart (ctx) {
  const { openId, goodsId, number } = ctx.request.body
  const oldNumber = await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).column('number').select()
  await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).update({
    'number': oldNumber[0].number - 1
  })
  ctx.body = {
    data: 'reduce'
  }
}

async function addAction (ctx) {
  const { openId, cartId } = ctx.request.body
  // console.log(openId, cartId)

  const cartnumber = await mysql('cart').where({
    'user_id': openId,
    'id': cartId
  }).column('number').select()
  await mysql('cart').where({
    'user_id': openId,
    'id': cartId
  }).update({
    'number': cartnumber[0].number + 1
  })
  ctx.body = {
    data: 'add',
    cartnumber
  }
}

async function reduceAction (ctx) {
  const { openId, goodsId, cartId } = ctx.request.body

  const cartnum = await mysql('cart').where({
    'user_id': openId,
    'id': cartId
  }).column('number').select()
  // console.log('...' + cartnum[0].number)

  if (cartnum[0].number > 1) {
    const cartnumber = await mysql('cart').where({
      'user_id': openId,
      'id': cartId
    }).column('number').select()
    await mysql('cart').where({
      'user_id': openId,
      'id': cartId
    }).update({
      'number': cartnumber[0].number - 1
    })
  } else {
    const cartnumber = await mysql('cart').where({
      'user_id': openId,
      'id': cartId
    }).del()
  }
  ctx.body = {
    data: 'reduce'
  }
}


async function deleteCart (ctx) {
  const openId = ctx.request.body.openId
  // console.log(openId)
  const data = await mysql('cart').where({
    'user_id': openId
  }).del()
  if (data) {
    ctx.body = {
      'data': '清空成功'
    }
  } else {
    ctx.body = {
      'data': null
    }
  }
}

module.exports = {
  addCart,
  reduceCart,
  addAction,
  reduceAction,
  detailAction,
  deleteCart
}