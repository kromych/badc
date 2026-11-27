
fib.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<fib>:
               	cmp	w0, #0x2
               	b.lt	<addr>
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sxtw	x26, w0
               	mov	x27, #0x0               // =0
               	sub	x24, x26, #0x1
               	mov	x25, #0x0               // =0
               	cmp	w24, #0x2
               	b.lt	<addr>
               	sub	x22, x24, #0x1
               	mov	x23, #0x0               // =0
               	cmp	w22, #0x2
               	b.lt	<addr>
               	sub	x20, x22, #0x1
               	mov	x21, #0x0               // =0
               	cmp	w20, #0x2
               	b.lt	<addr>
               	sub	x0, x20, #0x1
               	bl	<addr>
               	sub	x20, x20, #0x2
               	add	x21, x21, x0
               	cmp	w20, #0x2
               	b.ge	<addr>
               	add	x1, x21, x20
               	sub	x22, x22, #0x2
               	add	x23, x23, x1
               	cmp	w22, #0x2
               	b.ge	<addr>
               	add	x1, x23, x22
               	sub	x24, x24, #0x2
               	add	x25, x25, x1
               	cmp	w24, #0x2
               	b.ge	<addr>
               	add	x0, x25, x24
               	sub	x26, x26, #0x2
               	add	x27, x27, x0
               	cmp	w26, #0x2
               	b.ge	<addr>
               	add	x0, x27, x26
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x17, #0x1a6d            // =6765
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
