export interface userParams {
  limit: number;
  offset: number;
  search: string;
}

export interface userBody {
  pk_user?: number;
  user_name: string;
  user_firstname: string;
  user_lastname: string;
  user_email: string;
  user_phone: string;
  user_dni: string;
  user_age: string;
  user_createdAt: string;
  user_status: boolean;
}
