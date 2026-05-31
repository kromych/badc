
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %r11
               	movzwq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x520, %rsp            # imm = 0x520
               	leaq	-0x400(%rbp), %r11
               	movl	$0x7, %r9d
               	movw	%r9w, (%r11)
               	leaq	-0x400(%rbp), %r8
               	addq	$0x2, %r8
               	movl	$0xb, %r9d
               	movw	%r9w, (%r8)
               	leaq	-0x400(%rbp), %r11
               	movzwq	(%r11), %r11
               	movslq	%r11d, %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movl	%r11d, -0x510(%rbp)
               	jmp	<addr>
               	movslq	-0x510(%rbp), %r11
               	cmpq	$0x40, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x510(%rbp), %rax
               	movslq	(%rax), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%rax)
               	jmp	<addr>
               	leaq	-0x508(%rbp), %r11
               	movslq	-0x510(%rbp), %r8
               	movq	%r8, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r11
               	cvtsi2sd	%r8, %xmm7
               	movabsq	$0x3fd0000000000000, %r8 # imm = 0x3FD0000000000000
               	movq	%r8, %xmm15
               	mulsd	%xmm15, %xmm7
               	cvtsd2ss	%xmm7, %xmm15
               	movss	%xmm15, (%r11,%riz)
               	jmp	<addr>
               	leaq	-0x508(%rbp), %r11
               	addq	$0x20, %r11
               	movss	(%r11,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
               	leaq	-0x508(%rbp), %r8
               	movabsq	$0x4058c00000000000, %rax # imm = 0x4058C00000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r8,%riz)
               	leaq	-0x508(%rbp), %r8
               	movss	(%r8,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x520, %rsp            # imm = 0x520
               	popq	%rbp
               	retq
