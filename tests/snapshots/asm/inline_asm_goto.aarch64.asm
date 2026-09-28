
inline_asm_goto.aarch64:	file format elf64-littleaarch64

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

<take_or_fall>:
               	sxtw	x0, w0
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret

<pick>:
               	sxtw	x0, w0
               	cbz	w0, <addr>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x14               // =20
               	ret

<count_down>:
               	mov	x1, #0x0                // =0
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	cbnz	w2, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	ret

<same_target>:
               	sxtw	x0, w0
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ret

<splice_then_goto>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	w0, #0x1
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret

<phi_merge>:
               	sxtw	x1, w0
               	mov	x0, #0x5                // =5
               	cmp	w1, #0xa
               	b.le	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	cbnz	w1, <addr>
               	mov	x0, #0x7                // =7
               	b	<addr>

<main>:
               	mov	x16, #0x1               // =1
               	cbnz	w16, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x0               // =0
               	cbnz	w16, <addr>
               	mov	x16, #0x0               // =0
               	cbz	w16, <addr>
               	b	<addr>
               	mov	x16, #0x3               // =3
               	cbz	w16, <addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x0                // =0
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	cbnz	w2, <addr>
               	b	<addr>
               	b	<addr>
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x16, #0x0               // =0
               	cbnz	w16, <addr>
               	mov	x16, #0x1               // =1
               	cbnz	w16, <addr>
               	mov	x16, #0x1               // =1
               	cmp	w16, #0x1
               	b.gt	<addr>
               	mov	x16, #0x2               // =2
               	cmp	w16, #0x1
               	b.gt	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x16, #0x0               // =0
               	cbnz	w16, <addr>
               	mov	x16, #0x3               // =3
               	cbnz	w16, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x2a               // =42
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x2                // =2
               	ret
