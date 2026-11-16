
inline_asm_named_operands.aarch64:	file format elf64-littleaarch64

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

<move_named>:
               	sxtw	x0, w0
               	mov	w0, w0
               	ret

<add_mixed>:
               	add	x0, x0, x1
               	ret

<modifier_named>:
               	sxtw	x0, w0
               	add	w0, w0, w0
               	ret

<rw_named>:
               	mov	w0, w0
               	add	w0, w0, #0x5
               	ret

<main>:
               	mov	x16, #0x7               // =7
               	mov	w0, w16
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x1e              // =30
               	mov	x17, #0xc               // =12
               	add	x0, x16, x17
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x16, #0x15              // =21
               	add	w0, w16, w16
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x25               // =37
               	add	w0, w0, #0x5
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x2a               // =42
               	ret
