
global_self_referential_init.aarch64:	file format elf64-littleaarch64

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

<drop>:
               	mov	x17, #-0x1              // =-1
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	ldr	x2, [x1]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0, #0x18]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x30
               	ldr	x2, [x1]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0, #0x28]
               	add	x1, x0, #0x50
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0, #0x48]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x28]
               	sub	x1, x1, x0
               	add	x1, x0, x1
               	ldrsw	x1, [x1]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0]
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x54]
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w0, [x0, #0x8]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
