
stack_protector_canary.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<fill>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsbq	%dl, %rdx
               	testq	%rsi, %rsi
               	jbe	<addr>
               	leaq	(%rsi), %rax
               	movq	%rdx, %rsi
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

<aggregate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%fs:0x28, %r11
               	movq	%r11, -0x8(%rbp)
               	xorq	%r11, %r11
               	movl	$0x5, %esi
               	leaq	-0x20(%rbp), %rbx
               	movl	%esi, (%rbx)
               	leaq	0x4(%rbx), %rdi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x30(%rbp), %rax
               	pushq	%rcx
               	movq	(%rbx), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rbx), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rbx), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rbx), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rbx), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	movq	%rax, %rcx
               	movslq	(%rax), %rcx
               	movsbq	0xb(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%fs:0x28, %r11
               	movq	%r11, -0x8(%rbp)
               	xorq	%r11, %r11
               	movl	$0x9, %esi
               	movq	%rsi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	movl	$0x9, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsbq	0x8(%rbx), %rax
               	leaq	-0x30(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<over_aligned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%fs:0x28, %r11
               	movq	%r11, -0x8(%rbp)
               	xorq	%r11, %r11
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rbx
               	movl	$0x40, %esi
               	movl	$0x4, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsbq	0x3f(%rbx), %rax
               	leaq	-0x80(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<variadic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xc0(%rbp,%riz)
               	movsd	%xmm1, -0xb0(%rbp,%riz)
               	movsd	%xmm2, -0xa0(%rbp,%riz)
               	movsd	%xmm3, -0x90(%rbp,%riz)
               	movsd	%xmm4, -0x80(%rbp,%riz)
               	movsd	%xmm5, -0x70(%rbp,%riz)
               	movsd	%xmm6, -0x60(%rbp,%riz)
               	movsd	%xmm7, -0x50(%rbp,%riz)
               	movq	%rbx, (%rsp)
               	movq	%fs:0x28, %r11
               	movq	%r11, -0x8(%rbp)
               	xorq	%r11, %r11
               	xorq	%rbx, %rbx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x18, %esi
               	movslq	-0xf0(%rbp), %rdx
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	%rbx, %rax
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%ebx, %rcx
               	leaq	0x1(%rcx), %rbx
               	movslq	-0xf0(%rbp), %rcx
               	cmpl	%ecx, %ebx
               	jl	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%fs:0x28, %r11
               	movq	%r11, -0x8(%rbp)
               	xorq	%r11, %r11
               	leaq	-0x40(%rbp), %rbx
               	movl	$0x20, %esi
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsbq	(%rbx), %rcx
               	leaq	-0x40(%rbp), %rax
               	movsbq	0x1f(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rbx
               	movl	$0x10, %esi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsbq	(%rbx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rbx
               	movl	$0x10, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsbq	(%rbx), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rbx
               	movl	$0x10, %esi
               	movl	$0x7, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsbq	(%rbx), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movl	$0x1e, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x29, %eax
               	movl	%eax, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	-0x48(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	%fs:0x28, %r11
               	cmpq	-0x8(%rbp), %r11
               	je	<addr>
               	callq	<addr>
               	xorq	%r11, %r11
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
