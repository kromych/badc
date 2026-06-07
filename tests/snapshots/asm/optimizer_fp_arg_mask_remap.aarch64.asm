
optimizer_fp_arg_mask_remap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0x108]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x118
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x130
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x136
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x13d
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	sub	x17, x29, #0x20
               	str	d16, [x17]
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x2d0e             // =11534
               	movk	x0, #0x9db2, lsl #16
               	movk	x0, #0xa7ef, lsl #32
               	movk	x0, #0x3fde, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, mi
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x1eb8             // =7864
               	movk	x0, #0xeb85, lsl #16
               	movk	x0, #0xb851, lsl #32
               	movk	x0, #0x3fde, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, gt
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0xf1aa             // =61866
               	movk	x0, #0x4dd2, lsl #16
               	movk	x0, #0x1062, lsl #32
               	movk	x0, #0x3fec, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, mi
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0x6a7f             // =27263
               	movk	x0, #0x74bc, lsl #16
               	movk	x0, #0x1893, lsl #32
               	movk	x0, #0x3fec, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, gt
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	ldr	d0, [x16]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x0, #0x872b             // =34603
               	movk	x0, #0xd916, lsl #16
               	movk	x0, #0xf7ce, lsl #32
               	movk	x0, #0x3fef, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, mi
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x0, #0xbc6a             // =48234
               	movk	x0, #0x9374, lsl #16
               	movk	x0, #0x418, lsl #32
               	movk	x0, #0x3ff0, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, gt
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
