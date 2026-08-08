
cast_fn_ptr_named_param_scope.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<inc>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa                // =10
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x20, w0
               	mov	x1, #0x14               // =20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x1, w0
               	cmp	x20, #0xb
               	cset	x3, eq
               	mov	x0, #0x0                // =0
               	cbz	x3, <addr>
               	cmp	x1, #0x15
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
