
dynamic_frame_return_restores.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<vla_plain>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	cmp	x0, #0x9
               	b.le	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x2
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	mov	x0, x2
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<realigned_plain>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x0, sp
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x0, sp
               	and	x0, x0, #0x3f
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	b	<addr>

<vla_saves>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	add	x17, x20, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x21, sp
               	sub	x21, x21, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x21
               	mov	x17, #0x3               // =3
               	mul	x22, x20, x17
               	mov	x17, #0x5               // =5
               	mul	x23, x20, x17
               	mov	x1, #0x4                // =4
               	mov	x0, x21
               	bl	<addr>
               	cmp	x20, #0x7
               	b.ne	<addr>
               	ldrb	w0, [x21]
               	add	x0, x22, x0
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x1, #0x5                // =5
               	mov	x0, x21
               	bl	<addr>
               	ldrb	w0, [x21]
               	madd	x0, x22, x23, x0
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<realigned_saves>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stp	x20, x21, [sp]
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x17, #0x7               // =7
               	mul	x20, x0, x17
               	mov	x17, #0xb               // =11
               	mul	x21, x0, x17
               	mov	x0, sp
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	add	x0, x20, x21
               	mov	x1, sp
               	ldrb	w2, [sp]
               	add	x2, x0, x2
               	and	x0, x1, #0x3f
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	add	x0, x2, x0
               	sub	sp, x29, #0x10
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e8              // =1000
               	b	<addr>

<far_alloca>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x90
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	mov	x19, sp
               	mov	x20, x0
               	add	x17, x20, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x21, sp
               	sub	x21, x21, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x21
               	mov	x17, #0x3               // =3
               	mul	x22, x20, x17
               	mov	x17, #0x5               // =5
               	mul	x23, x20, x17
               	mov	x17, #0x7               // =7
               	mul	x24, x20, x17
               	mov	x17, #0xb               // =11
               	mul	x25, x20, x17
               	mov	x17, #0xd               // =13
               	mul	x26, x20, x17
               	mov	x17, #0x11              // =17
               	mul	x27, x20, x17
               	mov	x17, #0x13              // =19
               	mul	x28, x20, x17
               	mov	x17, #0x17              // =23
               	mul	x16, x20, x17
               	str	x16, [x19, #0x78]
               	mov	x17, #0x1d              // =29
               	mul	x16, x20, x17
               	str	x16, [x19, #0x70]
               	mov	x17, #0x1f              // =31
               	mul	x16, x20, x17
               	str	x16, [x19, #0x68]
               	mov	x0, #0x1                // =1
               	strb	w0, [x19, #0x90]
               	mov	x1, #0x7                // =7
               	mov	x0, x21
               	bl	<addr>
               	cmp	x20, #0x5
               	b.ne	<addr>
               	add	x0, x22, x23
               	add	x0, x0, x24
               	add	x0, x0, x25
               	add	x0, x0, x26
               	ldrb	w1, [x19, #0x90]
               	add	x0, x0, x1
               	ldrb	w1, [x21]
               	add	x0, x0, x1
               	ldr	x28, [x19, #0x40]
               	ldp	x26, x27, [x19, #0x30]
               	ldp	x24, x25, [x19, #0x20]
               	ldp	x22, x23, [x19, #0x10]
               	ldp	x20, x21, [x19]
               	ldr	x19, [x19, #0x50]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mul	x0, x24, x25
               	madd	x0, x22, x23, x0
               	madd	x0, x26, x27, x0
               	ldr	x16, [x19, #0x78]
               	madd	x0, x28, x16, x0
               	ldr	x16, [x19, #0x70]
               	ldr	x17, [x19, #0x68]
               	madd	x0, x16, x17, x0
               	ldrb	w1, [x19, #0x90]
               	add	x0, x0, x1
               	ldrb	w1, [x21]
               	add	x0, x0, x1
               	ldr	x28, [x19, #0x40]
               	ldp	x26, x27, [x19, #0x30]
               	ldp	x24, x25, [x19, #0x20]
               	ldp	x22, x23, [x19, #0x10]
               	ldp	x20, x21, [x19]
               	ldr	x19, [x19, #0x50]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<folded_far>:
               	stp	x20, x21, [sp, #-0x180]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x170]
               	add	x29, sp, #0x170
               	mov	x19, sp
               	mov	x20, x0
               	add	x17, x20, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x21, sp
               	sub	x21, x21, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x21
               	mov	x17, #0x3               // =3
               	mul	x22, x20, x17
               	mov	x17, #0x5               // =5
               	mul	x23, x20, x17
               	mov	x0, #0x1                // =1
               	strb	w0, [x19, #0x40]
               	mov	x0, #0x2                // =2
               	strb	w0, [x19, #0x41]
               	mov	x1, #0x7                // =7
               	mov	x0, x21
               	bl	<addr>
               	sub	x0, x29, #0x130
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cmp	x20, #0x4
               	b.ne	<addr>
               	ldrb	w0, [x19, #0x40]
               	add	x0, x22, x0
               	ldrb	w1, [x19, #0x41]
               	add	x0, x0, x1
               	ldrb	w1, [x21]
               	add	x0, x0, x1
               	mov	sp, x19
               	ldp	x29, x30, [sp, #0x170]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	sub	x0, x29, #0x130
               	add	x0, x0, #0x1
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	ldrb	w0, [x19, #0x40]
               	madd	x0, x22, x23, x0
               	ldrb	w1, [x19, #0x41]
               	add	x0, x0, x1
               	ldrb	w1, [x21]
               	add	x0, x0, x1
               	mov	sp, x19
               	ldp	x29, x30, [sp, #0x170]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mul	x21, x20, x1
               	ldr	x1, [x0, #0x8]
               	mul	x22, x20, x1
               	ldr	x1, [x0, #0x10]
               	mul	x23, x20, x1
               	ldr	x1, [x0, #0x18]
               	mul	x24, x20, x1
               	ldr	x1, [x0, #0x20]
               	mul	x25, x20, x1
               	ldr	x1, [x0, #0x28]
               	mul	x26, x20, x1
               	ldr	x1, [x0, #0x30]
               	mul	x27, x20, x1
               	ldr	x0, [x0, #0x38]
               	mul	x28, x20, x0
               	mov	x0, x20
               	bl	<addr>
               	str	x0, [sp, #0x58]
               	add	x0, x20, #0x5
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	add	x0, x20, #0x1
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	mov	x0, x20
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	mov	x0, x20
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	sub	x0, x20, #0x1
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	mov	x0, x20
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	sub	x0, x20, #0x1
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x16, x16, x0
               	str	x16, [sp, #0x58]
               	sub	x0, x20, #0x2
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x1, x16, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mul	x2, x20, x2
               	cmp	x21, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	mul	x2, x20, x2
               	cmp	x22, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x10]
               	mul	x2, x20, x2
               	cmp	x23, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x18]
               	mul	x2, x20, x2
               	cmp	x24, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldr	x2, [x0, #0x20]
               	mul	x2, x20, x2
               	cmp	x25, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x28]
               	mul	x2, x20, x2
               	cmp	x26, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x30]
               	mul	x2, x20, x2
               	cmp	x27, x2
               	b.ne	<addr>
               	ldr	x0, [x0, #0x38]
               	mul	x0, x20, x0
               	cmp	x28, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x17, #0xed11            // =60689
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
