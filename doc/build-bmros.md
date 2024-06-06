# Build Bare Metal Router OS (BMROS)

## Usage

```shell
Usage: ./build-bmros.sh [options]
Options:

  -c, --core-image-minimal
  -b, --bare-metal-router               (Production)
  -d, --bare-metal-router-debug         (Debug)
  -v, --bare-metal-router-vanilla       (Non-Debug)

  -u, --update-poky-meta-bare-metal-router-layer-only
  -r, --remove-update-poky-meta-bare-metal-router-layer
```

## Build Options

### Production

After the initial login, the `root` user is removed, and direct access to the Linux OS is restricted.

```bash
./build-bmros.sh -b
```

### Vanilla

After the initial login, the `root` user has unrestricted access to the Linux OS. 
***WARNING:*** The `root` account has no password.

```bash
./build-bmros.sh -v
```

### Debug

After the initial login, the `root` user has unrestricted access to the Linux OS. 
***WARNING:*** The `root` account has no password.

```bash
./build-bmros.sh -d
```

