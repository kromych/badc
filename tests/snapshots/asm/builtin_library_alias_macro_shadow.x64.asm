
builtin_library_alias_macro_shadow.x64:	file format elf64-x86-64

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

<__fortify_strlen>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	incq	%rax
               	leaq	(%rdi,%rax), %rcx
               	movsbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	movslq	(%r12), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	incq	%rax
               	leaq	(%rbx,%rax), %rcx
               	movsbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	(%r12), %rcx
               	incq	%rcx
               	movl	%ecx, (%r12)
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%r12), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movslq	(%r12), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$-0x3, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movl	$0x5, %edx
               	movq	%rbx, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x65, %esi
               	movl	$0x5, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x5, %edx
               	movq	%rbx, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x6c, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x6c, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x3(%rbx), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x6f, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %r12
               	xorq	%rax, %rax
               	movb	%al, (%r12)
               	movl	$0x3, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x6c, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movb	%al, 0x3(%rbx)
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x3(%rax), %rax
               	cmpl	$0x78, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x79, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x61, %eax
               	movb	%al, (%rdi)
               	movl	$0x10, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x61, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	movl	$0x2, %edi
               	movl	$0x4, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
