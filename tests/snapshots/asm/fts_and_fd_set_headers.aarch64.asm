
fts_and_fd_set_headers.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0xe0]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	mov	x21, #0x0               // =0
               	sub	x1, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x1]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x1, #0x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	str	x21, [x0, #0x8]
               	mov	x1, #0x14               // =20
               	mov	x2, x21
               	bl	<addr>
               	mov	x20, x0
               	cbnz	x20, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldrh	w1, [x0, #0x5e]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldr	x2, [x0, #0x30]
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x2, <addr>
               	ldr	x1, [x0, #0x30]
               	ldrb	w1, [x1]
               	mov	x17, #0x2e              // =46
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldrh	w22, [x0, #0x40]
               	ldr	x0, [x0, #0x30]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	cmp	x22, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	b	<addr>
