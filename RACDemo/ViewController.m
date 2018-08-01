//
//  ViewController.m
//  RACDemo
//
//  Created by 王冠宇 on 2018/7/26.
//  Copyright © 2018 王冠宇. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"1"];
//        NSError *error = [NSError errorWithDomain:@"domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"error"}];
//        // sendError 就不会触发completed？
//        // 因为 sendError 会 terminates the subscription and invalidates the subscriber
//        [subscriber sendError:error];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"destroyed");
//        }];
//    }] subscribeNext:^(NSString *  _Nullable x) {
//        NSLog(@"next = %@", x);
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"error = %@", error.localizedDescription);
//    } completed:^{
//        NSLog(@"completed");
//    }];
    
    RACSignal *signal0 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"signal0");
        [subscriber sendNext:@"0"];
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendCompleted];
        return nil;
    }];

    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"signal1");
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@"C"];
        [subscriber sendNext:@"D"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal<RACTuple *> *signalTuple = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"signalTuple");
        [subscriber sendNext:RACTuplePack(@"A", @"1")];
        [subscriber sendNext:RACTuplePack(@"B", @"2")];
        [subscriber sendNext:RACTuplePack(@"C", @"3")];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal<RACSignal *> *signalSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"signalSignal");
        [subscriber sendNext:signal0];
        [subscriber sendNext:signal1];
        [subscriber sendNext:signalTuple];
        [subscriber sendCompleted];
        return nil;
    }];
    
//    RACSequence *signal0 = [@"1 2 3" componentsSeparatedByString:@" "].rac_sequence;
//    RACSequence *signal1 = [@"A B C D" componentsSeparatedByString:@" "].rac_sequence;
    
//    // concat
//    [[signal0 concat:signal1] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"concat: %@", x);
//    }];
//    // combineLatest
//    [[RACSignal combineLatest:@[signal0, signal1]] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"combineLatest: (%@, %@)", x.first, x.second);
//    }];
//    // reduce
//    [[RACSignal combineLatest:@[signal0, signal1] reduce:^id(NSString *s0, NSString *s1){
//        return [s0 stringByAppendingString:s1];
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"reduce: %@", x);
//    }];
//    // zip
//    [[RACSignal zip:@[signal0, signal1]] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"zip: (%@, %@)", x.first, x.second);
//    }];
//    // then
//    [[signal0 then:^RACSignal * _Nonnull{
//        return signal1;
//    }] subscribeCompleted:^{
//        NSLog(@"then: completed");
//    }];
//    // timer
//    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] take:3] subscribeNext:^(NSDate * _Nullable x) {
//        NSLog(@"timer: repeat");
//    }];
//    // delay & timeout
//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            NSLog(@"go");
//            [subscriber sendNext:nil];
//            [subscriber sendCompleted];
//            return nil;
//        }] delay:2] subscribeNext:^(id  _Nullable x) {
//            NSLog(@"delayed 2 seconds");
//            [subscriber sendNext:nil];
//            [subscriber sendCompleted];
//        }];
//        return nil;
//    }] timeout:3 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"delay & timeout: delay & timeoutnext");
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"delay & timeout: error");
//    } completed:^{
//        NSLog(@"delay & timeout: completed");
//    }];
//    // retry
//    __block int i = 0;
//    RACSignal *signalRetry = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        if (i == 5) {
//            [subscriber sendNext:nil];
//            [subscriber sendCompleted];
//        } else {
//            i++;
//            [subscriber sendError:nil];
//        }
//        return nil;
//    }];
//    [signalRetry subscribeError:^(NSError * _Nullable error) {
//        NSLog(@"retry: error");
//    }];
//    [[signalRetry retry] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"retry: success");
//    } completed:^{
//        NSLog(@"retry: complete");
//    }];
//    // takeUntil
//    RACSignal *signalTakeUntil = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [subscriber sendNext:@"finish"];
//            [subscriber sendCompleted];
//        });
//        return nil;
//    }];
//    [signalTakeUntil subscribeNext:^(id  _Nullable x) {
//        NSLog(@"takeUntil: %@", x);
//    }];
//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
//            [subscriber sendNext:@"next"];
//        }];
//        return nil;
//    }] takeUntil:signalTakeUntil] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"takeUntil: %@", x);
//    }];
//    // flatten
//    [[signalSignal flatten] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"flatten: %@", x);
//    }];
    // map: 把 signal 映射成 id
//    RACSignal *signalMap = [signal0 map:^id _Nullable(NSString * _Nullable value) {
//        return [NSString stringWithFormat:@"map: %@", value];
//    }];
//    [signalMap subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"map: %@", x);
//    }];
//    // flattenMap: 把 signal 映射成 signal
//    RACSignal *signalFlattenMap = [signal0 flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:[NSString stringWithFormat:@"flattenMap: %@", value]];
//            return nil;
//        }];
//    }];
//    [signalFlattenMap subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"flattenMap: %@", x);
//    }];
//    // mapReplace
//    [[signal0 mapReplace:[NSString stringWithFormat:@"mapReplace"]] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"mapReplace: %@", x);
//    }];
//    // filter
//    [[signal0 filter:^BOOL(NSString * _Nullable value) {
//        return [value isEqualToString:@"2"];
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"filter: %@", x);
//    }];
//    // reduceEach
//    [[signalTuple reduceEach:^id(NSString *letter, NSString *number) {
//        return [NSString stringWithFormat:@"(%@, %@)", letter, number];
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"reduceEach: %@", x);
//    }];
//    // startWith
//    [[signal0 startWith:@"startWith"] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"startWith: %@", x);
//    }];
//    // scan
//    [[signal0 scanWithStart:@"scan" reduce:^id _Nullable(NSString * _Nullable running, NSString * _Nullable next) {
//        return [NSString stringWithFormat:@"%@, %@", running, next];
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"scan: %@", x);
//    }];
//    // combinePrevious
//    [[signal0 combinePreviousWithStart:@"combinePrevious" reduce:^id _Nullable(NSString * _Nullable previous, NSString * _Nullable current) {
//        return [NSString stringWithFormat:@"%@, %@", previous, current];
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"combikePrevious: %@", x);
//    }];
    RACSignal *signalLazy = [RACSignal startLazilyWithScheduler:[RACScheduler mainThreadScheduler] block:^(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"signalLazy");
        [subscriber sendNext:@"a"];
        [subscriber sendNext:@"b"];
        [subscriber sendNext:@"c"];
//        [subscriber sendCompleted];
    }];
    [signalLazy subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"lazySignal: %@", x);
    }];
    [signalLazy subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"lazySignal: %@", x);
    }];
}


@end
