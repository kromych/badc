
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
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x128
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x128
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x140
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x146
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x14d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x128
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x128
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
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
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x20
               	bl	<addr>
               	fmov	x0, d0
               	mov	x21, x0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	x0, d0
               	mov	x22, x0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x23, x0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	mov	x11, x0
               	mov	x0, #0x2d0e             // =11534
               	movk	x0, #0x9db2, lsl #16
               	movk	x0, #0xa7ef, lsl #32
               	movk	x0, #0x3fde, lsl #48
               	fmov	d0, x21
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x10, mi
               	stur	x10, [x29, #-0x38]
               	cbnz	x10, <addr>
               	mov	x0, #0x1eb8             // =7864
               	movk	x0, #0xeb85, lsl #16
               	movk	x0, #0xb851, lsl #32
               	movk	x0, #0x3fde, lsl #48
               	fmov	d0, x21
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x21, gt
               	stur	x21, [x29, #-0x38]
               	b	<addr>
               	ldur	x21, [x29, #-0x38]
               	cbz	x21, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xf1aa            // =61866
               	movk	x21, #0x4dd2, lsl #16
               	movk	x21, #0x1062, lsl #32
               	movk	x21, #0x3fec, lsl #48
               	fmov	d0, x22
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, mi
               	stur	x0, [x29, #-0x40]
               	cbnz	x0, <addr>
               	mov	x21, #0x6a7f            // =27263
               	movk	x21, #0x74bc, lsl #16
               	movk	x21, #0x1893, lsl #32
               	movk	x21, #0x3fec, lsl #48
               	fmov	d0, x22
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x22, gt
               	stur	x22, [x29, #-0x40]
               	b	<addr>
               	ldur	x22, [x29, #-0x40]
               	cbz	x22, <addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x23
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x23, ne
               	cbz	x23, <addr>
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x872b            // =34603
               	movk	x23, #0xd916, lsl #16
               	movk	x23, #0xf7ce, lsl #32
               	movk	x23, #0x3fef, lsl #48
               	fmov	d0, x11
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x22, mi
               	stur	x22, [x29, #-0x48]
               	cbnz	x22, <addr>
               	mov	x23, #0xbc6a            // =48234
               	movk	x23, #0x9374, lsl #16
               	movk	x23, #0x418, lsl #32
               	movk	x23, #0x3ff0, lsl #48
               	fmov	d0, x11
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x11, gt
               	stur	x11, [x29, #-0x48]
               	b	<addr>
               	ldur	x11, [x29, #-0x48]
               	cbz	x11, <addr>
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x13              // =19
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
