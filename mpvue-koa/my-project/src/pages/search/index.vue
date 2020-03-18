<template>
  <div class="search">
    <!-- 头部 -->
    <div class="head">
      <div>
        <img src="http://nos.netease.com/mailpub/hxm/yanxuan-wap/p/20150730/style/img/icon-normal/search2-2fb94833aa.png" alt="">
        <input type="text" confirm-type="search" focus="true" v-model="words" @focus="inputFocus" @input="tipsearch" @confirm="searchWords" placeholder="商品搜索">
        <img @click="clearInput" class="del" src="http://nos.netease.com/mailpub/hxm/yanxuan-wap/p/20150730/style/img/icon-normal/clearIpt-f71b83e3c2.png" alt="">
      </div>
      <div @click="cancel">取消</div>
    </div>

    <!-- 搜索提示 -->
    <div class="searchtips" v-if="words">
      <div v-if="tipsData.length !== 0">
        <div v-for="(item, index) in tipsData" :key="index" @click="searchWords" :data-value="item.name">
          {{item.name}}
        </div>
      </div>
      <div class="nogoods" v-else>暂无此类商品~</div>
    </div>

    <!-- 历史搜索 -->
    <div class="history" v-if="historyData.length!==0">
      <div class="t">
        <div>历史记录</div>
        <div @click="clearHistory"></div>
      </div>
      <div class="cont">
        <div v-for="(item, index) in historyData" :key="index" @click="searchWords" :data-value="item.keyword">
          {{item.keyword}}
        </div>
      </div>
    </div>

    <!-- 热门搜索 -->
    <div class="history hotsearch">
      <div class="t">
        <div>热门搜索</div>
      </div>
      <div class="cont">
        <div v-for="(item, index) in hotData" :key="index" :class="{active: 0 === index}" @click="searchWords" :data-value="item.keyword">
          {{item.keyword}}
        </div>
      </div>
    </div>

    <!-- 商品列表 -->
    <div class="goodsList" v-if="listData.length !== 0">
      <div class="sortlist">
        <div @click="goodsDetail(item.id)" class="item" v-for="(item, index) in listData" :key="index">
          <img :src="item.image" alt="">
          <p class="name">{{item.name}}</p>
          <p class="price">¥{{item.price}}</p>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { get, post } from '../../utils'
export default {
  data () {
    return {
      words: '',
      openid: '',
      hotData: [],
      historyData: [],
      tipsData: [],
      order: '',
      listData: []
    }
  },
  mounted () {
    this.openid = wx.getStorageSync('openId') || ''
    this.getHotData()
  },
  methods: {
    clearInput () {
      this.words = ''
      this.listData = []
    },

    cancel () {
      wx.navigateBack({
        delta: 1
      })
    },

    async clearHistory () {
      const data = await post('/search/clearhistoryAction', {
        openId: this.openid
      })
      if (data) {
        this.historyData = []
      }
    },

    inputFocus () {
      // 商品清空
      this.listData = []
      // 展示搜索提示信息
      this.tipsearch()
    },

    async tipsearch () {
      const data = await get('/search/helperaction', {
        keyword: this.words
      })
      this.tipsData = data.keywords
    },

    async searchWords (e) {
      // console.log(e)
      let value = e.currentTarget.dataset.value
      this.words = value || this.words
      const data = await post('/search/addhistoryaction', {
        openId: this.openid,
        keyword: value || this.words
      })
      // console.log(data)
      // 获取历史数据
      this.getHotData()
      this.getlistData()
    },

    async getHotData (first) {
      const data = await get('search/indexaction?openId=' + this.openid)
      this.historyData = data.historyData
      this.hotData= data.hotKeywordList
      // console.log(data)
    },

    // 获取商品列表
    async getlistData () {
      const data = await get('/search/helperaction', {
        keyword: this.words,
        order: this.order
      })
      this.listData = data.keywords
      this.tipsData = []
      // console.log(data)
    },

    goodsDetail (id) {
      wx.navigateTo({
        url: '/pages/goods/main?id=' + id
      })
        
    }
  }
}
</script>

<style lang="less" scoped>
@import './style.less';

</style>