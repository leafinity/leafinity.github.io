// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';
import 'dart:async';

const String url = 'https://www.dropbox.com/sh/mte5lbcd1sjlvxz/AADSNwkwB3dKqsdr1YtnOXHNa?dl=0';
const String game1 = 'http://leafinity.github.io/arbo/';
const String game2 = 'http://leafinity.github.io/eyeBurst/';

List<String> text = ['Art Works', 'Website 1', 'Website 2'];

int nowPage = 0;
List<Element> imgs;
void main() {
  imgs = new List()
    ..add(querySelector('.img0'))
    ..add(querySelector('.img1'))
    ..add(querySelector('.img2'));
  
  initMain();
  initEvent();
}

void initMain() {
  int height = window.innerHeight;
  int width = window.innerWidth;
  Element mainElement = querySelector('.main')
      ..style.top = px((height - 400)~/2)
      ..style.left = px((width - 800)~/2);
}
void initEvent() { 
  querySelector('.left').onClick.listen((_) {
    flipLeft();
  });
  querySelector('.right').onClick.listen((_) {
    flipRight();
  });
  querySelector('.displayBox').onMouseOver.listen((_) {
    displayGoto();
  });
  querySelector('.displayBox').onMouseOut.listen((_) {
    removeGoto();
  });
  
  //init url replacement
  querySelector('.goto').onClick.listen((_) {
    window.location.replace(nowPage == 0? url: nowPage == 1? game1: game2);
  });
}

void displayGoto() {
  querySelector('.mask').classes.add('mask_hover');
  querySelector('.title').classes.add('title_hover');
  querySelector('.goto').classes.remove('disappear');
}

void removeGoto() {
  querySelector('.mask').classes.remove('mask_hover');
  querySelector('.title').classes.remove('title_hover');
  querySelector('.goto').classes.add('disappear');
  
}

void flipLeft() {
  querySelector('.images').classes.add('flip_animation');
  new Timer(const Duration(milliseconds:750), () {
    imgs[nowPage].classes.add('disappear');
    nowPage = getLeft(nowPage);
    querySelector(".title").innerHtml = text[nowPage];
    imgs[nowPage].classes.remove('disappear');
  }); 
  new Timer(const Duration(milliseconds:1500), () {
    querySelector('.images').classes.remove('flip_animation');
  });
}

void flipRight() {
  querySelector('.images').classes.add('flip_animation');
  new Timer(const Duration(milliseconds:750), () {
    imgs[nowPage].classes.add('disappear');
    nowPage = getRight(nowPage);
    querySelector(".title").innerHtml = text[nowPage];
    imgs[nowPage].classes.remove('disappear');
  }); 
  new Timer(const Duration(milliseconds:1500), () {
    querySelector('.images').classes.remove('flip_animation');
  });
}

int getLeft(int n) {
  if (n == 0)
    return 2;
  else 
    return n - 1;
}

int getRight(int n) {
  if (n == 2)
    return 0;
  else
    return n + 1;
}

String px(int n) => n.toString() + 'px';