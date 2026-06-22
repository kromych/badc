
variadic_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<v8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xc0(%rbp)
               	movq	%rsi, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%r8, -0xa0(%rbp)
               	movq	%r9, -0x98(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0x90(%rbp,%riz)
               	movsd	%xmm1, -0x80(%rbp,%riz)
               	movsd	%xmm2, -0x70(%rbp,%riz)
               	movsd	%xmm3, -0x60(%rbp,%riz)
               	movsd	%xmm4, -0x50(%rbp,%riz)
               	movsd	%xmm5, -0x40(%rbp,%riz)
               	movsd	%xmm6, -0x30(%rbp,%riz)
               	movsd	%xmm7, -0x20(%rbp,%riz)
               	movq	%r13, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq

<v16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xc0(%rbp)
               	movq	%rsi, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%r8, -0xa0(%rbp)
               	movq	%r9, -0x98(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0x90(%rbp,%riz)
               	movsd	%xmm1, -0x80(%rbp,%riz)
               	movsd	%xmm2, -0x70(%rbp,%riz)
               	movsd	%xmm3, -0x60(%rbp,%riz)
               	movsd	%xmm4, -0x50(%rbp,%riz)
               	movsd	%xmm5, -0x40(%rbp,%riz)
               	movsd	%xmm6, -0x30(%rbp,%riz)
               	movsd	%xmm7, -0x20(%rbp,%riz)
               	movq	%r13, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x16, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq

<sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	movq	%r13, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movslq	%edx, %rax
               	movslq	-0xe0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %r13
               	movl	(%r13), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r13), %r10
               	addl	$0x8, (%r13)
               	jmp	<addr>
               	movq	0x8(%r13), %r10
               	addq	$0x8, 0x8(%r13)
               	movq	%r10, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rax
               	movslq	-0xe0(%rbp), %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x16, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movl	$0x1e, %ecx
               	movl	$0x28, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, -0xa8(%rbp)
               	movq	%rdx, -0xa0(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x64, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
