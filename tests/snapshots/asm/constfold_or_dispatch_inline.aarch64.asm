
constfold_or_dispatch_inline.aarch64:	file format elf64-littleaarch64

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

<c0>:
               	mov	x1, #0x1                // =1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x0
               	sxtw	x0, w0
               	ret

<c1>:
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<c2>:
               	mov	x1, #0x1                // =1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	ret

<c3>:
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	mov	x2, #0xb                // =11
               	mov	x0, x2
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	mov	x0, #0xc                // =12
               	mov	x0, #0xe                // =14
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, #0xfffc             // =65532
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, x1
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	mov	x3, #0xfffd             // =65533
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x4, x3
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x2, #0xfffe             // =65534
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, x2
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, x2
               	mov	x3, x0
               	mov	x3, #0xfffe             // =65534
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x2, x0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x1, #0x2                // =2
               	mov	x1, #0x1                // =1
               	mov	x2, x1
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x2, x1
               	mov	x1, x0
               	mov	x0, #0x3                // =3
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0x2                // =2
               	mov	x3, x2
               	mov	x3, x0
               	mov	x0, #0x4                // =4
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0x3                // =3
               	mov	x3, x2
               	mov	x0, #0x2                // =2
               	mov	x0, #0x5                // =5
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0x4                // =4
               	mov	x3, x2
               	mov	x0, #0x3                // =3
               	mov	x0, #0x6                // =6
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0x5                // =5
               	mov	x3, x2
               	mov	x0, #0x4                // =4
               	mov	x0, #0x7                // =7
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0x6                // =6
               	mov	x3, x2
               	mov	x0, #0x5                // =5
               	mov	x0, #0x8                // =8
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	mov	x0, #0x7                // =7
               	mov	x0, #0x6                // =6
               	mov	x0, #0x9                // =9
               	mov	x0, #0x0                // =0
               	ret
