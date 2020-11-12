import { SearchActionTypes } from "../actionTypes/SearchActionTypes";

const initialState = {
  results: []
};

const showResults = (state, action) => {
  return {
    ...state,
    results: action.result
  };
}

const SearchReducer = (state = initialState, action) => {
  switch (action.type) {
    case SearchActionTypes.SEARCH:
      return showResults(state, action);

    default:
      return state;
  }
}

export default SearchReducer;
