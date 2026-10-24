
ipv6_v6only_round_trip.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x20]
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x18]
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x1, #0x29               // =41
               	mov	x2, #0x1a               // =26
               	sub	x3, x29, #0x20
               	mov	x4, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x1, #0x29               // =41
               	mov	x2, #0x1a               // =26
               	sub	x3, x29, #0x10
               	sub	x4, x29, #0x8
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x10]
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x1, #0x29               // =41
               	mov	x2, #0x1a               // =26
               	sub	x3, x29, #0x18
               	mov	x4, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x29               // =41
               	mov	x2, #0x1a               // =26
               	sub	x3, x29, #0x10
               	sub	x4, x29, #0x8
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x10]
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
