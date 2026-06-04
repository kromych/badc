
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
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	-0x8(%rbp), %rcx
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	addsd	%xmm15, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	subsd	%xmm15, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	mulsd	%xmm15, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movabsq	$0x400e000000000000, %rdx # imm = 0x400E000000000000
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movabsq	$0x3ff999999999999a, %rdx # imm = 0x3FF999999999999A
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %rcx
               	movabsq	$0x3ffb333333333333, %rdx # imm = 0x3FFB333333333333
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm0
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm0
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rcx, %xmm14
               	ucomisd	%xmm0, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %rcx
               	movq	%rcx, %xmm0
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	cvtsi2sd	%rax, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x401c000000000000, %rcx # imm = 0x401C000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ffb333333333333, %rax # imm = 0x3FFB333333333333
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%xmm0, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
