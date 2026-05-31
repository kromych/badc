
optimizer_fp_arg_mask_remap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4004d0 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x118]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x128
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40040c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x128
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x140
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x146
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x14d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400878 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400498 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x128
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400498 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x128
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x20, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x20
               	bl	0x400884 <sin>
               	fmov	x0, d0
               	mov	x21, x0
               	fmov	d0, x20
               	bl	0x400890 <cos>
               	fmov	x0, d0
               	mov	x22, x0
               	mov	x23, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x23
               	bl	0x40089c <sqrt>
               	fmov	x0, d0
               	mov	x20, x0
               	mov	x24, #0x0               // =0
               	fmov	d0, x24
               	bl	0x4008a8 <exp>
               	fmov	x0, d0
               	mov	x11, x0
               	mov	x24, #0x2d0e            // =11534
               	movk	x24, #0x9db2, lsl #16
               	movk	x24, #0xa7ef, lsl #32
               	movk	x24, #0x3fde, lsl #48
               	fmov	d0, x21
               	fmov	d1, x24
               	fcmp	d0, d1
               	cset	x10, mi
               	stur	x10, [x29, #-0x38]
               	cbnz	x10, 0x400590 <.text+0x210>
               	mov	x24, #0x1eb8            // =7864
               	movk	x24, #0xeb85, lsl #16
               	movk	x24, #0xb851, lsl #32
               	movk	x24, #0x3fde, lsl #48
               	fmov	d0, x21
               	fmov	d1, x24
               	fcmp	d0, d1
               	cset	x10, gt
               	stur	x10, [x29, #-0x38]
               	b	0x400590 <.text+0x210>
               	ldur	x10, [x29, #-0x38]
               	cbz	x10, 0x4005c4 <.text+0x244>
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x10, #0xf1aa            // =61866
               	movk	x10, #0x4dd2, lsl #16
               	movk	x10, #0x1062, lsl #32
               	movk	x10, #0x3fec, lsl #48
               	fmov	d0, x22
               	fmov	d1, x10
               	fcmp	d0, d1
               	cset	x24, mi
               	stur	x24, [x29, #-0x40]
               	cbnz	x24, 0x400614 <.text+0x294>
               	mov	x10, #0x6a7f            // =27263
               	movk	x10, #0x74bc, lsl #16
               	movk	x10, #0x1893, lsl #32
               	movk	x10, #0x3fec, lsl #48
               	fmov	d0, x22
               	fmov	d1, x10
               	fcmp	d0, d1
               	cset	x24, gt
               	stur	x24, [x29, #-0x40]
               	b	0x400614 <.text+0x294>
               	ldur	x24, [x29, #-0x40]
               	cbz	x24, 0x400648 <.text+0x2c8>
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x20
               	fmov	d1, x24
               	fcmp	d0, d1
               	cset	x10, ne
               	cbz	x10, 0x40068c <.text+0x30c>
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x10, #0x872b            // =34603
               	movk	x10, #0xd916, lsl #16
               	movk	x10, #0xf7ce, lsl #32
               	movk	x10, #0x3fef, lsl #48
               	fmov	d0, x11
               	fmov	d1, x10
               	fcmp	d0, d1
               	cset	x24, mi
               	stur	x24, [x29, #-0x48]
               	cbnz	x24, 0x4006dc <.text+0x35c>
               	mov	x10, #0xbc6a            // =48234
               	movk	x10, #0x9374, lsl #16
               	movk	x10, #0x418, lsl #32
               	movk	x10, #0x3ff0, lsl #48
               	fmov	d0, x11
               	fmov	d1, x10
               	fcmp	d0, d1
               	cset	x24, gt
               	stur	x24, [x29, #-0x48]
               	b	0x4006dc <.text+0x35c>
               	ldur	x24, [x29, #-0x48]
               	cbz	x24, 0x400710 <.text+0x390>
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x13              // =19
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
