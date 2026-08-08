
fn_ptr_typedef_param_no_leak.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<cb>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	w0, w2
               	add	x0, x1, x0
               	str	w0, [x3]
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	blr	x9
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
