
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
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	sub	x15, x29, #0x30
               	adrp	x19, <page>
               	add	x19, x19, #0xdc
               	mov	x14, x19
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
               	sub	x20, x29, #0x30
               	mov	x21, #0x3               // =3
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	adrp	x19, <page>
               	add	x19, x19, #0x11b
               	mov	x21, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x0]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x21, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x21, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x21, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x21, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	sub	x21, x29, #0x98
               	str	x0, [x21]
               	mov	x20, #0x10              // =16
               	sub	x21, x29, #0x98
               	add	x21, x21, #0x8
               	str	x20, [x21]
               	sub	x0, x29, #0x60
               	sub	x21, x29, #0x98
               	add	x21, x21, #0x10
               	str	x0, [x21]
               	mov	x20, #0x20              // =32
               	sub	x21, x29, #0x98
               	add	x21, x21, #0x18
               	str	x20, [x21]
               	sub	x0, x29, #0x68
               	sub	x21, x29, #0x98
               	add	x21, x21, #0x20
               	str	x0, [x21]
               	mov	x20, #0x8               // =8
               	sub	x21, x29, #0x98
               	add	x21, x21, #0x28
               	str	x20, [x21]
               	sub	x22, x29, #0x98
               	mov	x23, #0x3               // =3
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x23, #0x4               // =4
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	ldr	x0, [x0]
               	sub	x23, x29, #0x40
               	cmp	x0, x23
               	b.eq	<addr>
               	mov	x23, #0x5               // =5
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x10
               	ldr	x0, [x0]
               	sub	x23, x29, #0x60
               	cmp	x0, x23
               	b.eq	<addr>
               	mov	x23, #0x6               // =6
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	sub	x23, x29, #0x68
               	cmp	x0, x23
               	b.eq	<addr>
               	mov	x23, #0x7               // =7
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x23, #0x8               // =8
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
