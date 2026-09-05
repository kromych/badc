
int128_scalar_result.x64:	file format elf64-x86-64

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

<via_variadic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xa0(%rbp,%riz)
               	movsd	%xmm1, -0x90(%rbp,%riz)
               	movsd	%xmm2, -0x80(%rbp,%riz)
               	movsd	%xmm3, -0x70(%rbp,%riz)
               	movsd	%xmm4, -0x60(%rbp,%riz)
               	movsd	%xmm5, -0x50(%rbp,%riz)
               	movsd	%xmm6, -0x40(%rbp,%riz)
               	movsd	%xmm7, -0x30(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %r13
               	orq	%rdx, %r13
               	movq	%rcx, %rbx
               	orq	%rax, %rbx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %r14
               	orq	%rdx, %r14
               	movq	%rcx, %r12
               	orq	%rax, %r12
               	movl	$0x2, %edi
               	cmpq	%rbx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rbx, %r12
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r13, %r14
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r13
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movq	%r13, %rax
               	xorq	%r13, %rax
               	movq	%rbx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movq	%r13, %rax
               	xorq	%r13, %rax
               	movq	%rbx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r13
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rsi
               	xorq	$0x1, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	%rbx, %r12
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rbx, %r12
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r13, %r14
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rdx, %rax
               	orq	%rcx, %rax
               	leaq	(%rax,%rax,2), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movq	%r13, %rax
               	xorq	%r14, %rax
               	movq	%rbx, %rsi
               	xorq	%r12, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%rax,%rax,2), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%r13, %rsi
               	xorq	%rax, %rsi
               	movq	%rbx, %rdi
               	xorq	%rax, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%r13, %rsi
               	subq	%r13, %rsi
               	movq	%rbx, %rdi
               	subq	%rbx, %rdi
               	subq	$0x0, %rdi
               	xorq	%rax, %rsi
               	xorq	%rdi, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	%r13, %r14
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r13
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%r13, %rcx
               	xorq	%r13, %rcx
               	movq	%rbx, %rdx
               	xorq	%rbx, %rdx
               	movq	%rcx, %rsi
               	orq	%rdx, %rsi
               	testq	%rsi, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movq	%r13, %rcx
               	xorq	%r14, %rcx
               	movq	%rbx, %rdx
               	xorq	%r12, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	incq	%rcx
               	movslq	%ecx, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	cmpl	$0x1e, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6f, %eax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	0x1(%rax), %rsi
               	cmpq	%rax, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	$0x0, %rcx
               	addq	%rax, %rcx
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movq	%rsi, %rax
               	testq	%rcx, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rcx, %rcx
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x5, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpl	$0x5, %edx
               	jne	<addr>
               	xorq	$0x5, %rax
               	xorq	$0x0, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r13
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
