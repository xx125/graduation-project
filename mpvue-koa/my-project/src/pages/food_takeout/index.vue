<template>
  <div class="index">
    <!-- 头部搜索 -->
    <div class="search">
      <div @click="toSearch">
        <input type="text" placeholder="搜索商品" />
        <span class="icon"></span>
      </div>
    </div>
    <!-- 菜单 -->
    <div class="food">
      <scroll-view class="left_menu" scroll-y>
        <div class="menu_ul">
          <div class="menu_item" v-for="(item,index) in list" :class="index===currentIndex ? 'current' : ''" :key="index" @tap="selectMenu(index)">
            {{item.name}}
          </div>
        </div>
      </scroll-view>
      <scroll-view scroll-y :scroll-into-view="contentId" scroll-with-animation="true" class="right_content">
        <div class="goods_group">
          <div>
          <div class="goods_title" v-for="(item, index) in list" :key="index">
            <div class="category">{{item.name}}</div>
            <div>
              <div v-for="(item,i) in goods" :id="'con_'+i" class="goods_list" :key="i">
                <div class="img">
                  <img class="image" :src="item.image" mode="widthFix">
                </div>
                <div class="content">
                  <div class="name">{{item.name}}</div>
                  <div class="desc">{{item.description}}</div>
                  <div class="extra">
                    <span class="count">月售{{item.sellCount}}份</span>
                    <span>好评率{{item.rating}}%</span>
                  </div>
                  <div class="price">
                    <span class="now">¥{{item.price}}</span>
                    <span class="old" v-if="item.oldPrice">¥{{item.oldPrice}}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          </div>
        </div>
      </scroll-view>
    </div>
  </div>
</template>

<script>
import { get, post } from '../../utils'
export default{
  data() {
    return {
      list:[],
      goods: [],
      contentId: '', // 每个food-list的id，scroll-into-view滚动到对应的id
      navId: '', // 导航模块对应的id，用来联动内容区域
      currentIndex: 0,
      navulHeight: 0, // 导航里ul高度
      navItemHeight: 0, // 每个导航高度
      listHeight: [], // foods内部块的高度
      contentHeight: [], // 内容区域scroll-view高度
    }
  },
  watch: {
    currentIndex() {
      console.log(this.currentIndex)
      if (this.contentHeight < this.navulHeight) {
        let h = this.currentIndex * this.navItemHeight
        if (h > this.contentHeight) {
          // 导航滑动
          this.navId = `nav_${this.currentIndex}`
        } else {
          this.navId = 'nav_0'
        }
      }
    }
  },
  mounted () {
    this.getData()
  },
  methods: {
    async getData () {
      const data = await get('/food/index')
      console.log(data)
      this.list = data.list
      this.goods = data.goods
    },
    toSearch () {
      wx.navigateTo({
        url: '/pages/search/main'
      })
    },
    selectMenu(index) {
      this.contentId = `con_${index}`
      this.navId = `nav_${index}`
      this.currentIndex = index
    },
    onScroll(e) {
      this.contentId = ''
      let scrollTop = e.target.scrollTop
      // console.log(scrollTop)
      let length = this.listHeight.length
      if (scrollTop >= this.listHeight[length - 1] - this.contentHeight) {
        return
      } else if (scrollTop > 0 && scrollTop < this.listHeight[0]) {
        this.currentIndex = 0
      }
      for (let i = 0; i < length; i++) {
        if (scrollTop >= this.listHeight[i - 1] && scrollTop < this.listHeight[i]) {
          this.currentIndex = i
        }
      }
      // console.log(this.currentIndex)
    },
    getFoodHeight() {
      var query = wx.createSelectorQuery()
      let h = 0
      query.selectAll('.goods_list').boundingClientRect((rects) => {
        // console.log(rects)
        rects.forEach((rect) => {
          h += rect.height
          this.listHeight.push(h)
        })
        // console.log(this.listHeight)
      })
      query.select('.right_content').boundingClientRect((rect) => {
        this.contentHeight = rect.height
      })
      query.select('.menu_ul').boundingClientRect((rect) => {
        this.navulHeight = rect.height
      })
      query.select('.menu_item').boundingClientRect((rect) => {
        this.navItemHeight = rect.height
      }).exec()
    }
  },
  watch: {
    goods() {
      // 获取模块高度，即food-list
      setTimeout(() => {
        this.getFoodHeight()
      }, 60)
    }
  }
}
</script>

<style lang="less" scoped>
@import './style.less';
</style>