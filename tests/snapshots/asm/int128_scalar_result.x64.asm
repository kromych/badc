
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
               	movl	(%rax), %eax
               	leaq	-0x18(%rbp), %rcx
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
               	movl	(%rcx), %ecx
               	movl	%ecx, <rip> # <addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	movq	%r10, 0x20(%rsp)
               	movl	$0x2, %edi
               	cmpq	%rbx, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rbx, %r8
               	sete	%al
               	movzbq	%al, %rax
               	movq	0x20(%rsp), %rcx
               	cmpq	0x28(%rsp), %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rax, %rsi
               	movl	$0x4d, %edx
               	movq	%r8, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	cmpq	%r8, %rbx
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r8, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	movq	0x28(%rsp), %rcx
               	cmpq	0x20(%rsp), %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rax, %rsi
               	movl	$0x4d, %edx
               	movq	%r8, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	movl	$0x4d, %edx
               	movq	%r8, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	xorl	%esi, %esi
               	movl	$0x4d, %edx
               	movq	%r8, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	movl	$0x4d, %edx
               	movq	%r8, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	cmpq	%r8, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	0x28(%rsp), %rdx
               	cmpq	0x20(%rsp), %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rsi
               	xorq	$0x1, %rsi
               	movl	$0x4d, %edx
               	movq	%r8, 0x18(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x18(%rsp), %r8
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4d, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	%rbx, %r8
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rbx, %r8
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	cmpq	%rdx, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
               	movq	%rax, %rdi
               	orq	%rsi, %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	cmpl	$0x3, %edi
               	jne	<addr>
               	xorq	%rdx, %rcx
               	movq	%rbx, %rdx
               	xorq	%r8, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	0x28(%rsp), %rcx
               	orq	%rbx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x28(%rsp), %rcx
               	xorq	0x20(%rsp), %rcx
               	movq	%rbx, %rdx
               	xorq	%r8, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	incq	%rcx
               	movl	-0x10(%rbp,%rcx,4), %eax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	leaq	0x1(%rax), %rsi
               	cmpq	%rax, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rax, %rcx
               	incq	%rdx
               	movq	%rsi, %rax
               	testq	%rcx, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x5, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
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
               	leave
               	retq
               	cmpq	%r8, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	0x28(%rsp), %rdx
               	cmpq	0x20(%rsp), %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
