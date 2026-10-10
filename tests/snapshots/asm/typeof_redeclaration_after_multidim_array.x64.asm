
typeof_redeclaration_after_multidim_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx      # <addr>
               	movq	$0x7, 0x7f8(%rcx)
               	leaq	<rip>, %rdx      # <addr>
               	movq	$0x9, 0xf8(%rdx)
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0x5, 0x2c(%rsi)
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x6, 0x10(%rdi)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x8, 0x10(%rax)
               	movq	0x7f8(%rcx), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movq	0xf8(%rdx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movl	0x2c(%rsi), %ecx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	0x10(%rdi), %ecx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
