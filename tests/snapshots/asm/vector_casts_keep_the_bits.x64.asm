
vector_casts_keep_the_bits.x64:	file format elf64-x86-64

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
               	movabsq	$0x700000005, %rax      # imm = 0x700000005
               	movq	%rax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	-0x4(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzwq	-0x8(%rbp), %rax
               	movzwq	-0x6(%rbp), %rcx
               	movzwq	-0x4(%rbp), %rdx
               	movzwq	-0x2(%rbp), %rsi
               	movswq	%ax, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movswq	%cx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movswq	%dx, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movswq	%si, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
