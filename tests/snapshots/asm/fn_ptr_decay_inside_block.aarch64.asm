
fn_ptr_decay_inside_block.aarch64:	file format elf64-littleaarch64

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

<adder>:
               	add	x0, x0, #0x64
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	add	x20, x0, #0xcb
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	add	x0, x20, x0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	cmp	w0, #0x19a
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
