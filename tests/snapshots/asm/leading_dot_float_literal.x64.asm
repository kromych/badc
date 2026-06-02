
leading_dot_float_literal.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movabsq	$0x3fd0000000000000, %r9 # imm = 0x3FD0000000000000
               	movabsq	$0x4039000000000000, %r8 # imm = 0x4039000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	movl	$0x1, %edi
               	movl	%edi, -0x28(%rbp)
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	<addr>
               	movabsq	$0x3fd0000000000000, %r11 # imm = 0x3FD0000000000000
               	movq	%r9, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	<addr>
               	movabsq	$0x4039000000000000, %r11 # imm = 0x4039000000000000
               	movq	%r8, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	<addr>
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x7, %r11d
               	movq	%r11, -0x30(%rbp)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movq	%r11, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
