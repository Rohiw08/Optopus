enum WorkspaceRole {
  admin,
  editor,
  viewer;

  bool get canEdit => this == admin || this == editor;
  bool get isAdmin => this == admin;
}
