
int_to_float_assign_conversion.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0xa, %r9d
               	movb	%r9b, (%r11)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movl	$0x64, %r11d
               	movb	%r11b, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	addq	$0x2, %rdi
               	movl	$0xc8, %r11d
               	movb	%r11b, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm7
               	leaq	-0x10(%rbp), %r8
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm6
               	leaq	-0x18(%rbp), %r8
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm7
               	leaq	-0x20(%rbp), %r8
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	movss	-0x10(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	cvtsi2sd	%r9, %xmm7
               	mulsd	%xmm7, %xmm6
               	cvttsd2si	%xmm6, %r9
               	cmpq	$0x64, %r9
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movl	$0xa, %r8d
               	cvtsi2sd	%r8, %xmm7
               	mulsd	%xmm7, %xmm6
               	cvttsd2si	%xmm6, %r8
               	cmpq	$0x3e8, %r8             # imm = 0x3E8
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movss	-0x20(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movl	$0xa, %r9d
               	cvtsi2sd	%r9, %xmm7
               	mulsd	%xmm7, %xmm6
               	cvttsd2si	%xmm6, %r9
               	cmpq	$0x7d0, %r9             # imm = 0x7D0
               	je	<addr>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r9
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	cvtsi2sd	%r8, %xmm6
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x28(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movl	$0x64, %r9d
               	cvtsi2sd	%r9, %xmm6
               	mulsd	%xmm6, %xmm7
               	cvttsd2si	%xmm7, %r9
               	cmpq	$0x2710, %r9            # imm = 0x2710
               	je	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fd322d0e5604189, %r9 # imm = 0x3FD322D0E5604189
               	movss	-0x10(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r9, %xmm6
               	mulsd	%xmm7, %xmm6
               	movabsq	$0x3fe2c8b439581062, %r9 # imm = 0x3FE2C8B439581062
               	movss	-0x18(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r9, %xmm5
               	mulsd	%xmm7, %xmm5
               	addsd	%xmm5, %xmm6
               	movabsq	$0x3fbd2f1a9fbe76c9, %r9 # imm = 0x3FBD2F1A9FBE76C9
               	movss	-0x20(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movq	%r9, %xmm7
               	mulsd	%xmm5, %xmm7
               	addsd	%xmm7, %xmm6
               	movabsq	$0x4060000000000000, %r9 # imm = 0x4060000000000000
               	movq	%r9, %xmm15
               	subsd	%xmm15, %xmm6
               	leaq	-0x30(%rbp), %r9
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x30(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4045800000000000, %r9 # imm = 0x4045800000000000
               	movq	%r9, %xmm6
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm6
               	ucomisd	%xmm6, %xmm7
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x50(%rbp)
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movss	-0x30(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x4046000000000000, %r9 # imm = 0x4046000000000000
               	movq	%r9, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	ucomisd	%xmm7, %xmm6
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	movq	%r9, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x5, %r8d
               	movq	%r8, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r9d
               	cvtsi2sd	%r9, %xmm7
               	leaq	-0x40(%rbp), %r9
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movss	-0x40(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x401c000000000000, %r9 # imm = 0x401C000000000000
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
