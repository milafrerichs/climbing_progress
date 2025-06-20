export const select = () => {
  return {
    options: [],
    show: false,
    selected: null, // Changed to single value (index)
    search: '', // Added search term
    filteredOptions: [], // Added filtered options
		noResultsMessage: 'No results found. Create New Location: ', // New message

		init() {
      this.loadOptions();
      this.filterOptions();
			this.$watch('search', (newSearch) => { this.filterOptions(); }
      )
			this.$watch('show', (newShowValue) => {
        if (newShowValue) {
          this.$nextTick(() => {
            this.$refs.searchInput.focus();
          });
        } else {
					this.search = this.selectedName();
          this.filterOptions(); // Reset filtered options
        }
      });
    },

    open() {
      this.show = true;
			this.search = '';
    },
    close() {
			this.search = this.selectedName();
      this.filterOptions(); // Reset filtered options
      this.show = false;
    },
		selectedName() { return this.selected && this.selected > -1 ? this.options[this.selected].text: this.search; },
    select(optionIndex) {
			if (this.selected === optionIndex) {
        this.remove(); // Deselect if already selected
      } else {
        this.remove(); // Deselect previously selected
        this.selected = optionIndex;
        this.options[optionIndex].selected = true;
      }
      this.close();
    },
    remove(optionIndex) {
			if (this.selected !== null) {
        this.options[this.selected].selected = false;
        this.selected = null;
      }
    },
    loadOptions() {
      const options = this.$refs.hiddenSelect.options;
      for (let i = 0; i < options.length; i++) {
        let selected = options[i].getAttribute("selected") != null;

        this.options.push({
          value: options[i].value,
          text: options[i].innerText,
          selected: selected
        });

        if (selected) { this.selected = i; }
      }
    },
		filterOptions() {
      this.filteredOptions = this.options.map((option, index) => ({ ...option, index })).filter(option =>
        option.text.toLowerCase().includes(this.search.toLowerCase())
      );
    },

    get selectedText() {
      return this.selected !== null ? this.options[this.selected].text : 'Select an option';
    },

    get hasSelection() {
      return this.selected !== null;
    },

		createNewLocation() {
			const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
			fetch('/locations', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
					'X-CSRF-Token': csrfToken
				},
				body: JSON.stringify({ location: { name: this.search } })
			})
				.then(response => {
					if (response.ok) {
						// Location created successfully!
						// Reload the options or add the new location to the list
						this.loadOptions(); // Reload from server
						this.search = this.selectedName();
						this.close(); // Close the dropdown
						// add to the hidden select field as an option, or relaod that field? 
					} else {
						// Handle errors
						console.error('Error creating location:', response.statusText);
						alert('Failed to create location. Please try again.');
					}
				});
}

  }
}
