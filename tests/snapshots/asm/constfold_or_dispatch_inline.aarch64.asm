
constfold_or_dispatch_inline.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x1                // =1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sxtw	x0, w0
               	ret

<c1>:
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sxtw	x0, w0
               	ret

<c2>:
               	mov	x1, #0x1                // =1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x2
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sxtw	x0, w0
               	ret

<c3>:
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	add	x0, x0, #0x3
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x1                // =1
               	mov	x0, #0xb                // =11
               	mov	x0, #0x0                // =0
               	mov	x0, #0xc                // =12
               	mov	x0, #0x1                // =1
               	mov	x0, #0xb                // =11
               	mov	x0, #0x0                // =0
               	mov	x0, #0xe                // =14
               	mov	x0, #0x1                // =1
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x1                // =1
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x1                // =1
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x1                // =1
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x1                // =1
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x3                // =3
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x4                // =4
               	mov	x0, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x0, #0x0                // =0
               	mov	x0, #0x3                // =3
               	mov	x0, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5                // =5
               	mov	x0, #0x1                // =1
               	mov	x0, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x0, #0x4                // =4
               	mov	x0, #0x1                // =1
               	mov	x0, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x0, #0x6                // =6
               	mov	x0, #0x1                // =1
               	mov	x0, #0x4                // =4
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5                // =5
               	mov	x0, #0x1                // =1
               	mov	x0, #0x4                // =4
               	mov	x0, #0x0                // =0
               	mov	x0, #0x7                // =7
               	mov	x0, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x0, #0x0                // =0
               	mov	x0, #0x6                // =6
               	mov	x0, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x0, #0x0                // =0
               	mov	x0, #0x8                // =8
               	mov	x0, #0x1                // =1
               	mov	x0, #0x6                // =6
               	mov	x0, #0x0                // =0
               	mov	x0, #0x7                // =7
               	mov	x0, #0x1                // =1
               	mov	x0, #0x6                // =6
               	mov	x0, #0x0                // =0
               	mov	x0, #0x9                // =9
               	mov	x0, #0x0                // =0
               	ret
