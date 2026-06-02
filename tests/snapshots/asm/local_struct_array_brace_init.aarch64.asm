
local_struct_array_brace_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, x14
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x10
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldr	x11, [x13]
               	ldursw	x12, [x29, #-0x10]
               	lsl	x12, x12, #4
               	add	x12, x15, x12
               	add	x12, x12, #0x8
               	ldr	x12, [x12]
               	add	x11, x11, x12
               	str	x11, [x13]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	sub	x15, x29, #0x30
               	adrp	x14, <page>
               	add	x14, x14, #0xdc
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [x14, #0x10]
               	str	x10, [x15, #0x10]
               	ldr	x10, [x14, #0x18]
               	str	x10, [x15, #0x18]
               	ldr	x10, [x14, #0x20]
               	str	x10, [x15, #0x20]
               	ldr	x10, [x14, #0x28]
               	str	x10, [x15, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x13, x0
               	cmp	x13, #0xc
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x8
               	ldr	x13, [x13]
               	cmp	x13, #0x3
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x28
               	ldr	x13, [x13]
               	cmp	x13, #0x5
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x98
               	adrp	x1, <page>
               	add	x1, x1, #0x11b
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x13]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x13, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x13, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x13, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x13, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x13, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x13, x29, #0x40
               	sub	x1, x29, #0x98
               	str	x13, [x1]
               	mov	x0, #0x10               // =16
               	sub	x1, x29, #0x98
               	add	x1, x1, #0x8
               	str	x0, [x1]
               	sub	x13, x29, #0x60
               	sub	x1, x29, #0x98
               	add	x1, x1, #0x10
               	str	x13, [x1]
               	mov	x0, #0x20               // =32
               	sub	x1, x29, #0x98
               	add	x1, x1, #0x18
               	str	x0, [x1]
               	sub	x13, x29, #0x68
               	sub	x1, x29, #0x98
               	add	x1, x1, #0x20
               	str	x13, [x1]
               	mov	x0, #0x8                // =8
               	sub	x1, x29, #0x98
               	add	x1, x1, #0x28
               	str	x0, [x1]
               	sub	x0, x29, #0x98
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x13, x0
               	cmp	x13, #0x38
               	b.eq	<addr>
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x98
               	ldr	x13, [x13]
               	sub	x1, x29, #0x40
               	cmp	x13, x1
               	b.eq	<addr>
               	mov	x1, #0x5                // =5
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x98
               	add	x13, x13, #0x10
               	ldr	x13, [x13]
               	sub	x1, x29, #0x60
               	cmp	x13, x1
               	b.eq	<addr>
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x98
               	add	x13, x13, #0x20
               	ldr	x13, [x13]
               	sub	x1, x29, #0x68
               	cmp	x13, x1
               	b.eq	<addr>
               	mov	x1, #0x7                // =7
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x98
               	add	x13, x13, #0x28
               	ldr	x13, [x13]
               	cmp	x13, #0x8
               	b.eq	<addr>
               	mov	x1, #0x8                // =8
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
