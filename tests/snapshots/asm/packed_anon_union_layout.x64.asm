
packed_anon_union_layout.x64:	file format elf64-x86-64

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
               	subq	$0x190, %rsp            # imm = 0x190
               	leaq	-0x180(%rbp), %rax
               	leaq	0x80(%rax), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x80, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x80, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x8, %ecx
               	movl	%ecx, 0x3c(%rax)
               	movl	$0x14, %ecx
               	movl	%ecx, 0x44(%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movzbq	0x3c(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movzbq	0x44(%rax), %rax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
