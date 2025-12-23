int locationToIndex(String location) {
  if(location.startsWith("/home")) return 0;
  if(location.startsWith("/search")) return 1;
  if(location.startsWith("/like")) return 2;
  return 3;
}