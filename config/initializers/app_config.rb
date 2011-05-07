case Rails.env
when 'production'
  GOOGLE_LOADER_API_KEY = 'ABQIAAAA8IA-BjouWb_bx9zvm0DD9xT2yXp_ZAY8_ufC3CFXhHIE1NvwkxQv8Pp9wQ7UsCPb0KljklXXJ_BVHg'
when 'development'
  GOOGLE_LOADER_API_KEY = 'ABQIAAAA8IA-BjouWb_bx9zvm0DD9xSLZVUmDvrywlFTQweQTPQuYUPKJhS13F8PlSngNQyCPcf_xgLyfzeMLg'
end
