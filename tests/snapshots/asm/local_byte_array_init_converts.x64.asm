
local_byte_array_init_converts.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rsi
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rsi)
               	movzbq	0x4(%rax), %r10
               	movb	%r10b, 0x4(%rsi)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%rcx, %rdx
               	xorq	%rdi, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %edx
               	xorq	%rdi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	incq	%rax
               	leave
               	retq
