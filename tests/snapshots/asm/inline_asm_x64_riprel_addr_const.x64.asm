
inline_asm_x64_riprel_addr_const.x64:	file format elf64-x86-64

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

<stat_fn>:
               	movl	$0x5, %eax
               	retq

<glob_fn>:
               	movl	$0x7, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-<rip>, %rax # <addr>
               	leaq	-<rip>, %rbx # <addr>
               	leaq	<rip>, %r12 # <addr>
               	leaq	<rip>, %r13 # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x10, %rcx
               	cmpq	%rcx, %r12
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %r13
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	callq	*%rax
               	movq	%rax, 0x28(%rsp)
               	callq	*%rbx
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	addq	%r10, %rax
               	movl	(%r12), %ecx
               	addq	%rcx, %rax
               	movl	(%r13), %ecx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
