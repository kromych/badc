
aarch64_branch_word_in_a_data_section.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<target>:
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w0, [x1]
               	lsl	x2, x0, #6
               	sxtw	x2, w2
               	asr	x3, x2, #6
               	mov	x2, #0x5                // =5
               	eor	x0, x2, x0, lsr #26
               	cbnz	w0, <addr>
               	add	x0, x1, x3, lsl #2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
