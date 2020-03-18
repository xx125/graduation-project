<template>
  <div class="index">
    <!-- 头部的搜索 -->
    <div class="search">
      <div @click="toMappage">{{cityName}}</div>
      <div @click="toSearch">
        <input type="text" placeholder="搜索商品" />
        <span class="icon"></span>
      </div>
    </div>
    <!-- 轮播图 -->
    <div class="swiper">
      <swiper class="swiper-container" indicator-dots="true" autoplay="true" interval="3000" circular="trye" duration="500">
        <block v-for="(item, index) in banner" :key="index">
          <swiper-item class="swiper-item">
            <image class="slide-image" :src="item.image" />
          </swiper-item>
        </block>
      </swiper>
    </div>
    <!-- 选择堂食/外卖 -->
    <div class="channel">
      <div class="channel-item">
        <img src="../../../static/images/takeout.png" @click="food_takeout">
      </div>
      <div class="channel-item">
        <img src="../../../static/images/pickup.png" @click="food_pickup">
      </div>
      <button class="channel-item" open-type="share" hover-class="none">
        <img src="../../../static/images/share.png">
      </button>
    </div>
    <!-- 今日推荐 -->
    <div class="recommend">
      <div class="head">
        今日推荐
      </div>
      <div class="content">
        <div v-for="(item, index) in recommend" :key="index" @click="foodDetail(item.id)">
          <div>
            <p>{{item.name}}</p>
            <p class="price">{{item.price}}元</p>
          </div>
          <img :src="item.image" alt="">
        </div>
      </div>
    </div>
    <!-- 新品首发 -->
    <div class="newgoods">
      <div class="newgoods-top">
        <div class="top">
          <p>新品首发</p>
          <p @click="showall">查看全部</p>
        </div>
      </div>
      <div class="list">
        <ul>
          <scroll-view class="scroll-view" :scroll-x="true">
            <li v-for="(item, index) in newGoods" :key="index">
              <img :src="item.image" alt="">
              <p>{{item.name}}</p>
              <p>{{item.description}}</p>
              <p>¥ {{item.price}}</p>
            </li>
          </scroll-view>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import amapFile from '../../utils/amap-wx.js'
import { mapState, mapMutations } from 'vuex'
import { get } from '../../utils'
export default {
  data () {
    return {
      banner: [],
      recommend: [],
      newGoods: []
    }
  },
  computed: {
    ...mapState(['cityName'])
  },
  mounted () {
    this.getData()
    this.getCityName()
  },
  // 分享转发给好友
  onShareAppMessage: function (res) {
    // if (res.from === 'button') {
    //   // 来自页面内转发按钮
    //   console.log(res.target)
    // }
    return {
      title: '吃了吗？',
      // path: './index.vue'
      imageUrl: 'http://i.serengeseba.com/uploads/i_3_3479878675x3381393066_26.jpg'
    }
  },
  methods: {
    ...mapMutations(['update']),

    toMappage () {
      // 通过 wx.getSetting 先查询一下用户是否授权 "scoped.record"
      let _this = this
      wx.getSetting({
        success: (res) => {
          // 如果没有同意授权，让用户打开设置
          console.log(res)
          if (!res.authSetting['scope.userLocation']) {
            wx.openSetting({
              success: res => {
                // 获取授权位置信息
                _this.getCityName()
              }
            })
          } else {
            wx.navigateTo({
              url: '/pages/mappage/main',
            });
          }
        },
        fail: (err) => {
          console.log(err)
        },
        complete: () => {}
      });
        
    },

    getCityName () {
      let _this = this
      var myAmapFun = new amapFile.AMapWX({
        key:'a263c1a01cfeb3e63cd6af2f35901ae4'
      })
      myAmapFun.getRegeo({
        success: function (data) {
          // 成功回调
          console.log(data)
        },
        fail: function (info) {
          // 失败回调
          console.log(info)
          // _this.cityName = '北京'
          _this.update({ cityName: '北京'})
        }
      })
    },

    food_takeout () {
      wx.navigateTo({
        url: '/pages/food_takeout/main'
      })
    },
    food_pickup () {
      wx.navigateTo({
        url: '/pages/food_list/main'
      })
    },
    showall () {
      wx.navigateTo({
        url: '/pages/newgoods/main'
      })
    },

    foodDetail (id) {
      wx.navigateTo({
        url: '/pages/food_detail/main?id=' + id
      })
    },

    toSearch () {
      wx.navigateTo({
        url: '/pages/search/main'
      })
    },

    async getData () {
      const data = await get('/index/index')    /* 后段提供 http://localhost:1225/yhl/index/index 接口 */
      console.log(data)
      this.banner = data.banner
      this.recommend = data.recommend
      this.newGoods = data.newGoods
    }
  }
}
</script>

<style lang="less" scoped>
@import "./style.less";
</style>