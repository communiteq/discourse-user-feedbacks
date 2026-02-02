import Component from "@glimmer/component";
import RatingInput from "../../components/rating-input";
import { i18n } from "discourse-i18n";
import { LinkTo } from "@ember/routing";
import { service } from "@ember/service";

export default class AverageRatings extends Component {
  @service siteSettings;

  get mustShow() {
    return this.args.user && this.args.user.id > 0 &&
      this.siteSettings.user_feedbacks_display_average_ratings_beside_username_on_post;
  }

  <template>
    {{yield}}
    {{#if this.mustShow}}
      <div class="average-ratings">
        <RatingInput @value={{@post.user_average_rating}} @readOnly=true />
        <span class="rating-count">
          <LinkTo @route="user.feedbacks" @model={{@user}}>
            {{i18n
              "discourse_user_feedbacks.user_feedbacks.user_ratings_count"
              count=@post.user_rating_count}}
          </LinkTo>
        </span>
      </div>

    {{/if}}

  </template>
}
