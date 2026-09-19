
thread_local_address_per_thread.aarch64:	file format elf64-littleaarch64

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

<thread_main>:
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	ldr	x0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0xbad1             // =47825
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x2, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, #0x8
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x2, [x0]
               	ldrsw	x2, [x2]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0xbad2             // =47826
               	ret
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	str	x2, [x0]
               	mov	x0, #0x63               // =99
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x8
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x20, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	blr	x21
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	blr	x20
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x8
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	blr	x21
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	blr	x20
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
