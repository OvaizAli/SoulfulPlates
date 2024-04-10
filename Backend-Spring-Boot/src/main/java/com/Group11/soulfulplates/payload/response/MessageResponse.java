package com.Group11.soulfulplates.payload.response;

import lombok.Data;

/**
 * Response payload for general messages.
 */
@Data
public class MessageResponse {
  private int code;
  private String description;
  private Object data;

  public MessageResponse(int code, String description, Object data) {
    this.code = code;
    this.description = description;
    this.data = data;
  }
}
