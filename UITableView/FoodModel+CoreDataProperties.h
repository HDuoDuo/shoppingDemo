//
//  FoodModel+CoreDataProperties.h
//  
//
//  Created by liuhang on 16/9/18.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FoodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FoodModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *iD;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *num;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *isUse;

@end

NS_ASSUME_NONNULL_END
