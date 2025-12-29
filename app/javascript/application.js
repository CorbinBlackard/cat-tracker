// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('submit', (e) => {
  if (e.target.querySelector('input[type="file"]')) {
    e.target.querySelector('input[type="submit"]').disabled = true;
    e.target.querySelector('input[type="submit"]').value = 'Uploading...';
  }
});