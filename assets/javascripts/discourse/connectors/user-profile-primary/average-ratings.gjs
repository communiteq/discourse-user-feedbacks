import Component from "@glimmer/component";
import RatingInput from "../../components/rating-input";
import { i18n } from "discourse-i18n";
import { LinkTo } from "@ember/routing";
import { service } from "@ember/service";

export default class AverageRatings extends Component {
  @service siteSettings;

  get mustShow() {
    return this.args.model && this.args.model.id > 0 &&
      this.siteSettings.user_feedbacks_display_average_ratings_on_profile;
  }

  <template>
    {{#if this.mustShow}}
      <div class="average-ratings">
        <RatingInput @value={{@model.average_rating}} @readOnly=true />
        <span class="rating-count">
          <LinkTo @route="user.feedbacks" @model={{@model}}>
            {{i18n
              "discourse_user_feedbacks.user_feedbacks.user_ratings_count"
              count=@model.rating_count}}
          </LinkTo>
        </span>
      </div>
    {{/if}}
  </template>
}