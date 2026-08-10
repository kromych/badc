
auto_struct_array_multi_dim.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<runtime3d>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	sub	x0, x29, #0x120
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x1, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x1, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x1, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x1, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x1, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x1, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x1, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x1, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x1, #0x90]
               	str	x10, [x0, #0x90]
               	ldr	x10, [x1, #0x98]
               	str	x10, [x0, #0x98]
               	ldr	x10, [x1, #0xa0]
               	str	x10, [x0, #0xa0]
               	ldr	x10, [x1, #0xa8]
               	str	x10, [x0, #0xa8]
               	ldr	x10, [x1, #0xb0]
               	str	x10, [x0, #0xb0]
               	ldr	x10, [x1, #0xb8]
               	str	x10, [x0, #0xb8]
               	ldr	x10, [x1, #0xc0]
               	str	x10, [x0, #0xc0]
               	ldr	x10, [x1, #0xc8]
               	str	x10, [x0, #0xc8]
               	ldr	x10, [x1, #0xd0]
               	str	x10, [x0, #0xd0]
               	ldr	x10, [x1, #0xd8]
               	str	x10, [x0, #0xd8]
               	ldr	x10, [x1, #0xe0]
               	str	x10, [x0, #0xe0]
               	ldr	x10, [x1, #0xe8]
               	str	x10, [x0, #0xe8]
               	ldr	x10, [x1, #0xf0]
               	str	x10, [x0, #0xf0]
               	ldr	x10, [x1, #0xf8]
               	str	x10, [x0, #0xf8]
               	ldr	x10, [x1, #0x100]
               	str	x10, [x0, #0x100]
               	ldr	x10, [x1, #0x108]
               	str	x10, [x0, #0x108]
               	ldr	x10, [x1, #0x110]
               	str	x10, [x0, #0x110]
               	ldr	x10, [x1, #0x118]
               	str	x10, [x0, #0x118]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x120
               	str	x0, [x1]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0x8]
               	mov	x2, #0x1020             // =4128
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x10]
               	mov	x2, #0x1001             // =4097
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x18]
               	mov	x2, #0x1040             // =4160
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x20]
               	mov	x2, #0x1002             // =4098
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x28]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0x30]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0x38]
               	mov	x2, #0x1003             // =4099
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x40]
               	mov	x2, #0x9060             // =36960
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x48]
               	mov	x2, #0x1004             // =4100
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x50]
               	mov	x2, #0x9005             // =36869
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x58]
               	mov	x2, #0x9006             // =36870
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x60]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0x68]
               	mov	x2, #0x9007             // =36871
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x70]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0x78]
               	mov	x2, #0x9008             // =36872
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x80]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0x88]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0x90]
               	mov	x2, #0x9009             // =36873
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x98]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0xa0]
               	mov	x2, #0x100a             // =4106
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0xa8]
               	sub	x1, x29, #0x120
               	str	x0, [x1, #0xb0]
               	mov	x1, #0x100b             // =4107
               	sub	x0, x29, #0x120
               	str	x1, [x0, #0xb8]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1000             // =4096
               	mov	x2, #0x9000             // =36864
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
