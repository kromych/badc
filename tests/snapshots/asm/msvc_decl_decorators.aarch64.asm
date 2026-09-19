
msvc_decl_decorators.aarch64:	file format elf64-littleaarch64

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

<exported>:
               	mov	x0, #0x3                // =3
               	ret

<main>:
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	add	x0, x0, #0x3
               	str	w0, [x1]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
