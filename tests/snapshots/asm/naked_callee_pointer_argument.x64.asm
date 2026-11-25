
naked_callee_pointer_argument.x64:	file format elf64-x86-64

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

<second>:
               	movq	0x8(%rdi), %rax
               	retq

<main>:
               	subq	$0x38, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%rcx,4), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	<rip>, %rcx # <addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, 0x28(%rsp)
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	cmpq	$0x3333, %rax           # imm = 0x3333
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
