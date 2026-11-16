
struct_member_copy_from_global.aarch64:	file format elf64-littleaarch64

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

<new_client>:
               	adrp	x0, <page>
               	ldr	w1, [x0, #0x10]
               	mov	x2, #0x9                // =9
               	str	w2, [x0, #0x10]
               	mov	x0, #0x1                // =1
               	mov	x2, #-0x64              // =-100
               	cmn	w1, #0x1
               	csel	x0, x0, x2, ge
               	add	x0, x0, #0x1
               	add	x0, x0, #0x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x10]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
