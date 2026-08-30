
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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x3, x0
               	mov	x4, x1
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	cmp	w2, #0x0
               	b.le	<addr>
               	sub	x5, x3, x4
               	sub	x1, x2, #0x0
               	cmp	x5, x1
               	b.lo	<addr>
               	mov	x0, x3
               	mov	x2, x1
               	mov	x1, x4
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	sxtw	x1, w0
               	add	x5, x3, x1
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	strb	w6, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, w2
               	b.ge	<addr>
               	b	<addr>

<into_array>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x3, x0
               	mov	x2, x1
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	cmp	w2, #0x0
               	b.le	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x4, x1, x3
               	sub	x1, x2, #0x0
               	cmp	x4, x1
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, x1
               	mov	x1, x3
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sxtw	x1, w0
               	add	x4, x4, x1
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, w2
               	b.ge	<addr>
               	b	<addr>

<out_of_array>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x3, x0
               	mov	x2, x1
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	cmp	w2, #0x0
               	b.le	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x4, x3, x1
               	sub	x1, x2, #0x0
               	cmp	x4, x1
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, x1
               	mov	x1, x0
               	mov	x0, x3
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x3, x1
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, w2
               	b.ge	<addr>
               	b	<addr>

<blocked3>:
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x21, x1
               	stur	x2, [x29, #0x30]
               	ldur	w0, [x29, #0x30]
               	cmp	w0, #0x2
               	b.ls	<addr>
               	sub	x0, x20, x21
               	ldur	w1, [x29, #0x30]
               	mov	x22, #0xaaab            // =43691
               	movk	x22, #0xaaaa, lsl #16
               	movk	x22, #0xaaaa, lsl #32
               	movk	x22, #0xaaaa, lsl #48
               	umulh	x1, x1, x22
               	lsr	x1, x1, #1
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	cmp	x0, x1
               	b.lo	<addr>
               	ldur	w0, [x29, #0x30]
               	umulh	x0, x0, x22
               	lsr	x0, x0, #1
               	mov	x17, #0x3               // =3
               	mul	x2, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldur	w1, [x29, #0x30]
               	umulh	x0, x1, x22
               	lsr	x0, x0, #1
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x20, x20, x0
               	add	x21, x21, x0
               	mov	w0, w0
               	sub	x0, x1, x0
               	stur	w0, [x29, #0x30]
               	b	<addr>
               	add	x0, x20, #0x1
               	add	x1, x21, #0x1
               	ldrb	w2, [x21]
               	strb	w2, [x20]
               	ldur	w2, [x29, #0x30]
               	sub	x2, x2, #0x1
               	stur	w2, [x29, #0x30]
               	mov	x20, x0
               	mov	x21, x1
               	ldur	w0, [x29, #0x30]
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	add	sp, sp, #0x30
               	ret
               	b	<addr>
               	ldrb	w0, [x21]
               	strb	w0, [x20]
               	ldrb	w0, [x21, #0x1]
               	strb	w0, [x20, #0x1]
               	ldrb	w0, [x21, #0x2]
               	strb	w0, [x20, #0x2]
               	add	x20, x20, #0x3
               	add	x21, x21, #0x3
               	ldur	w0, [x29, #0x30]
               	sub	x0, x0, #0x3
               	stur	w0, [x29, #0x30]
               	ldur	w0, [x29, #0x30]
               	cmp	w0, #0x2
               	b.hi	<addr>
               	b	<addr>
               	b	<addr>

<walk1>:
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	stur	x2, [x29, #0x30]
               	ldur	w0, [x29, #0x30]
               	cmp	w0, #0x0
               	b.ls	<addr>
               	sub	x0, x20, x21
               	ldur	w1, [x29, #0x30]
               	cmp	x0, x1
               	b.lo	<addr>
               	ldur	w2, [x29, #0x30]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldur	w0, [x29, #0x30]
               	sub	x0, x0, x0
               	stur	w0, [x29, #0x30]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	add	sp, sp, #0x30
               	ret
               	b	<addr>
               	ldrb	w0, [x21]
               	strb	w0, [x20]
               	add	x20, x20, #0x1
               	add	x21, x21, #0x1
               	ldur	w0, [x29, #0x30]
               	sub	x0, x0, #0x1
               	stur	w0, [x29, #0x30]
               	ldur	w0, [x29, #0x30]
               	cmp	w0, #0x0
               	b.ls	<addr>
               	b	<addr>

<words4>:
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	stur	x2, [x29, #0x30]
               	ldur	w0, [x29, #0x30]
               	cmp	w0, #0x4
               	b.lo	<addr>
               	sub	x1, x20, x21
               	ldur	w0, [x29, #0x30]
               	mov	x17, #0x3               // =3
               	and	x2, x0, x17
               	sub	x0, x0, x2
               	lsl	x0, x0, #2
               	cmp	x1, x0
               	b.lo	<addr>
               	ldur	w0, [x29, #0x30]
               	mov	x17, #0x3               // =3
               	and	x1, x0, x17
               	sub	x0, x0, x1
               	lsl	x2, x0, #2
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldur	w0, [x29, #0x30]
               	mov	x17, #0x3               // =3
               	and	x1, x0, x17
               	sub	x1, x0, x1
               	mov	w1, w1
               	sub	x0, x0, x1
               	stur	w0, [x29, #0x30]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	add	sp, sp, #0x30
               	ret
               	b	<addr>
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
               	ldur	w0, [x29, #0x30]
               	sub	x0, x0, #0x4
               	stur	w0, [x29, #0x30]
               	ldur	w0, [x29, #0x30]
               	cmp	w0, #0x4
               	b.lo	<addr>
               	b	<addr>

<same>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x8, x0
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	sxtw	x21, w21
               	sxtw	x22, w22
               	mov	x4, #0xff               // =255
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x7, x5, x1
               	add	x2, x1, #0x1
               	and	x3, x2, x4
               	strb	w3, [x7]
               	add	x7, x6, x1
               	strb	w3, [x7]
               	add	x0, x1, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	add	x0, x20, x21
               	add	x1, x20, x22
               	mov	w2, w23
               	mov	x9, x8
               	blr	x9
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	add	x1, x5, x21
               	add	x2, x5, x22
               	mov	w0, w23
               	mov	x3, #0x0                // =0
               	stur	w3, [x29, #-0x8]
               	b	<addr>
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x1, x3
               	ldursw	x4, [x29, #-0x8]
               	add	x4, x2, x4
               	ldrb	w4, [x4]
               	strb	w4, [x3]
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	w3, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x8]
               	cmp	w3, w0
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	mov	x0, x20
               	mov	x1, x5
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x22, #0x0               // =0
               	b	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x22
               	mov	x3, x23
               	mov	x2, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x22
               	mov	x3, x23
               	mov	x2, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	add	x20, x23, #0x1
               	mov	w23, w20
               	cmp	w23, #0x14
               	b.ls	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	cmp	w21, #0x8
               	b.lt	<addr>
               	sxtw	x0, w22
               	add	x22, x0, #0x1
               	cmp	w22, #0x8
               	b.lt	<addr>
               	mov	x23, #0x0               // =0
               	b	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x2, x1, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x2, x17
               	strb	w3, [x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	strb	w3, [x4]
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	sxtw	x24, w23
               	add	x0, x21, x24
               	sxtw	x25, w22
               	add	x1, x21, x25
               	mov	x2, x20
               	bl	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x0, x4, x24
               	add	x1, x4, x25
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x0, x2
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x1, x3
               	ldrb	w3, [x3]
               	strb	w3, [x2]
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
               	cbnz	x0, <addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x14
               	b.le	<addr>
               	sxtw	x0, w22
               	add	x22, x0, #0x1
               	cmp	w22, #0x8
               	b.lt	<addr>
               	sxtw	x0, w23
               	add	x23, x0, #0x1
               	cmp	w23, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x2, x1, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x2, x17
               	strb	w3, [x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	strb	w3, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	add	x1, x20, #0x8
               	mov	x2, #0xfffd             // =65533
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x40               // =64
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x21, #0x0               // =0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x2, x1, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x2, x17
               	strb	w3, [x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	strb	w3, [x4]
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	sxtw	x23, w21
               	add	x0, x22, x23
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, x23
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x0, x2
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x1, x3
               	ldrb	w3, [x3]
               	strb	w3, [x2]
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	w2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	cmp	w2, w20
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	mov	x1, x0
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x2, x1, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x2, x17
               	strb	w3, [x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	strb	w3, [x4]
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	sxtw	x23, w21
               	add	x0, x22, x23
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, x23
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x1, x2
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x0, x3
               	ldrb	w3, [x3]
               	strb	w3, [x2]
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	w2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	cmp	w2, w20
               	b.lt	<addr>
               	mov	x2, #0x40               // =64
               	mov	x1, x0
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x14
               	b.le	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	cmp	w21, #0x8
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	add	x21, x20, #0x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x2, x1, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x2, x17
               	strb	w3, [x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	strb	w3, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x20, x21
               	cmp	x0, #0x9
               	b.lo	<addr>
               	mov	x2, #0x9                // =9
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x20, #0x9
               	add	x1, x21, #0x9
               	mov	x2, #0x2                // =2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x9
               	cmp	x0, x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x29
               	cmp	x1, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x20
               	mov	x2, #0x9                // =9
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x9]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x9]
               	cmp	w1, w0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x0
               	mov	x1, #0x304              // =772
               	movk	x1, #0x102, lsl #16
               	str	w1, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x0
               	str	w1, [x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x608              // =1544
               	movk	x1, #0x204, lsl #16
               	str	w1, [x0, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x90c              // =2316
               	movk	x1, #0x306, lsl #16
               	str	w1, [x0, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xc10              // =3088
               	movk	x1, #0x408, lsl #16
               	str	w1, [x0, #0xc]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xf14              // =3860
               	movk	x1, #0x50a, lsl #16
               	str	w1, [x0, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1218             // =4632
               	movk	x1, #0x60c, lsl #16
               	str	w1, [x0, #0x14]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x14]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x151c             // =5404
               	movk	x1, #0x70e, lsl #16
               	str	w1, [x0, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1820             // =6176
               	movk	x1, #0x810, lsl #16
               	str	w1, [x0, #0x1c]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x1c]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1b24             // =6948
               	movk	x1, #0x912, lsl #16
               	str	w1, [x0, #0x20]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1e28             // =7720
               	movk	x1, #0xa14, lsl #16
               	str	w1, [x0, #0x24]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x24]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x212c             // =8492
               	movk	x1, #0xb16, lsl #16
               	str	w1, [x0, #0x28]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2430             // =9264
               	movk	x1, #0xc18, lsl #16
               	str	w1, [x0, #0x2c]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x2c]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2734             // =10036
               	movk	x1, #0xd1a, lsl #16
               	str	w1, [x0, #0x30]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2a38             // =10808
               	movk	x1, #0xe1c, lsl #16
               	str	w1, [x0, #0x34]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x34]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2d3c             // =11580
               	movk	x1, #0xf1e, lsl #16
               	str	w1, [x0, #0x38]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3040             // =12352
               	movk	x1, #0x1020, lsl #16
               	str	w1, [x0, #0x3c]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2, #0x3c]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
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
               	mov	x0, x20
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
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
               	add	x0, x0, #0x3
               	add	x1, x1, #0x3
               	mov	x2, #0x2                // =2
               	b	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
