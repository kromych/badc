
struct_value_copy.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	movl	$0x1, %esi
               	movl	%esi, (%rax)
               	movl	$0x2, %edi
               	movl	%edi, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	cmpl	$0x2, %edx
               	je	<addr>
               	movq	%rdi, %rax
               	leave
               	retq
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	movl	%esi, (%rax)
               	movl	$0x7d0, %esi            # imm = 0x7D0
               	movl	%esi, 0x4(%rax)
               	movl	$0x32, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x3c, %ecx
               	movl	%ecx, 0x4(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movslq	(%rax), %rcx
               	cmpl	$0x32, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movslq	0x4(%rax), %rax
               	cmpl	$0x3c, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
