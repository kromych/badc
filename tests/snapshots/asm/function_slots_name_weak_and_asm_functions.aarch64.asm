
function_slots_name_weak_and_asm_functions.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	cmp	w0, #0x7
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp], #0x10
               	ret
               	udf	#0x0

<asm_fn>:
               	mov	w0, #0x7                // =7
               	ret
