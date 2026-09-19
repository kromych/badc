
wide_string_struct_member.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x69, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
