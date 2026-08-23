
typedef_fn_ptr_struct_field.aarch64:	file format elf64-littleaarch64

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

<doer>:
               	mul	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x21, #0x3               // =3
               	mov	x1, #0x7                // =7
               	mov	x0, x21
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x20, #0x4               // =4
               	mov	x1, #0x5                // =5
               	mov	x0, x20
               	bl	<addr>
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x6                // =6
               	mov	x1, x20
               	bl	<addr>
               	cmp	w0, #0x18
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
