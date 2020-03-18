const { mysql } = require('../../mysql')

// 获取搜索历史
async function indexAction (ctx) {
  const openId = ctx.query.openId
  // 取出默认关键字
  const defaultKeyword = await mysql('keywords').where({
    is_default: 1
  }).limit(1).select()
  // 取出热门关键字
  const hotKeywordList = await mysql('keywords').distinct('keyword').column('keyword', 'is_hot').limit(10).select()
  //取出搜索历史 
  const historyData = await mysql('search_history').where({
    'user_id': openId
  }).orderBy('add_time', 'desc').limit(10).select()
  ctx.body = {
    'defaultKeyword': defaultKeyword[0],
    'hotKeywordList': hotKeywordList,
    'historyData': historyData
  }
}

// 搜索时匹配相关内容
async function helperAction (ctx) {
  const keyword = ctx.query.keyword
  // console.log(keyword)
  var order = ctx.query.order
  if (!order) {
    order = '',
    orderBy = 'id'
  } else {
    orderBy = 'price'
  }
  const keywords = await mysql('food').orderBy(orderBy, order).column('id', 'name', 'image', 'price')
  .where('name', 'like', '%' + keyword + '%').limit(10).select()
  if (keywords) {
    ctx.body = {
      keywords
    }
  } else {
    ctx.body = {
      keywords: []
    }
  }
}

// 添加搜索历史
async function addHistoryAction (ctx) {
  const {openId, keyword} = ctx.request.body

  const oldData = await mysql('search_history').where({
    'user_id': openId,
    'keyword': keyword
  })
  if (oldData.length == 0) {
    const data = await mysql('search_history').insert({
      'user_id': openId,
      'keyword': keyword,
      'add_time': parseInt(new Date().getTime() / 1000)
    })
    if (data) {
      ctx.body = {
        data: 'success'
      }
    } else {
      data: 'fail'
    }
  } else {
    // ctx.body = {
    //   data: '已经有记录了'
    // }
    const data = await mysql('search_history').where({
      'user_id': openId,
      'keyword': keyword
    }).del()
    const newdata = await mysql('search_history').insert({
      'user_id': openId,
      'keyword': keyword,
      'add_time': parseInt(new Date().getTime() / 1000)
    })
  }
}

// 清除搜索历史
async function clearHistoryAction (ctx) {
  const openId = ctx.request.body.openId
  // console.log(openId)
  const data = await mysql('search_history').where({
    'user_id': openId
  }).del()
  if (data) {
    ctx.body = {
      'data': '清除成功'
    }
  } else {
    ctx.body = {
      'data': null
    }
  }
}


module.exports = {
  indexAction,
  helperAction,
  addHistoryAction,
  clearHistoryAction
}