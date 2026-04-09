# validate_user_ui.py
import streamlit as st
from fetch_data import fetch_data


def validate_user_ui():
    st.header("Validate User")

    email = st.text_input("Enter Email")
    password = st.text_input("Enter Password", type="password")

    if st.button("Validate User"):
        if not email.strip() or not password.strip():
            st.warning("Please enter both an email and a password.")
            return

        params = {
            "email": email.strip(),
            "password": password.strip()
        }

        df = fetch_data("validate_user/", params)

        if df is not None and not df.empty:
            st.success(f"User {email} is valid!")
            st.subheader("User Info:")
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.error(f" User {email} is not valid. Please check your credentials and try again.")