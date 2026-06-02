
ssa_fp_compare_nan.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movq	%r11, %xmm0
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm0
               	movq	%xmm0, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movq	%r11, %xmm7
               	movq	%r11, %xmm15
               	divsd	%xmm15, %xmm7
               	xorq	%r11, %r11
               	movl	%r11d, -0x10(%rbp)
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	orq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm7
               	seta	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r11
               	orq	$0x2, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setbe	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	orq	$0x4, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setae	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	orq	$0x8, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm7
               	sete	%r11b
               	movzbq	%r11b, %r11
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r11
               	orq	$0x10, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	orq	$0x20, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	ucomisd	%xmm7, %xmm7
               	setb	%r11b
               	movzbq	%r11b, %r11
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	orq	$0x40, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	ucomisd	%xmm7, %xmm7
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	orq	$0x80, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x10(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
