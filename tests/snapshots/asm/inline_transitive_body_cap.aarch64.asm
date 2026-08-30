
inline_transitive_body_cap.aarch64:	file format elf64-littleaarch64

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

<mix>:
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	add	x1, x1, #0x1
               	lsr	x2, x1, #2
               	eor	x1, x1, x2
               	lsl	x2, x1, #3
               	add	x1, x1, x2
               	lsr	x2, x1, #5
               	eor	x1, x1, x2
               	lsl	x2, x1, #7
               	add	x1, x1, x2
               	lsr	x2, x1, #11
               	eor	x1, x1, x2
               	lsl	x2, x1, #13
               	add	x1, x1, x2
               	lsr	x2, x1, #17
               	eor	x2, x1, x2
               	add	x1, x0, #0x1
               	mov	x17, #0x5               // =5
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	lsr	x3, x1, #2
               	eor	x1, x1, x3
               	lsl	x3, x1, #3
               	add	x1, x1, x3
               	lsr	x3, x1, #5
               	eor	x1, x1, x3
               	lsl	x3, x1, #7
               	add	x1, x1, x3
               	lsr	x3, x1, #11
               	eor	x1, x1, x3
               	lsl	x3, x1, #13
               	add	x1, x1, x3
               	lsr	x3, x1, #17
               	eor	x1, x1, x3
               	add	x2, x2, x1
               	add	x1, x0, #0x2
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	lsr	x3, x1, #2
               	eor	x1, x1, x3
               	lsl	x3, x1, #3
               	add	x1, x1, x3
               	lsr	x3, x1, #5
               	eor	x1, x1, x3
               	lsl	x3, x1, #7
               	add	x1, x1, x3
               	lsr	x3, x1, #11
               	eor	x1, x1, x3
               	lsl	x3, x1, #13
               	add	x1, x1, x3
               	lsr	x3, x1, #17
               	eor	x1, x1, x3
               	add	x1, x2, x1
               	add	x0, x0, #0x3
               	mov	x17, #0xb               // =11
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	lsr	x2, x0, #2
               	eor	x0, x0, x2
               	lsl	x2, x0, #3
               	add	x0, x0, x2
               	lsr	x2, x0, #5
               	eor	x0, x0, x2
               	lsl	x2, x0, #7
               	add	x0, x0, x2
               	lsr	x2, x0, #11
               	eor	x0, x0, x2
               	lsl	x2, x0, #13
               	add	x0, x0, x2
               	lsr	x2, x0, #17
               	eor	x0, x0, x2
               	add	x0, x1, x0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	bl	<addr>
               	mov	x21, x0
               	ldr	x0, [x20]
               	add	x0, x0, #0x1
               	bl	<addr>
               	add	x21, x21, x0
               	ldr	x0, [x20]
               	add	x0, x0, #0x2
               	bl	<addr>
               	add	x21, x21, x0
               	ldr	x0, [x20]
               	add	x0, x0, #0x3
               	bl	<addr>
               	add	x0, x21, x0
               	mov	x17, #0x8adc            // =35548
               	movk	x17, #0xac62, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
