import { htmlSafe } from "@ember/template";
import UserAvatar from "discourse/components/user-avatar";
import formatDate from "discourse/helpers/format-date";
import RatingInput from "./rating-input";

export default <template>
  <div class="feedback-list-item">
    <div class="user-rating">
      <div class="user-data">
        <a href={{@feedback.user.path}} data-user-card={{@feedback.user.username}}>
          <UserAvatar @size="large" @user={{@feedback.user}} />
        </a>
        <div class="rating-data">
          <span class="username">{{@feedback.user.username}}</span>
          <RatingInput @value={{@feedback.rating}} @readOnly=true />
        </div>
      </div>
      {{formatDate @feedback.created_at format="medium"}}
    </div>
    <p>
      {{htmlSafe @feedback.review}}
    </p>
    <hr>
  </div>
</template>