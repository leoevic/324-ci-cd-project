window.APP_CONFIG = {
  title: "Video Game Library",
  subtitle: "Organize games by genre, platform and release year.",
  entity: "game",
  plural: "games",
  accent: "#6d28d9",
  apiBaseUrl: "/api",
  fields: [
  {
    "name": "title",
    "label": "Game title",
    "type": "text",
    "required": true
  },
  {
    "name": "genre",
    "label": "Genre",
    "type": "text",
    "required": true
  },
  {
    "name": "platform",
    "label": "Platform",
    "type": "text",
    "required": true
  },
  {
    "name": "release_year",
    "label": "Release year",
    "type": "number",
    "required": true,
    "min": 1970
  },
  {
    "name": "status",
    "label": "Status",
    "type": "text",
    "required": true
  },
  {
    "name": "rating",
    "label": "Rating /10",
    "type": "number",
    "required": false,
    "min": 0,
    "max": 10
  }
],
  actions: [
  {
    "id": "mark_completed",
    "label": "Mark completed",
    "type": "set",
    "field": "status",
    "value": "Completed"
  },
  {
    "id": "increase_rating",
    "label": "Improve rating",
    "type": "increment",
    "field": "rating",
    "amount": 1,
    "max": 10
  }
]
};
