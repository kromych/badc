
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
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
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
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %r12
               	orq	%rcx, %r12
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r13
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %r14
               	orq	%rcx, %r14
               	movl	$0x2, %edi
               	cmpq	%rbx, %r13
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rbx, %r13
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r12, %r14
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
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %edi
               	cmpq	%r13, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r13, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r12
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
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	%r12, %rax
               	xorq	%r12, %rax
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
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	%r12, %rax
               	xorq	%r12, %rax
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
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
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
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %edi
               	cmpq	%r13, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r13, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r12
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
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	cmpq	%rbx, %r13
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rbx, %r13
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r12, %r14
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movq	%r12, %rdx
               	xorq	%r14, %rdx
               	movq	%rbx, %rsi
               	xorq	%r13, %rsi
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdx
               	orq	%rbx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r12, %rdx
               	subq	%r12, %rdx
               	movq	%rbx, %rsi
               	subq	%rbx, %rsi
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	%r13, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r13, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r12
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movl	$0x1, %eax
               	movq	%r12, %rax
               	xorq	%r12, %rax
               	movq	%rbx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%r12, %rcx
               	xorq	%r14, %rcx
               	movq	%rbx, %rdx
               	xorq	%r13, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	incq	%rcx
               	movslq	(%rax,%rcx,4), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	0x1(%rax), %rsi
               	cmpq	%rax, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rax, %rcx
               	incq	%rdx
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
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	cmpq	%r13, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r13, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r12
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
