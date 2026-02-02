import DiscourseRoute from "discourse/routes/discourse";
import { ajax } from "discourse/lib/ajax";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import I18n from "I18n";
import { i18n } from "discourse-i18n";
import RatingInput from "../../components/rating-input";
import DTextarea from "discourse/components/d-textarea";
import DButton from "discourse/components/d-button";

export default class UserFeedbacksRoute extends DiscourseRoute {
  @tracked rating = 0;
  @tracked review = "";
  @tracked readOnly = false;

  model() {
    return ajax("/user_feedbacks.json", {
      type: "GET",
      data: {
        feedback_to_id: this.modelFor("user").get("id"),
      },
    }).then((response) => {
      return response;
    });
  }

  setupController(controller, model) {
    controller.setProperties({
      feedback_to_id: this.modelFor("user").get("id"),
      readOnly: this.currentUser && this.currentUser.feedbacks_to.includes(this.modelFor("user").get("id")),
      model: model,
    });
  }
}
