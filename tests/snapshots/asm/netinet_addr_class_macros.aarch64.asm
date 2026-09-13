
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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	mov	x1, #0x2ff              // =767
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	str	w2, [x0, #0x4]
               	str	w2, [x0, #0x8]
               	mov	x3, #0x1000000          // =16777216
               	str	w3, [x0, #0xc]
               	sub	x1, x29, #0x10
               	str	w2, [x1]
               	str	w2, [x1, #0x4]
               	str	w2, [x1, #0x8]
               	str	w3, [x1, #0xc]
               	ldrb	w2, [x0]
               	mov	x17, #0xff              // =255
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x3, x2
               	mov	x3, x2
               	ldrb	w3, [x1, #0xc]
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x1, #0xd]
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x1, #0xe]
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w1, [x1, #0xf]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x0]
               	cbnz	x1, <addr>
               	mov	x1, x2
               	ldrb	w1, [x0, #0xc]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w0, [x0, #0xe]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrb	w1, [x0]
               	mov	x17, #0xff              // =255
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	w0, #0x2
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
