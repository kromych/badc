
fn_ptr_multi_deref.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	str	x20, [sp, #-0xa0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x4                // =4
               	mov	x2, #0x5                // =5
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x6                // =6
               	mov	x1, #0x7                // =7
               	mov	x9, x20
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
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
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
