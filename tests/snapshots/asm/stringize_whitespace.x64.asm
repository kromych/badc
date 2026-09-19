
stringize_whitespace.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
