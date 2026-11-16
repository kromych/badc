
struct_return_to_global.x64:	file format elf64-x86-64

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
               	movq	$0x6, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rsi, %rcx
               	imulq	$0xa, %rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	addq	$0x7, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	addq	$0x7, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x4e, %rax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq
