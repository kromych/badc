
nested_block_decl_alignment.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movl	$0x1, %edx
               	cmovneq	%rax, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x5, <rip> # <addr>
               	testb	$0x7f, %cl
               	movl	$0x1, %esi
               	cmovneq	%rax, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	leaq	(%rsp), %rdx
               	movb	$0x7, (%rsp)
               	testb	$0x3f, %dl
               	movl	$0x1, %esi
               	cmovneq	%rax, %rsi
               	addq	%rsi, %rcx
               	leaq	(%rsp), %rdx
               	movl	$0x9, (%rsp)
               	testb	$0x3f, %dl
               	movl	$0x1, %esi
               	cmoveq	%rsi, %rax
               	addq	%rcx, %rax
               	movl	$0x2a, %ecx
               	cmpl	$0x4, %eax
               	cmoveq	%rcx, %rax
               	leave
               	retq
