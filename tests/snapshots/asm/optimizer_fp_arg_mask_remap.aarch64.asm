
optimizer_fp_arg_mask_remap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2f0              // =752
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	d8, d9, [sp, #-0x90]!
               	str	d10, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	bl	<addr>
               	fmov	d8, d0
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	bl	<addr>
               	fmov	d9, d0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fsqrt	d10, d16
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x2d0e             // =11534
               	movk	x0, #0x9db2, lsl #16
               	movk	x0, #0xa7ef, lsl #32
               	movk	x0, #0x3fde, lsl #48
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, mi
               	cbnz	x0, <addr>
               	mov	x0, #0x1eb8             // =7864
               	movk	x0, #0xeb85, lsl #16
               	movk	x0, #0xb851, lsl #32
               	movk	x0, #0x3fde, lsl #48
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x0, #0xf1aa             // =61866
               	movk	x0, #0x4dd2, lsl #16
               	movk	x0, #0x1062, lsl #32
               	movk	x0, #0x3fec, lsl #48
               	fmov	d17, x0
               	fcmp	d9, d17
               	cset	x0, mi
               	cbnz	x0, <addr>
               	mov	x0, #0x6a7f             // =27263
               	movk	x0, #0x74bc, lsl #16
               	movk	x0, #0x1893, lsl #32
               	movk	x0, #0x3fec, lsl #48
               	fmov	d17, x0
               	fcmp	d9, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d10, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x0, #0x872b             // =34603
               	movk	x0, #0xd916, lsl #16
               	movk	x0, #0xf7ce, lsl #32
               	movk	x0, #0x3fef, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cbnz	x0, <addr>
               	mov	x0, #0xbc6a             // =48234
               	movk	x0, #0x9374, lsl #16
               	movk	x0, #0x418, lsl #32
               	movk	x0, #0x3ff0, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
