
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
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rdi,%rax)
               	je	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rdi,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x3, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x5, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x65, %esi
               	movl	$0x5, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x1(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x5, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6c, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6c, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movsbq	0x4(%rdi), %rax
               	cmpl	$0x6f, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movb	$0x0, (%rdi)
               	movl	$0x3, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movsbq	0x2(%rdi), %rax
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	movb	$0x0, 0x3(%rdi)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movsbq	0x3(%rdi), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	leave
               	retq
               	movb	$0x61, (%rdi)
               	movl	$0x10, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rdi), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %edi
               	movl	$0x4, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
