# 🔧 Troubleshooting

![Troubleshooting](../images/troubleshooting.svg)

This page summarizes common issues and their solutions.

## Common Issues

### Server Won't Start

**Symptom**: Error occurs with `npm start`

**Solution**:
1. Check Node.js version (`node --version`)
2. Reinstall dependencies (`npm install`)
3. Verify environment variables (refer to [Configuration](./060-configuration.md))

```bash
# Clean install of dependencies
rm -rf node_modules package-lock.json
npm install
```

### Database Connection Error

**Symptom**: `Database connection failed`

**Solution**:
1. Verify PostgreSQL is running
2. Check connection string
3. Verify firewall settings

```bash
# Check PostgreSQL status
systemctl status postgresql

# Test connection
psql -h localhost -U username -d database_name
```

## Development Environment Issues

### Hot Reload Not Working

**Solution**:
1. Check file watching settings
2. Look for port conflicts
3. Restart development server

```bash
# Restart development server
npm run dev
```

### Build Errors

**Symptom**: TypeScript compilation errors

**Solution**:
1. Check `tsconfig.json` settings
2. Update type definition files
3. Clear cache

```bash
# Clear TypeScript cache
rm -rf dist/ .tscache/
npm run build
```

## API Errors

### 401 Unauthorized

**Cause**: Authentication token issues

**Solution**:
1. Check token expiration
2. Verify JWT secret key
3. Re-login

### 404 Not Found

**Cause**: Endpoint does not exist

**Solution**:
1. Check the endpoint in [API Specification](./050-api-reference.md)
2. Verify routing configuration
3. Check server logs

### 500 Internal Server Error

**Cause**: Internal server error

**Solution**:
1. Check server logs
2. Verify database connection
3. Analyze error stack trace

```bash
# Check log files
tail -f logs/error.log
```

## Performance Issues

### Slow Response

**Solution**:
1. Optimize database queries
2. Check cache settings
3. Refer to [Performance Optimization](./070-developer-guide.md#performance-optimization)

### High Memory Usage

**Solution**:
1. Check for memory leaks
2. Adjust cache size
3. Terminate unnecessary processes

```bash
# Check memory usage
ps aux --sort=-%mem | head -10
```

## Network Issues

### Connection Timeout

**Solution**:
1. Check network connection
2. Verify proxy settings
3. Check DNS operation

```bash
# Test connection
curl -I http://localhost:3000/health
```

## Docker Related Issues

### Container Won't Start

**Solution**:
1. Check Dockerfile syntax
2. Verify base image
3. Check port mapping

```bash
# Check container logs
docker logs container_name

# Check container status
docker ps -a
```

## Logging and Debugging

### Adjusting Log Level

```bash
# Set log level with environment variable
export LOG_LEVEL=debug
npm start
```

### Enabling Debug Mode

```bash
# Start with debug mode
DEBUG=* npm run dev
```

## Emergency Response

### System Recovery Procedure

1. **Restore from Backup**
   ```bash
   # Database restoration
   pg_restore -d database_name backup_file.sql
   ```

2. **Check Logs**
   ```bash
   # Check error logs
   grep -i error logs/*.log
   ```

3. **Check System Status**
   ```bash
   # Check processes
   ps aux | grep node
   # Check port usage
   netstat -tulpn | grep :3000
   ```

## Support Information

If the issue isn't resolved:

1. Check [FAQ](./100-faq.md)
2. Refer to [Developer Guide](./070-developer-guide.md)
3. Contact support with log files attached

---

## Navigation

- [🏠 Home](./010-README.md)
- [⚙️ Configuration](./060-configuration.md)
- [🔧 API Specification](./050-api-reference.md)
- [❓ FAQ](./100-faq.md)
