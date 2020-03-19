<template>
  <div class="detailWrapper">
    <img :src="info.image" class="image" />
    <div class="info">
      <div class="title">{{info.name}}</div>
      <div class="collection"></div>
      <div class="desc">
        <span>月售{{info.sellCount}}</span>
        <span>好评率{{info.rating}}%</span>
      </div>
      <div class="price">
        <span class="unit">￥</span>
        {{info.price}}
        <span class="oldPrice" v-show="info.oldPrice">￥{{info.oldPrice}}</span>
      </div>
      <div class="shopCart">
        <transition name="fade">
          <!-- <div class="text" @click="addCart($event)" v-show="!food.count">加入购物车</div> -->
          <div class="text">+</div>
        </transition>
      </div>
    </div>
    <div class="divider"></div>
    <div class="desc">
      <div class="title">商品介绍</div>
      <div class="content">{{info.description}}</div>
    </div>
    <div class="divider"></div>

    <!-- 评价 -->
    <!-- <div class="evaluation">
          <div class="title">
            商品评价
          </div>
          <div class="classify">
            <span v-for="(item,index) in classifyArr" :key="index" class="item" :class="{'active':item.active,'bad':index==2,'badActive':item.active&&index==2}" @click="filterEvel(item)">
              {{item.name}}<span class="count">{{item.count}}</span>
            </span>
          </div>
          <div class="switch" @click="evelflag=!evelflag">
            <span class="icon-check_circle" :class="{'on':evelflag}"></span>
            <span class="text">只看有内容的评价</span>
          </div>
          <div class="evel-list">
            <ul>
              <li class="evel" v-for="(item, index) in rate" :key="index">
                <div class="userInfo">
                  <div class="time">{{evel.rateTime | time}}</div>
                  <div class="user">
                    <span>{{evel.username}}</span>
                    <span class="avatar"><img :src="evel.avatar" width="12" height="12"></span>
                  </div>
                </div>
                <div class="content">
                  <span class="icon" :class="evel.rateType?'icon-thumb_down':'icon-thumb_up'"></span>
                  <span class="text">{{evel.text}}</span>
                </div>
              </li>
            </ul>
          </div>
    </div>-->

    <div class="comment-list">
      <div>商品评价</div>
      <div class="tag">
        <div @click="good(index)" :class="{choose:gooddisplay==1}">推荐</div>
        <div @click="bad(index)" :class="{choose:baddisplay==1}">吐槽</div>
      </div>

      <div v-show="gooddisplay==1">
        <div class="item-c" v-for="(item, index) in goodcomm" :key="index">
          <div class="item-l">
            <img :src="item.useravatar" />
          </div>
          <div class="item-r">
            <div class="h-r">
              <div class="r-t">
                <span class="name">{{item.username}}</span>
                <span class="date">{{item.rateTime}}</span>
              </div>
              <!-- <div class="r-b">
                  <div class="b-l">
                    <i class="icon mt-star-s" v-for="(itx, idx) in stars" :key="idx"></i>
                  </div>
              </div>-->
            </div>
            <div class="r-comtent">
              <span>{{item.text}}</span>
            </div>
            <div class="r-imgs">
              <img :src="item.commImg" />
              <span :class="item.rateType=='推荐' ? 'good' : 'bad'">{{item.rateType}}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-show="baddisplay==1">
        <div class="item-c" v-for="(item, index) in badcomm" :key="index">
          <div class="item-l">
            <img :src="item.useravatar" />
          </div>
          <div class="item-r">
            <div class="h-r">
              <div class="r-t">
                <span class="name">{{item.username}}</span>
                <span class="date">{{item.rateTime}}</span>
              </div>
              <!-- <div class="r-b">
                  <div class="b-l">
                    <i class="icon mt-star-s" v-for="(itx, idx) in stars" :key="idx"></i>
                  </div>
              </div>-->
            </div>
            <div class="r-comtent">
              <span>{{item.text}}</span>
            </div>
            <div class="r-imgs">
              <img :src="item.commImg" />
              <span :class="item.rateType=='推荐' ? 'good' : 'bad'">{{item.rateType}}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-show="alldisplay==1">
        <div class="item-c" v-for="(item, index) in allcomments" :key="index">
          <div class="item-l">
            <img :src="item.useravatar" />
          </div>
          <div class="item-r">
            <div class="h-r">
              <div class="r-t">
                <span class="name">{{item.username}}</span>
                <span class="date">{{item.rateTime}}</span>
              </div>
              <!-- <div class="r-b">
                  <div class="b-l">
                    <i class="icon mt-star-s" v-for="(itx, idx) in stars" :key="idx"></i>
                  </div>
              </div>-->
            </div>
            <div class="r-comtent">
              <span>{{item.text}}</span>
            </div>
            <div class="r-imgs">
              <img :src="item.commImg" />
              <span :class="item.rateType=='推荐' ? 'good' : 'bad'">{{item.rateType}}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- meituan 底部购物车代码 -->
    <div class="footer" @click="showType">
      <!-- <div class="footer-c" v-if="pageIndex === 0"> -->
      <!-- <div class="c-t">
          <span>{{reduceTip}}</span>
      </div>-->
      <div class="footer-wrapper">
        <div class="container">
          <!-- <span class="price" v-if="totalPrice > 0 || productCount > 0"> -->
          <div class="price">
            ￥
            <span>15.9</span>
            <!-- <span>{{totalPrice}}</span> -->
          </div>
          <div class="container-con">
            <span class="container-tai">另需配送费￥9元</span>
            <div class="container-ner"></div>
            <span class="container-last">支持自取</span>
          </div>
        </div>
        <!-- <div
          class="container-price"
          :style="{'background-color': btnTitle === '去结算' ? '#F0D179' : '#2F2F2F'}"
          @click="orderClick"
        >-->
        <div class="container-price">
          <!-- <span :style="{color: btnTitle === '去结算' ? '#333' : '#666'}">{{btnTitle}}</span> -->
          <span>15元起送</span>
        </div>
      </div>
      <div class="cart">
        <!-- <img
          mode="widthFix"
          :src="productCount > 0 ? '../../../static/images/ic_menu_shoping_nor.png' : '../../../static/images/ic_menu_shoping_pressed.png'"
        />-->
        <img src="../../../static/images/ic_menu_shoping_nor.png" />
        <span v-if="productCount > 0">{{productCount}}</span>
      </div>
    </div>

    <!-- 购物车弹出层 -->
    <div class="pop" v-show="showpop" @click="showType"></div>
    <div class="attr-pop" :class="[showpop ? 'fadeup' : 'fadedown']">
      <div class="top">
        <div class="close">
          <img src="../../../static/images/del-address.png" alt />
          <span>清空购物车</span>
        </div>
        <div class="shopcart">
          <div class="left">
            <img :src="info.image" alt />
          </div>
          <div class="right">
            <div>
              <p>{{info.name}}</p>
              <p>¥{{info.price}}</p>
              <div class="count">
                <div class="cut" @click="reduce">-</div>
                <input type="text" class="number" v-model="number" disabled="false" />
                <div class="add" @click="add">+</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import BScroll from "better-scroll";
import { get, post } from "../../utils";

export default {
  data() {
    return {
      id: "",
      openId: "",
      info: {},
      showpop: false,
      number: 0,
      gooddisplay: 0,
      baddisplay: 0,
      alldisplay:1,
      goodcomm:[],
      badcomm:[],
      allcomments: []
      // showDetail: false,
      // classifyArr: [{
      //   name: '全部',
      //   count: this.food.ratings.length,
      //   active: true
      // }, {
      //   name: '好评',
      //   count: this.food.ratings.filter((data) => data.rateType === 0).length,
      //   active: false
      // }, {
      //   name: '差评',
      //   count: this.food.ratings.filter((data) => data.rateType).length,
      //   active: false
      // }],
      // evelflag: true
    }
  },
  computed: {
    //   evelArr() {
    //     let selectIndex = 0
    //     this.classifyArr.forEach((data, index) => {
    //       if (data.active) {
    //         selectIndex = index
    //       }
    //     })
    //     if (this.detailWrapper) {
    //       this.$nextTick(() => {
    //         this.detailWrapper.refresh()
    //       })
    //     }
    //     return selectIndex ? this.food.ratings.filter((data) => this.evelflag ? data.rateType === selectIndex - 1 && data.text : data.rateType === selectIndex - 1) : this.food.ratings.filter((data) => this.evelflag ? data.text : true)
    //   }
    totalPrice() {
      var price = 0;
      // this.foods.map(item => price += item.totalPrice)
      return parseFloat(price).toFixed(1);
    },
    productCount() {
      var count = 0;
      // this.foods.map(item => count += item.count)
      return count;
    },
    reduceTip() {
      // var content = this.shopInfo.prompt_text
      var content = "15元起送";
      var price = 0;
      // this.foods.map(item => price += item.totalPrice)
      if (price <= 0) return content;
      if (price < this.shopInfo.min_price) {
        var value = parseFloat(this.shopInfo.min_price - price).toFixed(1);
        return `还差 ${value}元 就能起送`;
      }
      var activity_info = this.shopInfo.activity_info;
      for (let i = 0; i < activity_info.length; i++) {
        const item = activity_info[i];
        if (price < item.priceLower) {
          var str = parseFloat(item.priceLower - price).toFixed(1);
          if (i === 0) {
            this.changeReduceFeeDataMut(0.0);
            return `再买 ${str}元 可减 ${item.reduce}元 [去凑单]`;
          } else {
            var perItem = activity_info[i - 1];
            this.changeReduceFeeDataMut(perItem.reduce);
            return `已减${perItem.reduce}元 再买 ${str}元 可减 ${
              item.reduce
            }元 [去凑单]`;
          }
        } else {
          continue;
        }
      }
      var lastItem = activity_info[activity_info.length - 1];
      this.changeReduceFeeDataMut(lastItem.priceLower);
      return `已满 ${lastItem.priceLower} 可减 ${lastItem.reduce}`;
    },
    btnTitle() {
      // var content = `${this.shopInfo.min_price}元起送`
      var content = "$15元起送";
      var price = 0;
      // this.foods.map(item => price += item.totalPrice)
      if (price <= 0) return content;
      if (price < this.shopInfo.min_price) {
        var value = parseFloat(this.shopInfo.min_price - price).toFixed(1);
        return `还差${value}元`;
      } else {
        return "去结算";
      }
    }
  },

  mounted() {
    this.openId = wx.getStorageSync("openId") || "";
    this.goodsDetail();
  },
  methods: {
    // 数据请求
    async goodsDetail() {
      const data = await get("/goods/detailaction", {
        id: 1,
        openId: this.openId
      });
      this.info = data.info;
      this.allcomments = data.allcomments;
      this.goodcomm = data.goodcomm;
      this.badcomm = data.badcomm;
      console.log(data);
    },

    showType() {
      this.showpop = !this.showpop;
    },

    _initScroll() {
      if (!this.detailWrapper) {
        this.detailWrapper = new BScroll(this.$refs.detailWrapper, {
          click: true
        });
      } else {
        this.detailWrapper.refresh();
      }
    },

    add () {
      this.number += 1;
    },

    reduce () {
      if (this.number > 0) {
        this.number -= 1;
      } else {
        return false;
      }
    },

    good (index) {
      this.gooddisplay = 1
      this.baddisplay = 0
      this.alldisplay = 0
    },
    bad (index) {
      this.baddisplay = 1
      this.gooddisplay = 0
      his.alldisplay = 0
    },

    addCart(event) {
      // if (!event._constructed) {
      //   return
      // }
      // this.$set(info, 'count', 1)
      // this.$root.eventHub.$emit('cart.add', event.target)
    }

    // filterEvel(item) {
    //   this.classifyArr.forEach((data) => {
    //     data.active = false
    //   })
    //   item.active = true
    // }
  }
};
</script>

<style lang="less" scoped>
@import "./style.less";
</style>
