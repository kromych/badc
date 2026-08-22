
indirect_call_variadic_fp_control.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<vsum>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x2, x29, #0x20
               	add	x0, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	b	<addr>
               	asr	x3, x1, #63
               	lsr	x3, x3, #63
               	add	x4, x1, x3
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	cbnz	x3, <addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldrsw	x3, [x3]
               	scvtf	d1, x3
               	fadd	d0, d0, d1
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldr	d1, [x3]
               	fadd	d0, d0, d1
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	ldursw	x3, [x29, #0x10]
               	cmp	x1, x3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<main>:
               	str	d8, [sp, #-0x40]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, #0x4               // =4
               	mov	x20, #0x1               // =1
               	mov	x22, #0x4004000000000000 // =4612811918334230528
               	mov	x23, #0x3               // =3
               	mov	x4, #0x4011000000000000 // =4616471093031469056
               	fmov	d0, x22
               	fmov	d1, x4
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x20
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4025, lsl #48
               	fmov	d17, x0
               	fcmp	d8, d17
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
               	mov	x4, #0x4011000000000000 // =4616471093031469056
               	fmov	d0, x22
               	fmov	d1, x4
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x20
               	bl	<addr>
               	fcmp	d8, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
