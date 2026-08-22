
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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	ldr	x0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0xbad1             // =47825
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x8
               	cmp	x0, x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xbad2             // =47826
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	str	x0, [x1]
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mrs	x22, TPIDR_EL0
               	add	x22, x22, #0x0, lsl #12 // =0x0
               	add	x22, x22, #0x10
               	ldr	x0, [x22]
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	cmp	x0, x24
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
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
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x23, #0x0               // =0
               	mov	x1, #0x2                // =2
               	mov	x0, x23
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x20, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x9, x20
               	mov	x1, x23
               	mov	x3, x23
               	blr	x9
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	mov	x9, x21
               	blr	x9
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldr	x0, [x22]
               	cmp	x0, x24
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	x0, [x22]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x8
               	cmp	x0, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x10
               	mov	x22, #0x0               // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x9, x20
               	mov	x1, x22
               	mov	x3, x22
               	blr	x9
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	mov	x9, x21
               	blr	x9
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
