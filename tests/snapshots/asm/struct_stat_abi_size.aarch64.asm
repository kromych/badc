
struct_stat_abi_size.aarch64:	file format elf64-littleaarch64

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
               	sub	x20, x29, #0x98
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x20, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x20, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x20, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x20, #0x13]
               	ldrb	w10, [x0, #0x14]
               	strb	w10, [x20, #0x14]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	sxtw	x22, w21
               	cmp	x22, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10               // =16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x20, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x80               // =128
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldr	x0, [x20, #0x30]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldrsw	x0, [x20, #0x10]
               	mov	x17, #0xf000            // =61440
               	and	x0, x0, x17
               	mov	x17, #0x8000            // =32768
               	cmp	x0, x17
               	b.eq	<addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x98
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
