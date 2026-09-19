
flexible_array_member_after_tentative_def.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	ldr	x0, [x2, #0x10]
               	cmp	x0, #0x16
               	b.ne	<addr>
               	ldr	x0, [x3, #0x10]
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x4]
               	cmp	x0, x4
               	b.ne	<addr>
               	ldr	x0, [x2]
               	cmp	x0, x2
               	b.ne	<addr>
               	ldr	x0, [x3]
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x0, [x4, #0x8]
               	cmp	x0, x4
               	b.ne	<addr>
               	ldr	x0, [x2, #0x8]
               	cmp	x0, x2
               	b.ne	<addr>
               	ldr	x0, [x3, #0x8]
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x0, x4, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x0, x2, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x0, x3, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x0, [x4, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldr	x0, [x2, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldr	x0, [x2, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldr	x0, [x2, #0x38]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldr	x0, [x3, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldr	x0, [x3, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w5, [x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x0]
               	ldrb	w6, [x1]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w5, [x0]
               	cbnz	x5, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	add	x1, x2, #0x40
               	cmp	x4, x1
               	mov	x0, #0x0                // =0
               	b.hs	<addr>
               	add	x5, x4, #0x30
               	cmp	x2, x5
               	cset	x5, lo
               	sxtw	x5, w5
               	cbnz	x5, <addr>
               	add	x5, x3, #0x38
               	cmp	x4, x5
               	b.hs	<addr>
               	add	x4, x4, #0x30
               	cmp	x3, x4
               	cset	x4, lo
               	sxtw	x4, w4
               	cbnz	x4, <addr>
               	cmp	x2, x5
               	b.hs	<addr>
               	cmp	x3, x1
               	cset	x1, lo
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x5, x0
               	b	<addr>
