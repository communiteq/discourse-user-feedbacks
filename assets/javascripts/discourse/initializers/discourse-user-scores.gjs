import { withPluginApi } from "discourse/lib/plugin-api";
import ComponentConnector from "discourse/widgets/component-connector";

function initializeDiscourseUserFeedbacks(api) {
  api.addTrackedPostProperties ("user.user_average_rating", "user_rating_count");
}

export default {
  name: "discourse-user-feedbacks",

  initialize(container) {
    const siteSettings = container.lookup("site-settings:main");

    if (siteSettings.user_feedbacks_enabled) {
      withPluginApi("0.10.1", initializeDiscourseUserFeedbacks);
    }
  },
};
