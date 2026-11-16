
file_scope_compound_literal_forms.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2b, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x7d, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0xfa0, %eax            # imm = 0xFA0
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
