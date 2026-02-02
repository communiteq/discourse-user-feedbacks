import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { htmlSafe } from "@ember/template";

export default class RatingInput extends Component {
  @tracked value = this.args.value || 0;

  iconClasses = (starIndex) => {
    let classes = [];
    if (parseFloat(this.value) >= starIndex) {
      classes.push('checked');
    }
    if (this.calculatePercentage(starIndex)) {
      classes.push('partial');
    }
    if (this.args.readOnly || false) {
      classes.push('read-only');
    }
    return classes.join(' ');
  };
widthPercentage = (starIndex) => {
    return htmlSafe("width: " + this.calculatePercentage(starIndex) + "%;");
  };

get readOnly() {
    return this.args.readOnly || false;
  }




calculatePercentage(n) {
    const value = parseFloat(this.value);
    if (value >= n) {return 100;}
    if (value < n - 1) {return 0;}
    return ((Math.round(value * 100) / 100) % 1) * 100;
  }



  @action
  changeRating(val) {
    if (this.readOnly) {return;}
    if (this.args.onChange) {
      this.args.onChange(val);
    }
    this.value = val;
  }

  <template>
    <div class="user-ratings">
      <div class="rating"><span
          class="icon {{this.iconClasses 1}}" {{on "click" (fn this.changeRating 1)}}>
          ☆<span class="partial-fill" style="{{this.widthPercentage 1}}">★</span>
        </span><span
          class="icon {{this.iconClasses 2}}" {{on "click" (fn this.changeRating 2)}}>
          ☆
          <span class="partial-fill" style="{{this.widthPercentage 2}}">★</span>
        </span><span
          class="icon {{this.iconClasses 3}}" {{on "click" (fn this.changeRating 3)}}>
          ☆
          <span class="partial-fill" style="{{this.widthPercentage 3}}">★</span>
        </span><span
          class="icon {{this.iconClasses 4}}" {{on "click" (fn this.changeRating 4)}}>
          ☆
          <span class="partial-fill" style="{{this.widthPercentage 4}}">★</span>
        </span><span
          class="icon {{this.iconClasses 5}}" {{on "click" (fn this.changeRating 5)}}>
          ☆
          <span class="partial-fill" style="{{this.widthPercentage 5}}">★</span>
        </span>
      </div>
    </div>
  </template>

}
