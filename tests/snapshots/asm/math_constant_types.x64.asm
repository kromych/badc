
math_constant_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movl	$0x7fc00000, (%rsp)     # imm = 0x7FC00000
               	movl	(%rsp), %eax
               	movl	$0xffc00000, %r11d      # imm = 0xFFC00000
               	andq	%r11, %rax
               	cmpl	$0x7fc00000, %eax       # imm = 0x7FC00000
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	comiss	<rip>, %xmm0 # <addr>
               	jbe	<addr>
               	movl	$0x7fc00000, 0x8(%rsp)  # imm = 0x7FC00000
               	movl	0x8(%rsp), %eax
               	shrq	$0x1f, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffc00000, 0x8(%rsp)  # imm = 0xFFC00000
               	movl	0x8(%rsp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
