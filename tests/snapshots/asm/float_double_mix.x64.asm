
float_double_mix.x64:	file format elf64-x86-64

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
               	movabsq	$0x3fb999999999999a, %rax # imm = 0x3FB999999999999A
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x8(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movabsq	$0x3fc999999999999a, %rax # imm = 0x3FC999999999999A
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movsd	-0x10(%rbp,%riz), %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	movabsq	$0x3fd3333334cccccd, %rax # imm = 0x3FD3333334CCCCCD
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	ucomisd	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	jmp	<addr>
               	movabsq	$0x3cd203af9ee75616, %rax # imm = 0x3CD203AF9EE75616
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x3fb999999999999a, %rax # imm = 0x3FB999999999999A
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x8(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x3fb99999a0000000, %rax # imm = 0x3FB99999A0000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	ucomisd	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	jmp	<addr>
               	movabsq	$0x3c670ef54646d497, %rax # imm = 0x3C670EF54646D497
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x3fbf9add3746f62e, %rax # imm = 0x3FBF9ADD3746F62E
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movabsq	$0x3fbf9add3b84e659, %rax # imm = 0x3FBF9ADD3B84E659
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x18(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x10(%rbp,%riz), %xmm0
               	movss	-0x18(%rbp,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	leaq	-0x20(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x20(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movss	-0x20(%rbp,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movss	-0x20(%rbp,%riz), %xmm0
               	movabsq	$0x3e45798ee2308c3a, %rax # imm = 0x3E45798EE2308C3A
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movss	-0x10(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	-0x8(%rbp,%riz), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	subsd	%xmm15, %xmm1
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm0
               	ucomisd	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	jmp	<addr>
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movabsq	$0x3fd555555fb67c87, %rax # imm = 0x3FD555555FB67C87
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x18(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x10(%rbp,%riz), %xmm0
               	movss	-0x18(%rbp,%riz), %xmm1
               	subss	%xmm1, %xmm0
               	leaq	-0x20(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x20(%rbp,%riz), %xmm0
               	xorq	%rax, %rax
               	cvtsi2sd	%rax, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movss	-0x20(%rbp,%riz), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	jmp	<addr>
               	movss	-0x20(%rbp,%riz), %xmm0
               	movabsq	$0x3e7ad7f29abcaf48, %rax # imm = 0x3E7AD7F29ABCAF48
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
