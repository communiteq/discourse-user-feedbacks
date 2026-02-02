import { tracked } from "@glimmer/tracking";
import Controller from "@ember/controller";
import { action, set } from "@ember/object";
import { service } from "@ember/service";
import { ajax } from "discourse/lib/ajax";
import { i18n } from "discourse-i18n";

export default class UserFeedbacksController extends Controller {
  @service siteSettings;

  @tracked rating = 0;@tracked review = "";
  @tracked readOnly = false;
  @tracked feedback_to_id = null;

  placeholder = i18n("discourse_user_feedbacks.user_feedbacks.user_review.placeholder");

  get canGiveFeedback() {
    return this.feedback_to_id !== this.currentUser && this.currentUser.id;
  }

  get allowReviews() {
    return this.siteSettings.user_feedbacks_allow_reviews;
  }

  get disabled() {
    return !parseInt(this.rating, 10) > 0;
  }

  @action
  updateRating(rating) {
    this.rating = rating;
  }

  @action
  createFeedback() {
    this.readOnly = true;
    ajax("/user_feedbacks", {
      type: "POST",
      data: {
        rating: parseInt(this.rating, 10),
        review: this.review,
        feedback_to_id: this.feedback_to_id,
      },
    }).then((response) => {
      set(this.model, "feedbacks", [response.user_feedback, ...this.model.feedbacks]);
      this.rating = 0;
      this.review = "";
    });
  }
}
