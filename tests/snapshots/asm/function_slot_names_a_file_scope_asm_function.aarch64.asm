
function_slot_names_a_file_scope_asm_function.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	blr	x0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	w0, #0x5
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp], #0x10
               	ret

<fsa_fn>:
               	mov	w0, #0x5                // =5
               	ret
