//
//  LHDataModel.h
//  UITableView
//
//  Created by liuhang on 16/9/9.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
@class ItemsModel;
@interface LHDataModel : NSObject<YYModel>

@property (nonatomic, assign) NSInteger totalSize;

@property (nonatomic, strong) NSArray<ItemsModel *> *items;

@property (nonatomic, assign) NSInteger startIndex;

@property (nonatomic, assign) NSInteger limit;

@end


@interface ItemsModel : NSObject<YYModel>
/* 是否已经加入了购物车 */
@property (nonatomic,assign) BOOL isAddBus;

@property (nonatomic, copy) NSString *story;

@property (nonatomic, copy) NSString *shippingFlag;

@property (nonatomic, copy) NSString *storyTitle;

@property (nonatomic, copy) NSString *seoKeywords;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) BOOL showCardTip;

@property (nonatomic, assign) NSInteger updateFlag;

@property (nonatomic, copy) NSString *shippingDate;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *promotionTip;

@property (nonatomic, assign) NSInteger finalPrice;

@property (nonatomic, copy) NSString *foodId;

@property (nonatomic, copy) NSString *origin;

@property (nonatomic, assign) NSInteger presaleStock;

@property (nonatomic, assign) NSInteger erpProductId;

@property (nonatomic, assign) NSInteger soldCount;

@property (nonatomic, copy) NSString *foodName;

@property (nonatomic, copy) NSString *showButtonName;

@property (nonatomic, copy) NSString *foodDescription;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *qty;

@property (nonatomic, copy) NSString *cycleBuyItemSpecTip;

@property (nonatomic, copy) NSString *promotionTipForCategory;

@property (nonatomic, assign) NSInteger promotionTipForCategorySeconds;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *erpPutOffDate;

@property (nonatomic, copy) NSString *isBrowsingOtherStoreItem;

@property (nonatomic, copy) NSString *promotionTipForReach;

@property (nonatomic, copy) NSString *rmdReason;

@property (nonatomic, copy) NSString *finalDiscount;

@property (nonatomic, copy) NSString *rankValue;

@property (nonatomic, assign) NSInteger saleType;

@property (nonatomic, copy) NSString *specification;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *promotionTipForBargain;

@property (nonatomic, copy) NSString *enableLimit;

@property (nonatomic, assign) NSInteger q4sNoticeType;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, copy) NSString *usedGiftCard;

@property (nonatomic, assign) NSInteger fromErpCreate;

@property (nonatomic, copy) NSString *putOnDate;

@property (nonatomic, copy) NSString *createUserId;

@property (nonatomic, copy) NSString *relativeItems;

@property (nonatomic, assign) BOOL isBargainItem;

@property (nonatomic, copy) NSString *cardDiscount;

@property (nonatomic, copy) NSString *promotionId;

@property (nonatomic, assign) BOOL isFresh;

@property (nonatomic, copy) NSString *cardName;

@property (nonatomic, copy) NSString *oldFlag;

@property (nonatomic, assign) BOOL isPresale;

@property (nonatomic, copy) NSString *limitStock;

@property (nonatomic, copy) NSString *yukiDescription;

@property (nonatomic, copy) NSString *lastPutOnDate;

@property (nonatomic, copy) NSString *isYukiAndConversion;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *cardLevelDiscount;

@property (nonatomic, copy) NSString *endLimitDatetime;

@property (nonatomic, copy) NSString *imgs;

@property (nonatomic, copy) NSString *canAddToCart;

@property (nonatomic, copy) NSString *promotionTipForBuy;

@property (nonatomic, copy) NSString *erpPutOnDate;

@property (nonatomic, copy) NSString *sn;

@property (nonatomic, assign) NSInteger buyLimitQty;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *businessDep;

@property (nonatomic, copy) NSString *putTopDate;

@property (nonatomic, copy) NSString *relativeSpecifications;

@property (nonatomic, assign) BOOL isPutOff;

@property (nonatomic, assign) NSInteger promotionTipForBargainSeconds;

@property (nonatomic, assign) NSInteger promotionTipForBuySeconds;

@property (nonatomic, assign) NSInteger supplyFor;

@property (nonatomic, copy) NSString *properties;

@property (nonatomic, assign) NSInteger normalPrice;

@property (nonatomic, assign) NSInteger erpStatus;

@property (nonatomic, copy) NSString *shortName;

@property (nonatomic, copy) NSString *promotionIdForCategory;

@property (nonatomic, copy) NSString *erpItemName;

@property (nonatomic, assign) NSInteger lastThreeMonthSoldQty;

@property (nonatomic, assign) NSInteger originId;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger promotionTipForReachSeconds;

@property (nonatomic, copy) NSString *memberPrice;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *adjustValue;

@property (nonatomic, copy) NSString *beginLimitDatetime;

@property (nonatomic, assign) NSInteger stockMoveDays;

@property (nonatomic, assign) NSInteger erpId;

@property (nonatomic, copy) NSString *promotionTipForBargainName;

@property (nonatomic, copy) NSString *q4sNoticeButtonTitle;

@property (nonatomic, copy) NSString *cookbookUrl;

@property (nonatomic, assign) BOOL followErpStatus;

@property (nonatomic, copy) NSString *erpBinding;

@property (nonatomic, assign) NSInteger q4s;

@property (nonatomic, assign) NSInteger rankStock;

@property (nonatomic, copy) NSString *presaleDesc;

@property (nonatomic, copy) NSString *giftCardSpecs;

@property (nonatomic, copy) NSString *cookbooks;

@property (nonatomic, assign) NSInteger ruleId;

@property (nonatomic, copy) NSString *shippingDescription;

@property (nonatomic, copy) NSString *socialShareUrl;

@property (nonatomic, copy) NSString *putOffDate;

@end

