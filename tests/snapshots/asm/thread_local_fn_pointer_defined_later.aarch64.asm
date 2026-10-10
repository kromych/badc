
thread_local_fn_pointer_defined_later.aarch64:	file format elf64-littleaarch64

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

<fb>:
               	mov	x0, #0x32               // =50
               	ret

<f0>:
               	mov	x0, #0x64               // =100
               	ret

<f1_ext>:
               	mov	x0, #0xc8               // =200
               	ret

<f2>:
               	mov	x0, #0x12c              // =300
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldr	x0, [x0]
               	blr	x0
               	cmp	x0, #0x64
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	blr	x0
               	cmp	x0, #0xc8
               	cset	x0, eq
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	blr	x0
               	cmp	x0, #0x12c
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	ldr	x0, [x0, #0x8]
               	blr	x0
               	cmp	x0, #0x64
               	cset	x0, eq
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	cset	x0, eq
               	cbz	x0, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x30
               	ldr	x0, [x0, #0x8]
               	blr	x0
               	cmp	x0, #0x12c
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x1, x2
               	cmp	x1, #0x4
               	cset	x1, eq
               	cbz	x1, <addr>
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x40
               	ldr	x1, [x1, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x1, x2
               	cmp	x1, #0x8
               	cset	x1, eq
               	cbz	x1, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x40
               	ldr	x0, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x0, x1
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
