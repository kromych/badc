
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
               	cmp	w1, #0x61
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x63
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x3]
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
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
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0xc]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xe]
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x68
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x6f
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x5]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x68
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x2]
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldrh	w16, [x1, #0x4]
               	strh	w16, [x0, #0x4]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
