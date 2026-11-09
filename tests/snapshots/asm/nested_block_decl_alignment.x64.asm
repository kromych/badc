
nested_block_decl_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	$0x3, <rip> # <addr>
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movb	$0x5, <rip> # <addr>
               	testb	$0x7f, %dl
               	jne	<addr>
               	movsbq	<rip>, %rdx # <addr>
               	cmpl	$0x5, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	addq	%rcx, %rdx
               	leaq	(%rsp), %rcx
               	movb	$0x7, (%rsp)
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	leaq	(%rsp), %rdx
               	movl	$0x9, (%rsp)
               	testb	$0x3f, %dl
               	jne	<addr>
               	movl	(%rsp), %eax
               	cmpl	$0x9, %eax
               	sete	%al
               	movzbq	%al, %rax
               	addq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
