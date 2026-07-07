
thread_local_per_thread.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x400              // =1024
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x1, [x0]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xbad1             // =47825
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x1, #0x63               // =99
               	str	w1, [x0]
               	sxtw	x1, w1
               	cmp	x1, #0x63
               	b.eq	<addr>
               	mov	x0, #0xbad2             // =47826
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mrs	x21, TPIDR_EL0
               	add	x21, x21, #0x10
               	mov	x0, #0x1                // =1
               	str	w0, [x21]
               	mov	x20, #0x0               // =0
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x22, x0
               	sub	x0, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x9, x23
               	mov	x1, x20
               	mov	x3, x20
               	blr	x9
               	ldur	x0, [x29, #-0x20]
               	sub	x1, x29, #0x28
               	mov	x9, x22
               	blr	x9
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldrsw	x0, [x21]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
