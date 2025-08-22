// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Alpine from 'alpinejs'
import "channels"
import '@tailwindplus/elements';
import { select } from 'alpine/select';
window.Alpine = Alpine
Alpine.data('select', select);
Alpine.start()
