
loop_idiom_version.aarch64:	file format elf64-littleaarch64

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

<indexed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x3, x0
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	cmp	w2, #0x0
               	b.le	<addr>
               	sub	x4, x3, x1
               	cmp	x4, x2
               	b.lo	<addr>
               	mov	x0, x3
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.ge	<addr>
               	b	<addr>

<into_array>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x2, x0
               	sxtw	x3, w1
               	mov	x0, #0x0                // =0
               	cmp	w3, #0x0
               	b.le	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x4, x1, x2
               	cmp	x4, x3
               	b.lo	<addr>
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w4, [x2, x0]
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.ge	<addr>
               	b	<addr>

<out_of_array>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x2, x0
               	sxtw	x3, w1
               	mov	x0, #0x0                // =0
               	cmp	w3, #0x0
               	b.le	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x4, x2, x1
               	cmp	x4, x3
               	b.lo	<addr>
               	mov	x0, x2
               	mov	x2, x3
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.ge	<addr>
               	b	<addr>

<blocked3>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x0
               	mov	x20, x2
               	mov	x22, x1
               	cmp	w20, #0x2
               	b.ls	<addr>
               	sub	x4, x21, x22
               	mov	w0, w20
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x1, x0, x17
               	lsr	x2, x1, #33
               	mov	x17, #0x3               // =3
               	mul	x3, x2, x17
               	cmp	x4, x3
               	b.lo	<addr>
               	mov	x0, x21
               	mov	x2, x3
               	mov	x1, x22
               	bl	<addr>
               	mov	w1, w20
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x0, x1, x17
               	lsr	x0, x0, #33
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x21, x21, x0
               	add	x22, x22, x0
               	sub	x20, x1, x0
               	mov	w0, w20
               	cbz	x0, <addr>
               	add	x0, x21, #0x1
               	add	x1, x22, #0x1
               	ldrb	w2, [x22]
               	strb	w2, [x21]
               	sub	x20, x20, #0x1
               	mov	x21, x0
               	mov	x22, x1
               	mov	w0, w20
               	cbnz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrb	w0, [x22]
               	strb	w0, [x21]
               	ldrb	w0, [x22, #0x1]
               	strb	w0, [x21, #0x1]
               	ldrb	w0, [x22, #0x2]
               	strb	w0, [x21, #0x2]
               	add	x21, x21, #0x3
               	add	x22, x22, #0x3
               	sub	x20, x20, #0x3
               	cmp	w20, #0x2
               	b.hi	<addr>
               	b	<addr>

<walk1>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x0
               	mov	x20, x2
               	mov	x22, x1
               	cmp	w20, #0x0
               	b.ls	<addr>
               	sub	x0, x21, x22
               	mov	w2, w20
               	cmp	x0, x2
               	b.lo	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrb	w0, [x22]
               	strb	w0, [x21]
               	add	x21, x21, #0x1
               	add	x22, x22, #0x1
               	sub	x20, x20, #0x1
               	cmp	w20, #0x0
               	b.ls	<addr>
               	b	<addr>

<words4>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x22, x2
               	mov	x21, x1
               	cmp	w22, #0x4
               	b.lo	<addr>
               	sub	x4, x20, x21
               	mov	w0, w22
               	and	x1, x0, #0x3
               	sub	x2, x0, x1
               	lsl	x3, x2, #2
               	cmp	x4, x3
               	b.lo	<addr>
               	mov	x0, x20
               	mov	x2, x3
               	mov	x1, x21
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	w0, [x21]
               	str	w0, [x20]
               	ldr	w0, [x21, #0x4]
               	str	w0, [x20, #0x4]
               	ldr	w0, [x21, #0x8]
               	str	w0, [x20, #0x8]
               	ldr	w0, [x21, #0xc]
               	str	w0, [x20, #0xc]
               	add	x20, x20, #0x10
               	add	x21, x21, #0x10
               	sub	x22, x22, #0x4
               	cmp	w22, #0x4
               	b.lo	<addr>
               	b	<addr>

<same>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x4, x0
               	mov	x20, x3
               	sxtw	x23, w2
               	sxtw	x22, w1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	strb	w1, [x3, x0]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	add	x0, x21, x22
               	add	x1, x21, x23
               	mov	w2, w20
               	mov	x9, x4
               	blr	x9
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x0, x4, x22
               	add	x1, x4, x23
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x8]
               	ldrb	w3, [x1, x3]
               	strb	w3, [x0, x2]
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	w2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	cmp	w2, w20
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	mov	x0, x21
               	mov	x1, x4
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x22, #0x0               // =0
               	mov	x21, #0x0               // =0
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x22
               	mov	x3, x20
               	mov	x2, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x22
               	mov	x3, x20
               	mov	x2, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x14
               	b.ls	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x8
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x8
               	b.lt	<addr>
               	mov	x22, #0x0               // =0
               	mov	x21, #0x0               // =0
               	mov	x20, #0x0               // =0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	strb	w1, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	add	x0, x23, x22
               	add	x1, x23, x21
               	mov	x2, x20
               	bl	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x0, x4, x22
               	add	x1, x4, x21
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x8]
               	ldrb	w3, [x1, x3]
               	strb	w3, [x0, x2]
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	w2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	cmp	w2, w20
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	mov	x0, x23
               	mov	x1, x4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x14
               	b.le	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x8
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	strb	w1, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	add	x1, x21, #0x8
               	mov	x2, #-0x3               // =-3
               	mov	x0, x21
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x2, #0x40               // =64
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x23, #0x0               // =0
               	mov	x20, #0x0               // =0
               	mov	x0, #0x0                // =0
               	add	x1, x0, #0x1
               	strb	w1, [x21, x0]
               	strb	w1, [x22, x0]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	add	x0, x24, x23
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, x23
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x8]
               	ldrb	w3, [x1, x3]
               	strb	w3, [x0, x2]
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	w2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	cmp	w2, w20
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	mov	x1, x0
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	strb	w1, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	add	x0, x24, x23
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, x23
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x8]
               	ldrb	w3, [x0, x3]
               	strb	w3, [x1, x2]
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	w2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	cmp	w2, w20
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	mov	x1, x0
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x14
               	b.le	<addr>
               	add	x23, x23, #0x1
               	cmp	w23, #0x8
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	add	x21, x20, #0x20
               	mov	x0, #0x0                // =0
               	add	x1, x0, #0x1
               	strb	w1, [x20, x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	strb	w1, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x20, x21
               	cmp	x0, #0x9
               	b.lo	<addr>
               	mov	x2, #0x9                // =9
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x2, x20, #0x9
               	add	x0, x21, #0x9
               	mov	x1, #0x2                // =2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x3, x1, #0x9
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x2, x1, #0x29
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	mov	x2, #0x9                // =9
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x9]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x9]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x304              // =772
               	movk	x2, #0x102, lsl #16
               	str	w2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w2, [x1]
               	mov	x2, #0x608              // =1544
               	movk	x2, #0x204, lsl #16
               	str	w2, [x0, #0x4]
               	str	w2, [x1, #0x4]
               	mov	x2, #0x90c              // =2316
               	movk	x2, #0x306, lsl #16
               	str	w2, [x0, #0x8]
               	str	w2, [x1, #0x8]
               	mov	x2, #0xc10              // =3088
               	movk	x2, #0x408, lsl #16
               	str	w2, [x0, #0xc]
               	str	w2, [x1, #0xc]
               	mov	x2, #0xf14              // =3860
               	movk	x2, #0x50a, lsl #16
               	str	w2, [x0, #0x10]
               	str	w2, [x1, #0x10]
               	mov	x2, #0x1218             // =4632
               	movk	x2, #0x60c, lsl #16
               	str	w2, [x0, #0x14]
               	str	w2, [x1, #0x14]
               	mov	x2, #0x151c             // =5404
               	movk	x2, #0x70e, lsl #16
               	str	w2, [x0, #0x18]
               	str	w2, [x1, #0x18]
               	mov	x2, #0x1820             // =6176
               	movk	x2, #0x810, lsl #16
               	str	w2, [x0, #0x1c]
               	str	w2, [x1, #0x1c]
               	mov	x2, #0x1b24             // =6948
               	movk	x2, #0x912, lsl #16
               	str	w2, [x0, #0x20]
               	str	w2, [x1, #0x20]
               	mov	x2, #0x1e28             // =7720
               	movk	x2, #0xa14, lsl #16
               	str	w2, [x0, #0x24]
               	str	w2, [x1, #0x24]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x212c             // =8492
               	movk	x1, #0xb16, lsl #16
               	str	w1, [x20, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0, #0x28]
               	mov	x1, #0x2430             // =9264
               	movk	x1, #0xc18, lsl #16
               	str	w1, [x20, #0x2c]
               	str	w1, [x0, #0x2c]
               	mov	x1, #0x2734             // =10036
               	movk	x1, #0xd1a, lsl #16
               	str	w1, [x20, #0x30]
               	str	w1, [x0, #0x30]
               	mov	x1, #0x2a38             // =10808
               	movk	x1, #0xe1c, lsl #16
               	str	w1, [x20, #0x34]
               	str	w1, [x0, #0x34]
               	mov	x1, #0x2d3c             // =11580
               	movk	x1, #0xf1e, lsl #16
               	str	w1, [x20, #0x38]
               	str	w1, [x0, #0x38]
               	mov	x1, #0x3040             // =12352
               	movk	x1, #0x1020, lsl #16
               	str	w1, [x20, #0x3c]
               	str	w1, [x0, #0x3c]
               	mov	x21, #0x20              // =32
               	add	x1, x20, #0x20
               	mov	x2, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x20
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x21, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [x21, #0x18]
               	str	x10, [x20, #0x18]
               	ldr	x10, [x21, #0x20]
               	str	x10, [x20, #0x20]
               	ldr	x10, [x21, #0x28]
               	str	x10, [x20, #0x28]
               	ldr	x10, [x21, #0x30]
               	str	x10, [x20, #0x30]
               	ldr	x10, [x21, #0x38]
               	str	x10, [x20, #0x38]
               	ldr	x10, [sp], #0x10
               	add	x1, x20, #0x20
               	mov	x2, #0x3                // =3
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0x40               // =64
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrb	w0, [x21]
               	strb	w0, [x20]
               	ldrb	w0, [x21, #0x1]
               	strb	w0, [x20, #0x1]
               	ldrb	w0, [x21, #0x2]
               	strb	w0, [x20, #0x2]
               	add	x0, x20, #0x3
               	add	x1, x21, #0x3
               	ldrb	w2, [x1]
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x0, #0x2]
               	add	x0, x0, #0x3
               	add	x1, x1, #0x3
               	ldrb	w2, [x1]
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x0, #0x2]
               	add	x2, x0, #0x3
               	add	x0, x1, #0x3
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
