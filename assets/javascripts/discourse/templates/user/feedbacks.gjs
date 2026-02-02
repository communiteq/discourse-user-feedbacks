import DiscourseRoute from "discourse/routes/discourse";
import { ajax } from "discourse/lib/ajax";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import I18n from "I18n";
import { i18n } from "discourse-i18n";
import RatingInput from "../../components/rating-input";
import DTextarea from "discourse/components/d-textarea";
import DButton from "discourse/components/d-button";
import FeedbackListItem from "../../components/feedback-list-item";

export default <template>
  <div class="user-feedbacks-left"></div>
  <div class="user-feedbacks-right">
    {{#if @controller.canGiveFeedback}}
      <div class="ratings-input">
        <strong>{{i18n "discourse_user_feedbacks.user_feedbacks.add_rating"}}</strong>
        <RatingInput @value={{@controller.rating}} @onChange={{@controller.updateRating}} @readOnly={{@controller.readOnly}} />
      </div>
      <div class="review-input">
        {{#if @controller.allowReviews}}
          <DTextarea
            @rows="5"
            @placeholder={{@controller.placeholder}}
            @value={{@controller.review}}
            @disabled={{@controller.readOnly}}
            @class="review-textarea"
          />
        {{/if}}
        <DButton
          @label="discourse_user_feedbacks.user_feedbacks.add_user_feedback"
          @disabled={{@controller.disabled}}
          @action={{@controller.createFeedback}}
          @class="btn-primary create-feedback"
        />
      </div>
      <hr>
    {{/if}}
    {{#if @model.feedbacks.length}}
      {{#each @model.feedbacks as |feedback index|}}
        <FeedbackListItem @feedback={{feedback}} />
      {{/each}}
    {{else}}
      <div class="empty-state">
        <span class="empty-state-title">{{i18n "discourse_user_feedbacks.user_feedbacks.empty_state_title"}}</span>
        <div class="empty-state-body">
          <p>{{i18n "discourse_user_feedbacks.user_feedbacks.empty_state_body"}}</p>
        </div>
      </div>
    {{/if}}
  </div>
</template>