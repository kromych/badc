
vector_shifts_by_a_vector_of_counts.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<shifts_s8x16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v2.16b, v0.16b, v1.16b
               	str	q2, [x0]
               	neg	v1.16b, v1.16b
               	sshl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0, #0x10]
               	ret

<check_s8x16>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x22, #0x0               // =0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x40]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x30]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x3f]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2f]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x3e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x3d]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2d]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x3c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #3
               	sturb	w0, [x29, #-0x2c]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x3b]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2b]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x3a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x39]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x29]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x38]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x28]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturb	w1, [x29, #-0x37]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x27]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x0, x1, #11
               	sturb	w0, [x29, #-0x36]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x26]
               	sub	x1, x29, #0x40
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x2, x2, #11
               	sturb	w2, [x29, #-0x35]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x25]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x2, x2, #11
               	sturb	w2, [x29, #-0x34]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x24]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x2, x2, #11
               	sturb	w2, [x29, #-0x33]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x23]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x2, x2, #11
               	sturb	w2, [x29, #-0x32]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x22]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x2, x2, #11
               	sturb	w2, [x29, #-0x31]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x0, x2, #11, #3
               	sturb	w0, [x29, #-0x21]
               	sub	x20, x29, #0x20
               	sub	x21, x29, #0x30
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	x3, x20, #0x10
               	sub	x1, x29, #0x40
               	ldrsb	x1, [x1, x0]
               	ldrsb	x2, [x21, x0]
               	lsl	x4, x1, x2
               	sxtb	x4, w4
               	asr	x1, x1, x2
               	sxtb	x1, w1
               	ldrsb	x2, [x20, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	ldrsb	x2, [x3, x0]
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<shifts_u8x16>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v2.16b, v0.16b, v1.16b
               	str	q2, [x0]
               	neg	v1.16b, v1.16b
               	ushl	v0.16b, v0.16b, v1.16b
               	str	q0, [x0, #0x10]
               	ret

<check_u8x16>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x22, #0x0               // =0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x40]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x30]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x3f]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2f]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x3e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x3d]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2d]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x3c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #3
               	sturb	w0, [x29, #-0x2c]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x3b]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2b]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x3a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x2a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x39]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x29]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x38]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x28]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #8
               	sturb	w1, [x29, #-0x37]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x27]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #8
               	sturb	w0, [x29, #-0x36]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #3
               	sturb	w1, [x29, #-0x26]
               	sub	x1, x29, #0x40
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #8
               	sturb	w2, [x29, #-0x35]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x25]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #8
               	sturb	w2, [x29, #-0x34]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x24]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #8
               	sturb	w2, [x29, #-0x33]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x23]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #8
               	sturb	w2, [x29, #-0x32]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #3
               	sturb	w2, [x29, #-0x22]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #8
               	sturb	w2, [x29, #-0x31]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x0, x2, #11, #3
               	sturb	w0, [x29, #-0x21]
               	sub	x20, x29, #0x20
               	sub	x21, x29, #0x30
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	x3, x20, #0x10
               	sub	x1, x29, #0x40
               	ldrb	w1, [x1, x0]
               	ldrb	w2, [x21, x0]
               	lsl	x4, x1, x2
               	and	x4, x4, #0xff
               	lsr	x1, x1, x2
               	and	x1, x1, #0xff
               	ldrb	w2, [x20, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	ldrb	w2, [x3, x0]
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<shifts_s16x8>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v2.8h, v0.8h, v1.8h
               	str	q2, [x0]
               	neg	v1.8h, v1.8h
               	sshl	v0.8h, v0.8h, v1.8h
               	str	q0, [x0, #0x10]
               	ret

<check_s16x8>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x22, #0x0               // =0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x40]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x30]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x3e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x2e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x3c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x2c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x3a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x2a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x38]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #4
               	sturh	w0, [x29, #-0x28]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x36]
               	sub	x20, x29, #0x30
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x26]
               	sub	x21, x29, #0x40
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x34]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x24]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	sturh	w1, [x29, #-0x32]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #4
               	sturh	w0, [x29, #-0x22]
               	sub	x0, x29, #0x20
               	mov	x1, x21
               	mov	x2, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldrsh	x1, [x21, x0, lsl #1]
               	ldrsh	x2, [x20, x0, lsl #1]
               	lsl	x3, x1, x2
               	sxth	x3, w3
               	asr	x1, x1, x2
               	sxth	x2, w1
               	sub	x1, x29, #0x20
               	ldrsh	x4, [x1, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x1, x1, #0x10
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<shifts_u16x16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldr	q1, [x2]
               	ushl	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x30]
               	ldr	q2, [x2, #0x10]
               	ushl	v1.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x20]
               	neg	v0.8h, v0.8h
               	ldur	q1, [x29, #-0x10]
               	neg	v1.8h, v1.8h
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	ldur	q2, [x29, #-0x40]
               	ushl	v0.8h, v2.8h, v0.8h
               	ldur	q2, [x29, #-0x30]
               	ushl	v1.8h, v2.8h, v1.8h
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16x16>:
               	stp	x20, x21, [sp, #-0xb0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x22, #0x0               // =0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x80]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x60]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x7e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x5e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x7c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x5c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x7a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x5a]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x78]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #4
               	sturh	w0, [x29, #-0x58]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x76]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x56]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x74]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x54]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x72]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x52]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x70]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x50]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #16
               	sturh	w1, [x29, #-0x6e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x4e]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #16
               	sturh	w0, [x29, #-0x6c]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #4
               	sturh	w1, [x29, #-0x4c]
               	sub	x1, x29, #0x80
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #16
               	sturh	w2, [x29, #-0x6a]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #4
               	sturh	w2, [x29, #-0x4a]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #16
               	sturh	w2, [x29, #-0x68]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #4
               	sturh	w2, [x29, #-0x48]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #16
               	sturh	w2, [x29, #-0x66]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #4
               	sturh	w2, [x29, #-0x46]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #16
               	sturh	w2, [x29, #-0x64]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #4
               	sturh	w2, [x29, #-0x44]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x2, x2, #11, #16
               	sturh	w2, [x29, #-0x62]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	ubfx	x0, x2, #11, #4
               	sturh	w0, [x29, #-0x42]
               	sub	x20, x29, #0x40
               	sub	x21, x29, #0x60
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	x3, x20, #0x20
               	sub	x1, x29, #0x80
               	ldrh	w1, [x1, x0, lsl #1]
               	ldrh	w2, [x21, x0, lsl #1]
               	lsl	x4, x1, x2
               	and	x4, x4, #0xffff
               	lsr	x1, x1, x2
               	and	x1, x1, #0xffff
               	ldrh	w2, [x20, x0, lsl #1]
               	cmp	w2, w4
               	b.ne	<addr>
               	ldrh	w2, [x3, x0, lsl #1]
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret

<shifts_s32x8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldr	q1, [x2]
               	ushl	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldr	q2, [x2, #0x10]
               	ushl	v1.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x20]
               	neg	v0.4s, v0.4s
               	ldur	q1, [x29, #-0x10]
               	neg	v1.4s, v1.4s
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	ldur	q2, [x29, #-0x40]
               	sshl	v0.4s, v2.4s, v0.4s
               	ldur	q2, [x29, #-0x30]
               	sshl	v1.4s, v2.4s, v1.4s
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s32x8>:
               	stp	x20, x21, [sp, #-0xb0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x22, #0x0               // =0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x80]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #5
               	stur	w1, [x29, #-0x60]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x7c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #5
               	stur	w1, [x29, #-0x5c]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x78]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #5
               	stur	w1, [x29, #-0x58]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x74]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #5
               	stur	w1, [x29, #-0x54]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x70]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #5
               	stur	w0, [x29, #-0x50]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x6c]
               	sub	x20, x29, #0x60
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #5
               	stur	w1, [x29, #-0x4c]
               	sub	x21, x29, #0x80
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x68]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x1, x1, #11, #5
               	stur	w1, [x29, #-0x48]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x1, x1, #11
               	stur	w1, [x29, #-0x64]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	ubfx	x0, x1, #11, #5
               	stur	w0, [x29, #-0x44]
               	sub	x0, x29, #0x40
               	mov	x1, x21
               	mov	x2, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x21, x0, lsl #2]
               	ldrsw	x2, [x20, x0, lsl #2]
               	lsl	x3, x1, x2
               	asr	x2, x1, x2
               	sub	x1, x29, #0x40
               	ldrsw	x4, [x1, x0, lsl #2]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x1, x1, #0x20
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret

<shifts_u32x4>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v2.4s, v0.4s, v1.4s
               	str	q2, [x0]
               	neg	v1.4s, v1.4s
               	ushl	v0.4s, v0.4s, v1.4s
               	str	q0, [x0, #0x10]
               	ret

<check_u32x4>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x20, #0x0               // =0
               	sub	x1, x29, #0x40
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x21, x2, #11
               	stur	w21, [x29, #-0x40]
               	sub	x2, x29, #0x30
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x22, x3, #11, #5
               	stur	w22, [x29, #-0x30]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x23, x3, #11
               	stur	w23, [x29, #-0x3c]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x24, x3, #11, #5
               	stur	w24, [x29, #-0x2c]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x25, x3, #11
               	stur	w25, [x29, #-0x38]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x26, x3, #11, #5
               	stur	w26, [x29, #-0x28]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x27, x3, #11
               	stur	w27, [x29, #-0x34]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x28, x3, #11, #5
               	stur	w28, [x29, #-0x24]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	lsl	x0, x21, x22
               	mov	w1, w21
               	lsr	x1, x1, x22
               	ldur	w2, [x29, #-0x20]
               	cmp	w2, w0
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x10]
               	cmp	w0, w1
               	b.ne	<addr>
               	lsl	x0, x23, x24
               	mov	w1, w23
               	lsr	x1, x1, x24
               	ldur	w2, [x29, #-0x1c]
               	cmp	w2, w0
               	b.ne	<addr>
               	ldur	w0, [x29, #-0xc]
               	cmp	w0, w1
               	b.ne	<addr>
               	lsl	x0, x25, x26
               	mov	w1, w25
               	lsr	x1, x1, x26
               	ldur	w2, [x29, #-0x18]
               	cmp	w2, w0
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x8]
               	cmp	w0, w1
               	b.ne	<addr>
               	lsl	x0, x27, x28
               	mov	w1, w27
               	lsr	x1, x1, x28
               	ldur	w2, [x29, #-0x14]
               	cmp	w2, w0
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x4]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret

<shifts_s64x2>:
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ushl	v2.2d, v0.2d, v1.2d
               	str	q2, [x0]
               	neg	v1.2d, v1.2d
               	sshl	v0.2d, v0.2d, v1.2d
               	str	q0, [x0, #0x10]
               	ret

<check_s64x2>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, #0x0               // =0
               	sub	x1, x29, #0x40
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x21, x2, #11
               	stur	x21, [x29, #-0x40]
               	sub	x2, x29, #0x30
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x22, x3, #11, #6
               	stur	x22, [x29, #-0x30]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x23, x3, #11
               	stur	x23, [x29, #-0x38]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x24, x3, #11, #6
               	stur	x24, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	lsl	x0, x21, x22
               	asr	x1, x21, x22
               	ldur	x2, [x29, #-0x20]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, x1
               	b.ne	<addr>
               	lsl	x0, x23, x24
               	asr	x1, x23, x24
               	ldur	x2, [x29, #-0x18]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret

<shifts_u64x4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldr	q1, [x2]
               	ushl	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldr	q2, [x2, #0x10]
               	ushl	v1.2d, v1.2d, v2.2d
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x20]
               	neg	v0.2d, v0.2d
               	ldur	q1, [x29, #-0x10]
               	neg	v1.2d, v1.2d
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	ldur	q2, [x29, #-0x40]
               	ushl	v0.2d, v2.2d, v0.2d
               	ldur	q2, [x29, #-0x30]
               	ushl	v1.2d, v2.2d, v1.2d
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u64x4>:
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	mov	x20, #0x0               // =0
               	sub	x1, x29, #0x80
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x21, x2, #11
               	stur	x21, [x29, #-0x80]
               	sub	x2, x29, #0x60
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x22, x3, #11, #6
               	stur	x22, [x29, #-0x60]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x23, x3, #11
               	stur	x23, [x29, #-0x78]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x24, x3, #11, #6
               	stur	x24, [x29, #-0x58]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x25, x3, #11
               	stur	x25, [x29, #-0x70]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x26, x3, #11, #6
               	stur	x26, [x29, #-0x50]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x27, x3, #11
               	stur	x27, [x29, #-0x68]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	ubfx	x28, x3, #11, #6
               	stur	x28, [x29, #-0x48]
               	sub	x0, x29, #0x40
               	bl	<addr>
               	lsl	x0, x21, x22
               	lsr	x1, x21, x22
               	ldur	x2, [x29, #-0x40]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x20]
               	cmp	x0, x1
               	b.ne	<addr>
               	lsl	x0, x23, x24
               	lsr	x1, x23, x24
               	ldur	x2, [x29, #-0x38]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, x1
               	b.ne	<addr>
               	lsl	x0, x25, x26
               	lsr	x1, x25, x26
               	ldur	x2, [x29, #-0x30]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, x1
               	b.ne	<addr>
               	lsl	x0, x27, x28
               	lsr	x1, x27, x28
               	ldur	x2, [x29, #-0x28]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
