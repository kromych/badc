
tentative_deferred_array_ref_before_definition.x64:	file format elf64-x86-64

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
               	movslq	0x10(%rax), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	leaq	0xd8(%rax), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0x13, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x0, 0x48(%rax)
               	je	<addr>
               	movq	0x48(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x6d, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x48, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
