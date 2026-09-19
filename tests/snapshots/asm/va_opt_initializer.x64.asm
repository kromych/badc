
va_opt_initializer.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	leaq	0x8(%rsi), %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	0x8(%rsi), %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	leaq	0x8(%rsi), %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	0x8(%rsi), %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	leaq	0x8(%rsi), %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	leaq	0x8(%rsi), %rcx
               	movslq	%eax, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	movslq	%eax, %rdx
               	movsbq	(%rcx,%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x27, %rax
               	subq	$0x2, %rax
               	movslq	%eax, %rax
               	retq
