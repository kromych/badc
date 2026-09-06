
designator_override_and_braced_string.aarch64:	file format elf64-littleaarch64

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

<take>:
               	ldrb	w1, [x0]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x62              // =98
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0xc]
               	mov	x17, #0x4               // =4
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0xd]
               	mov	x17, #0x6               // =6
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0xe]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x5]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	sub	x1, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldrb	w10, [x2, #0x4]
               	strb	w10, [x1, #0x4]
               	ldrb	w10, [x2, #0x5]
               	strb	w10, [x1, #0x5]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x1                // =1
               	mov	x3, x2
               	mov	x3, x2
               	mov	x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
