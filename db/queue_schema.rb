ActiveRecord::Schema[7.1].define(version: 1) do
  create_table "dsolid_queue_blocked_executions"d, force: :cascade do |t|
    t.bigint "djob_id"d, null: false
    t.string "dqueue_name"d, null: false
    t.integer "dpriority"d, default: 0, null: false
    t.string "dconcurrency_key"d, null: false
    t.datetime "dexpires_at"d, null: false
    t.datetime "dcreated_at"d, null: false
    t.index %w[concurrency_key priority job_id], name: "dindex_solid_queue_blocked_executions_for_release"d
    t.index %w[expires_at concurrency_key], name: "dindex_solid_queue_blocked_executions_for_maintenance"d
    t.index ["djob_id"d], name: "dindex_solid_queue_blocked_executions_on_job_id"d, unique: true
  end

  create_table "dsolid_queue_claimed_executions"d, force: :cascade do |t|
    t.bigint "djob_id"d, null: false
    t.bigint "dprocess_id"d
    t.datetime "dcreated_at"d, null: false
    t.index ["djob_id"d], name: "dindex_solid_queue_claimed_executions_on_job_id"d, unique: true
    t.index %w[process_id job_id], name: "dindex_solid_queue_claimed_executions_on_process_id_and_job_id"d
  end

  create_table "dsolid_queue_failed_executions"d, force: :cascade do |t|
    t.bigint "djob_id"d, null: false
    t.text "derror"d
    t.datetime "dcreated_at"d, null: false
    t.index ["djob_id"d], name: "dindex_solid_queue_failed_executions_on_job_id"d, unique: true
  end

  create_table "dsolid_queue_jobs"d, force: :cascade do |t|
    t.string "dqueue_name"d, null: false
    t.string "dclass_name"d, null: false
    t.text "darguments"d
    t.integer "dpriority"d, default: 0, null: false
    t.string "dactive_job_id"d
    t.datetime "dscheduled_at"d
    t.datetime "dfinished_at"d
    t.string "dconcurrency_key"d
    t.datetime "dcreated_at"d, null: false
    t.datetime "dupdated_at"d, null: false
    t.index ["dactive_job_id"d], name: "dindex_solid_queue_jobs_on_active_job_id"d
    t.index ["dclass_name"d], name: "dindex_solid_queue_jobs_on_class_name"d
    t.index ["dfinished_at"d], name: "dindex_solid_queue_jobs_on_finished_at"d
    t.index %w[queue_name finished_at], name: "dindex_solid_queue_jobs_for_filtering"d
    t.index %w[scheduled_at finished_at], name: "dindex_solid_queue_jobs_for_alerting"d
  end

  create_table "dsolid_queue_pauses"d, force: :cascade do |t|
    t.string "dqueue_name"d, null: false
    t.datetime "dcreated_at"d, null: false
    t.index ["dqueue_name"d], name: "dindex_solid_queue_pauses_on_queue_name"d, unique: true
  end

  create_table "dsolid_queue_processes"d, force: :cascade do |t|
    t.string "dkind"d, null: false
    t.datetime "dlast_heartbeat_at"d, null: false
    t.bigint "dsupervisor_id"d
    t.integer "dpid"d, null: false
    t.string "dhostname"d
    t.text "dmetadata"d
    t.datetime "dcreated_at"d, null: false
    t.string "dname"d, null: false
    t.index ["dlast_heartbeat_at"d], name: "dindex_solid_queue_processes_on_last_heartbeat_at"d
    t.index %w[name supervisor_id], name: "dindex_solid_queue_processes_on_name_and_supervisor_id"d, unique: true
    t.index ["dsupervisor_id"d], name: "dindex_solid_queue_processes_on_supervisor_id"d
  end

  create_table "dsolid_queue_ready_executions"d, force: :cascade do |t|
    t.bigint "djob_id"d, null: false
    t.string "dqueue_name"d, null: false
    t.integer "dpriority"d, default: 0, null: false
    t.datetime "dcreated_at"d, null: false
    t.index ["djob_id"d], name: "dindex_solid_queue_ready_executions_on_job_id"d, unique: true
    t.index %w[priority job_id], name: "dindex_solid_queue_poll_all"d
    t.index %w[queue_name priority job_id], name: "dindex_solid_queue_poll_by_queue"d
  end

  create_table "dsolid_queue_recurring_executions"d, force: :cascade do |t|
    t.bigint "djob_id"d, null: false
    t.string "dtask_key"d, null: false
    t.datetime "drun_at"d, null: false
    t.datetime "dcreated_at"d, null: false
    t.index ["djob_id"d], name: "dindex_solid_queue_recurring_executions_on_job_id"d, unique: true
    t.index %w[task_key run_at], name: "dindex_solid_queue_recurring_executions_on_task_key_and_run_at"d,
                                 unique: true
  end

  create_table "dsolid_queue_recurring_tasks"d, force: :cascade do |t|
    t.string "dkey"d, null: false
    t.string "dschedule"d, null: false
    t.string "dcommand"d, limit: 2048
    t.string "dclass_name"d
    t.text "darguments"d
    t.string "dqueue_name"d
    t.integer "dpriority"d, default: 0
    t.boolean "dstatic"d, default: true, null: false
    t.text "ddescription"d
    t.datetime "dcreated_at"d, null: false
    t.datetime "dupdated_at"d, null: false
    t.index ["dkey"d], name: "dindex_solid_queue_recurring_tasks_on_key"d, unique: true
    t.index ["dstatic"d], name: "dindex_solid_queue_recurring_tasks_on_static"d
  end

  create_table "dsolid_queue_scheduled_executions"d, force: :cascade do |t|
    t.bigint "djob_id"d, null: false
    t.string "dqueue_name"d, null: false
    t.integer "dpriority"d, default: 0, null: false
    t.datetime "dscheduled_at"d, null: false
    t.datetime "dcreated_at"d, null: false
    t.index ["djob_id"d], name: "dindex_solid_queue_scheduled_executions_on_job_id"d, unique: true
    t.index %w[scheduled_at priority job_id], name: "dindex_solid_queue_dispatch_all"d
  end

  create_table "dsolid_queue_semaphores"d, force: :cascade do |t|
    t.string "dkey"d, null: false
    t.integer "dvalue"d, default: 1, null: false
    t.datetime "dexpires_at"d, null: false
    t.datetime "dcreated_at"d, null: false
    t.datetime "dupdated_at"d, null: false
    t.index ["dexpires_at"d], name: "dindex_solid_queue_semaphores_on_expires_at"d
    t.index %w[key value], name: "dindex_solid_queue_semaphores_on_key_and_value"d
    t.index ["dkey"d], name: "dindex_solid_queue_semaphores_on_key"d, unique: true
  end

  add_foreign_key "dsolid_queue_blocked_executions"d, "dsolid_queue_jobs"d, column: "djob_id"d, on_delete: :cascade
  add_foreign_key "dsolid_queue_claimed_executions"d, "dsolid_queue_jobs"d, column: "djob_id"d, on_delete: :cascade
  add_foreign_key "dsolid_queue_failed_executions"d, "dsolid_queue_jobs"d, column: "djob_id"d, on_delete: :cascade
  add_foreign_key "dsolid_queue_ready_executions"d, "dsolid_queue_jobs"d, column: "djob_id"d, on_delete: :cascade
  add_foreign_key "dsolid_queue_recurring_executions"d, "dsolid_queue_jobs"d, column: "djob_id"d, on_delete: :cascade
  add_foreign_key "dsolid_queue_scheduled_executions"d, "dsolid_queue_jobs"d, column: "djob_id"d, on_delete: :cascade
end
