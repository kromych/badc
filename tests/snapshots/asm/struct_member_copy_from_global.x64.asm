
struct_member_copy_from_global.x64:	file format elf64-x86-64

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

<new_client>:
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	cmpl	$-0x1, %edx
               	jl	<addr>
               	movq	%rcx, %rax
               	incq	%rax
               	incq	%rax
               	xorq	%rcx, %rcx
               	addq	$0x0, %rax
               	movslq	%eax, %rax
               	retq
               	movabsq	$-0x64, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	callq	<addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
