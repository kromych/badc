
float_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, -0x8(%rbp)
               	movabsq	$0x4004000000000000, %r9 # imm = 0x4004000000000000
               	movq	-0x8(%rbp), %r11
               	movq	%r11, %xmm7
               	movq	%r9, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x4010000000000000, %r8 # imm = 0x4010000000000000
               	movq	%r11, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r11
               	movq	%r9, %xmm7
               	movq	%r11, %xmm15
               	subsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r11
               	movq	%r11, %xmm7
               	movq	%r9, %xmm15
               	mulsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r11
               	movq	%r9, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x3ff999999999999a, %rax # imm = 0x3FF999999999999A
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r11b
               	movzbq	%r11b, %r11
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x3ffb333333333333, %rax # imm = 0x3FFB333333333333
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r11
               	movq	%r11, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%r11, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %r11
               	movq	%r11, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xb, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	cvtsi2sd	%rax, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x401c000000000000, %r9 # imm = 0x401C000000000000
               	movq	%rax, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%rax, %xmm7
               	movq	%r9, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r9
               	movq	%r9, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xf, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %r9 # imm = 0x3FE0000000000000
               	movq	%rax, %xmm7
               	movq	%r9, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x8, %r9
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ffb333333333333, %r9 # imm = 0x3FFB333333333333
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r9
               	movq	%r9, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x11, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
