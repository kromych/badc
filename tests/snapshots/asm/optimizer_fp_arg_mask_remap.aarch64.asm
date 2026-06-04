
optimizer_fp_arg_mask_remap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0x118]
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
               	add	x21, x21, #0x128
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x140
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x146
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x14d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x20
               	bl	<addr>
               	fmov	x0, d0
               	mov	x21, x0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, x0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x22, x0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x1, #0x2d0e             // =11534
               	movk	x1, #0x9db2, lsl #16
               	movk	x1, #0xa7ef, lsl #32
               	movk	x1, #0x3fde, lsl #48
               	fmov	d16, x21
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, mi
               	cbnz	x2, <addr>
               	mov	x1, #0x1eb8             // =7864
               	movk	x1, #0xeb85, lsl #16
               	movk	x1, #0xb851, lsl #32
               	movk	x1, #0x3fde, lsl #48
               	fmov	d16, x21
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, gt
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xf1aa             // =61866
               	movk	x1, #0x4dd2, lsl #16
               	movk	x1, #0x1062, lsl #32
               	movk	x1, #0x3fec, lsl #48
               	fmov	d16, x20
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, mi
               	cbnz	x2, <addr>
               	mov	x1, #0x6a7f             // =27263
               	movk	x1, #0x74bc, lsl #16
               	movk	x1, #0x1893, lsl #32
               	movk	x1, #0x3fec, lsl #48
               	fmov	d16, x20
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, gt
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x22
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x872b             // =34603
               	movk	x1, #0xd916, lsl #16
               	movk	x1, #0xf7ce, lsl #32
               	movk	x1, #0x3fef, lsl #48
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, mi
               	cbnz	x2, <addr>
               	mov	x1, #0xbc6a             // =48234
               	movk	x1, #0x9374, lsl #16
               	movk	x1, #0x418, lsl #32
               	movk	x1, #0x3ff0, lsl #48
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, gt
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
