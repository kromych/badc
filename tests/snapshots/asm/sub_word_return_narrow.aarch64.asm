
sub_word_return_narrow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	lsl	x0, x0, #8
               	sxtw	x0, w0
               	orr	x0, x1, x0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	ret

<u8_wrap>:
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x0, #0xc8
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	ret

<s16_shift>:
               	lsl	x0, x0, #8
               	sxtw	x1, w0
               	sxth	x0, w1
               	ret

<s8_wrap>:
               	add	x0, x0, #0x64
               	sxtw	x1, w0
               	sxtb	x0, w1
               	ret

<main>:
               	mov	x0, #0x3412             // =13330
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	lsl	x0, x0, #8
               	sxtw	x0, w0
               	orr	x0, x1, x0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x1234            // =4660
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x64               // =100
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x0, #0xc8
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x140              // =320
               	sxth	x0, w0
               	lsl	x0, x0, #8
               	sxtw	x1, w0
               	sxth	x0, w1
               	mov	x17, #0x4000            // =16384
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x64               // =100
               	sxtb	x0, w0
               	add	x0, x0, #0x64
               	sxtw	x1, w0
               	sxtb	x0, w1
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
