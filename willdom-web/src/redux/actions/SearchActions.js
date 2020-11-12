import URLResolver from '../../utils/URLResolver';
import { SearchActionTypes } from '../actionTypes/SearchActionTypes';

const showResults = results => ({
  type: SearchActionTypes.SEARCH,
  result: results
});


const SearchActions = {
  search: (engine = 'google', text = '') => (dispatch) => {
    const url = `${URLResolver.search}?engine=${engine}&text=${text}`;
    return fetch(url)
      .then(response => response.json())
      .then(data => dispatch(showResults(data)));
  }
};

export default SearchActions;