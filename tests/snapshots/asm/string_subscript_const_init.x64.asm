
string_subscript_const_init.x64:	file format elf64-x86-64

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

<f>:
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x7a, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x73, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x6a, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
