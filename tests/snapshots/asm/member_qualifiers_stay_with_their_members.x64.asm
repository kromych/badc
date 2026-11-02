
member_qualifiers_stay_with_their_members.x64:	file format elf64-x86-64

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

<first>:
               	movsbq	(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	*%rax
               	leaq	-0x61(%rax), %rbx
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	*%rax
               	addq	%rbx, %rax
               	subq	$0x62, %rax
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	subq	$0x2, %rax
               	popq	%rbx
               	leave
               	retq
