
asm_label_names_the_assembler_symbol.aarch64:	file format elf64-littleaarch64

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

<asm_label_raw_def>:
               	mov	x0, #0x5                // =5
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	w0, #0x2
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0x3
               	b.ne	<addr>
               	bl	<addr>
               	cmp	w0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>

<asm_label_two>:
               	mov	w0, #0x2                // =2
               	ret

<asm_label_raw>:
               	mov	w0, #0x3                // =3
               	ret

<call_five>:
               	b	<addr>
