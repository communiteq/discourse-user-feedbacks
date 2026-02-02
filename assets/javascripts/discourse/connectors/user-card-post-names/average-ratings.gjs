import Component from "@glimmer/component";
import { LinkTo } from "@ember/routing";
import { service } from "@ember/service";
import { i18n } from "discourse-i18n";
import RatingInput from "../../components/rating-input";

export default class AverageRatings extends Component {
  @service siteSettings;

  get mustShow() {
    return this.args.user && this.args.user.id > 0 &&
      this.siteSettings.user_feedbacks_display_average_ratings_on_user_card;
  }

  <template>
    {{#if this.mustShow}}
      <div class="average-ratings">
        <RatingInput @value={{@user.average_rating}} @readOnly=true />
        <span class="rating-count">
          <LinkTo @route="user.feedbacks" @model={{@user}}>
            {{i18n
              "discourse_user_feedbacks.user_feedbacks.user_ratings_count"
              count=@user.rating_count}}
          </LinkTo>
        </span>
      </div>
    {{/if}}
  </template>
}