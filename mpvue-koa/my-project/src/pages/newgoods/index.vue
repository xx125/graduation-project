<template>
  <div class="goodsList" v-if="listData.length !== 0">
    <div class="title">
      <span>———</span>
      <span>新品首发</span>
      <span>———</span>
    </div>
    <div class="sortlist">
      <div @click="goodsDetail(item.id)" class="item" v-for="(item, index) in listData" :key="index">
        <img :src="item.image" alt="">
        <p class="name">{{item.name}}</p>
        <p class="price">¥{{item.price}}</p>
      </div>
    </div>
  </div>
</template>

<script>
import { get } from '../../utils'

export default {
  data () {
    return {
      listData: []
    }
  },
  mounted () {
    this.openId = wx.getStorageSync('openId') || ''
    this.getData()
  },
  methods: {
    async getData () {
      const data = await get('/newgoods/detailAction', {
        openId: this.openId
      })
      this.listData = data.newgoods
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