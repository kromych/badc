
msvc_callconv.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	addq	$0x33, %rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x33, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq
