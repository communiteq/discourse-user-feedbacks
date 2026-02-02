import { tracked } from "@glimmer/tracking";
import { ajax } from "discourse/lib/ajax";
import DiscourseRoute from "discourse/routes/discourse";

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
      model,
    });
  }
}
