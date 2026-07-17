
libc_time_widths.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3b0              // =944
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0xf200             // =61952
               	movk	x0, #0x2a05, lsl #16
               	movk	x0, #0x1, lsl #32
               	mov	x1, #0xca00             // =51712
               	movk	x1, #0x3b9a, lsl #16
               	bl	<addr>
               	mov	x0, #0xcd6500000000     // =225833675390976
               	movk	x0, #0x41ed, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	<addr>
               	mov	x20, x0
               	stur	x21, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	bl	<addr>
               	mov	x17, #0xcd00            // =52480
               	movk	x17, #0x63b0, lsl #16
               	cmp	x20, x17
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, x20
               	cset	x0, lt
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x18]
               	sub	x0, x0, x20
               	cmp	x0, #0x5
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>
