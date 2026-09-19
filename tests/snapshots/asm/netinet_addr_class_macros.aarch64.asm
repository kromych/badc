
netinet_addr_class_macros.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x2, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w2, [x0]
               	eor	x2, x2, #0xff
               	cbz	w2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x1]
               	eor	x2, x2, #0xff
               	cbnz	w2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x1]
               	cbnz	x2, <addr>
               	ldr	w2, [x1, #0x4]
               	cbnz	x2, <addr>
               	ldr	w2, [x1, #0x8]
               	cbnz	x2, <addr>
               	ldrb	w2, [x1, #0xc]
               	cbnz	x2, <addr>
               	ldrb	w2, [x1, #0xd]
               	cbnz	x2, <addr>
               	ldrb	w2, [x1, #0xe]
               	cbnz	x2, <addr>
               	ldrb	w1, [x1, #0xf]
               	eor	x1, x1, #0x1
               	cbz	w1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x0]
               	cbnz	x1, <addr>
               	ldr	w1, [x0, #0x4]
               	cbnz	x1, <addr>
               	ldr	w1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0xc]
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0xd]
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0xe]
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0xf]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	eor	x1, x1, #0xff
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x1]
               	and	x0, x0, #0xf
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
