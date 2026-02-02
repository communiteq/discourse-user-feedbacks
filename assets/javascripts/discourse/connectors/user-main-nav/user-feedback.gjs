import Component from "@ember/component";
import { LinkTo } from "@ember/routing";
import { service } from "@ember/service";
import { classNames, tagName } from "@ember-decorators/component";
import icon from "discourse/helpers/d-icon";
import { i18n } from "discourse-i18n";

@tagName("li")
@classNames("user-main-nav-outlet", "billing")

export default class UserFeedback extends Component {
  @service currentUser;
  @service siteSettings;

  get shouldDisplay() {
    if (!this.currentUser) {
      return false;
    }

    if (this.model.id <= 0 ||
      (this.siteSettings.user_feedbacks_hide_feedbacks_from_user &&
        this.currentUser.id == this.model.id &&
        !this.currentUser.admin)
    ) {
      return false;
    }

    return true;
  }

  <template>
    {{#if this.shouldDisplay}}
      <LinkTo @route="user.feedbacks">
        {{icon "star"}}
        {{i18n "user.feedback.title"}}
      </LinkTo>
    {{/if}}
  </template>
}
