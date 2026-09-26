
naked_callee_pointer_argument.x64:	file format elf64-x86-64

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

<second>:
               	movq	0x8(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	callq	<addr>
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	0x10(%rax), %rdi
               	callq	<addr>
               	cmpq	$0x3333, %rax           # imm = 0x3333
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
