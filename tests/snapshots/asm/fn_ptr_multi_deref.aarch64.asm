
fn_ptr_multi_deref.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x238
               	adrp	x20, <page>
               	add	x20, x20, #0x238
               	mov	x1, #0x4                // =4
               	mov	x2, #0x5                // =5
               	mov	x9, x0
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	mov	x1, #0x7                // =7
               	mov	x9, x20
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	cmp	x0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	sub	x1, x29, #0x68
               	mov	x2, #0xa                // =10
               	str	w2, [x1]
               	sub	x1, x29, #0x68
               	mov	x2, #0x1e               // =30
               	str	w2, [x1, #0x8]
               	ldrsw	x1, [x0]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
