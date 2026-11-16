
math_constant_types.x64:	file format elf64-x86-64

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
               	movl	$0x7fc00000, -0x10(%rbp) # imm = 0x7FC00000
               	movl	-0x10(%rbp), %eax
               	movl	$0xffc00000, %r11d      # imm = 0xFFC00000
               	andq	%r11, %rax
               	cmpl	$0x7fc00000, %eax       # imm = 0x7FC00000
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm1
               	jp	<addr>
               	je	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	comiss	%xmm2, %xmm1
               	jbe	<addr>
               	movl	$0x7fc00000, -0x8(%rbp) # imm = 0x7FC00000
               	movl	-0x8(%rbp), %eax
               	shrq	$0x1f, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffc00000, -0x8(%rbp) # imm = 0xFFC00000
               	movl	-0x8(%rbp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
