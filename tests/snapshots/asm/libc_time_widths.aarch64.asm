
libc_time_widths.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0xf200             // =61952
               	movk	x0, #0x2a05, lsl #16
               	movk	x0, #0x1, lsl #32
               	mov	x1, #0xca00             // =51712
               	movk	x1, #0x3b9a, lsl #16
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	stur	xzr, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x17, #0xcd00            // =52480
               	movk	x17, #0x63b0, lsl #16
               	cmp	x20, x17
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, x20
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x8]
               	sub	x0, x0, x20
               	cmp	x0, #0x5
               	b.le	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
