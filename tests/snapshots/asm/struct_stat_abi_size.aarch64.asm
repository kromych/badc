
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
               	str	x20, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	sub	x0, x29, #0x98
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrb	w16, [x1, #0x14]
               	strb	w16, [x0, #0x14]
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x20, [sp], #0xc0
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x20, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x80               // =128
               	bl	<addr>
               	sub	x1, x29, #0x80
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x20, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x80
               	ldr	x1, [x0, #0x30]
               	cmp	x1, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x20, [sp], #0xc0
               	ret
               	ldrsw	x0, [x0, #0x10]
               	and	x0, x0, #0xf000
               	mov	x17, #0x8000            // =32768
               	cmp	w0, w17
               	b.eq	<addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x20, [sp], #0xc0
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x98
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x20, [sp], #0xc0
               	ret
